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

var loadBullet
var bullet

func _ready():
	player = $"/root/Game/Player"
	
	loadPhoton = load("res://Prefabs/Photon.tscn")
	rightPutin = SelectPutin(1, 5)
	get_node("Putin/" + rightPutin).playing = true
	DisablePutin()

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
	if rad2deg(self.global_rotation) > rad2deg(rotationZ) - 30 and rad2deg(self.global_rotation) < rad2deg(rotationZ) + 30:
		
		var photon = loadPhoton.instance()
		add_child(photon)
		lookCounter = lookCD
		#$Photon.daddy = self
		

func _physics_process(_delta):
	if alive:
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
		if !seePlayer:
			$EnemyAnimator/Gun.hide()
			$EnemyAnimator.play("Idle")
			$EnemyAnimator/Gun.play("Idle")
	
		if health <= 0:
			alive = false
			$EnemyAnimator.play("Death")
			if first:
				$EnemyAnimator.rotate(deg2rad(180))
				get_node("Putin/" + rightPutin).playing = false
				first = false
			$CollisionShape2D.set_deferred("disabled", true)
	else:
		$EnemyAnimator/Gun.hide()
