extends KinematicBody2D

export (int) var speed = 400
var mPos = Vector2()
var velocity = Vector2()
var difference = Vector3()
var rotationZ = float()
var fullMagazine = 6
var magazineCount = 4
export var health = 100
var alive = true
var hiding = false
var cameraOffset = 0
export var cameraOffsetLimit = 70

func _ready():
	$"Background music".playing = true

func get_input():
	if Input.is_action_pressed("reloding"):
		$"/root/Game".ReloadWeapon()
	
	if Input.is_action_pressed("ui_focus_next"):
		Hide()
	
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	if Input.is_action_pressed("restart"):
		$"/root/Game".RestartGame()
	if alive:
		get_input()
		velocity = move_and_slide(velocity)
	SeeFar(delta)

func SeeFar(delta):
	if Input.is_action_pressed("seeFar"):
		if cameraOffset < cameraOffsetLimit:
			$"Main camera".position += Vector2(delta * 200,0)
			cameraOffset += delta * 200
			$"Main camera/Test".text = str(cameraOffset)
	else:
		if cameraOffset > 0:
			$"Main camera".position -= Vector2(delta * 400,0)
			cameraOffset -= delta * 400
			$"Main camera/Test".text = str(cameraOffset)
		else:
			$"Main camera".position = Vector2(0,0)
			cameraOffset = 0
			$"Main camera/Test".text = str(cameraOffset)

func setHealth(damage):
	if health > 0:
		health -= damage

func Hide():
	if !hiding:
		hiding = true
		$Character.set_modulate(Color(1, 1, 1, 0.5))
		$"Player Idle col".disabled = true
		$"Player Shoot col".disabled = true
	else:
		hiding = false
		$Character.set_modulate(Color(1, 1, 1, 1))
		$"Player Idle col".disabled = false
		$"Player Shoot col".disabled = false

func kill():
	$"Player Idle col".disabled = true
	$"Player Shoot col".disabled = true
	$Character.hide()
	$Character/Gun.hide()
	alive = false

func RotateToCursor():
	mPos = get_global_mouse_position()
	difference = mPos - self.position
	rotationZ = atan2(difference.y, difference.x)
	self.rotate(rotationZ - self.rotation)
	$"Main camera".rotation = -self.global_rotation

func _process(_delta):
	if health <= 0:
		kill()
	if $"Background music".playing == false:
		$"Background music".playing = true
	if alive:
		RotateToCursor()
