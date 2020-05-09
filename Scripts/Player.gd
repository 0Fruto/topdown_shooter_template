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

func _ready():
	$"Background music".playing = true

func get_input():
	if Input.is_action_pressed("reloding"):
		get_node("../../Game").ReloadWeapon()
	
	
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

func _physics_process(_delta):
	if alive:
		get_input()
		velocity = move_and_slide(velocity)

func setHealth(damage):
	if health > 0:
		health -= damage

func kill():
	$"Player Idle col".disabled = true
	$"Player Shoot col".disabled = true
	$Character.hide()
	$Character/Gun.hide()
	alive = false

func _process(_delta):
	if health <= 0:
		kill()
	if $"Background music".playing == false:
		$"Background music".playing = true
	if alive:
		mPos = get_global_mouse_position()
		difference = mPos - self.position
		rotationZ = atan2(difference.y, difference.x)
		self.rotate(rotationZ - self.rotation)
		$"Main camera".rotation = -self.global_rotation
