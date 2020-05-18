extends KinematicBody2D


export var health = 100
var first = true
var rightPutin
var loadPhoton
var seePlayer = false
var lookCounter = 0
export var lookCD = 10
var player
var alive = true
var LastPlayerPos
export var waitForPlayer = 1
var waiting
export var distanceGoal = 0.5
var distance
var speed = 150

var radToRot
var rotateAround = false
var rotationCounter = 0
var rotationGoal = 0
var rotationDirection = 1
export var viewAngle = 50

var loadBullet
var bullet

func _ready():
	distance = distanceGoal
	waiting = waitForPlayer
	player = $"/root/Game/Player"
	loadPhoton = load("res://Prefabs/Photon.tscn")
	rightPutin = SelectPutin(1, 5)
	get_node("Putin/" + rightPutin).playing = true
	DisablePutin()

func ChooseAnimation(Name, Count):
	var NameNum = round(rand_range(1, Count))
	return(Name + str(NameNum))

func DisablePutin():
	$Putin/Putin1.playing = false
	$Putin/Putin2.playing = false
	$Putin/Putin3.playing = false
	$Putin/Putin4.playing = false
	$Putin/Putin5.playing = false

func setHealth(damage):
	health -= damage

func SelectPutin(RangeStart, RangeEnd):
	var putin = "Putin" + str(round(rand_range(RangeStart, RangeEnd)))
	return putin

func RotateTo(goal):
	var Pos = goal.global_position
	var difference = Pos - self.global_position
	var rotationZ = atan2(difference.y, difference.x)
	self.rotate(rotationZ - self.global_rotation)



func IsLookingOn(goal):
	var Pos = goal.global_position
	var difference = Pos - self.global_position
	var rotationZ = atan2(difference.y, difference.x)
	if rad2deg(self.global_rotation) > rad2deg(rotationZ) - viewAngle and rad2deg(self.global_rotation) < rad2deg(rotationZ) + viewAngle:
		
		var photon = loadPhoton.instance()
		add_child(photon)
		lookCounter = lookCD
		#$Photon.daddy = self

func RotateAngle(angle):
	radToRot = deg2rad(angle)
	self.rotate(radToRot) #- self.global_rotation
	
func RotateSlow(angle, delta):
	if rotationCounter < angle:
		rotationCounter += delta
		RotateAngle(1)
	
	if rotationCounter > angle:
		rotationCounter -= delta
		RotateAngle(-1)
	
	#radToRot = deg2rad(angle)
	#self.rotate(radToRot)

func GoTowards():
	var _move = self.move_and_slide(Vector2(speed * cos(global_rotation), speed * sin(global_rotation)))

func Die():
	alive = false
	$EnemyAnimator.play(str(ChooseAnimation("Death", 2)))
	if first:
		$EnemyAnimator.rotate(deg2rad(180))
		get_node("Putin/" + rightPutin).playing = false
		first = false
	$CollisionShape2D.set_deferred("disabled", true)

func _physics_process(delta):
	if alive:
		var _move = self.move_and_slide(Vector2(speed * delta * rand_range(10, 20) * cos(global_rotation), speed * delta * rand_range(10, 20) * sin(global_rotation)))
		var randomRot = rand_range(-1, 300)
		if randomRot < 0:
			rotationDirection = rotationDirection * -1
		RotateSlow(30 * rotationDirection, delta)
		
		if lookCounter > 0:
			lookCounter -= 1
		else:
			IsLookingOn(get_node("/root/Game/Player"))
	
		if seePlayer:
			$EnemyAnimator/Gun.show()
			$EnemyAnimator.play("Ready")
			$EnemyAnimator/Gun.play("Idle")
			RotateTo(player)
			$"..".Shoot()
			LastPlayerPos = player.global_position
			waiting = waitForPlayer
			distance = distanceGoal
		if !seePlayer:
			rotateAround = true
			$EnemyAnimator/Gun.hide()
			$EnemyAnimator.play("Idle")
			$EnemyAnimator/Gun.play("Idle")
			if LastPlayerPos:
				RotateAngle(30)
				RotateAngle(-60)
				RotateAngle(30)
				if waiting > 0:
					waiting -= delta
				else: if waiting <= 0:
					if distance > 0:
						GoTowards()
						distance -= delta
					else: if distance <= 0:
						RotateAngle(50)
						RotateAngle(-100)
						RotateAngle(50)
						waiting = waitForPlayer
	
		if health <= 0:
			Die()
	else:
		$EnemyAnimator/Gun.hide()
