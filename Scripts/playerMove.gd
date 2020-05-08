extends KinematicBody2D

export (int) var speed = 400
var mPos = Vector2()
var velocity = Vector2()
var difference = Vector3()
var rotationZ = float()
var fullMagazine = 6
var magazineCount = 4


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
	get_input()
	velocity = move_and_slide(velocity)

func _process(_delta):
	if $"Background music".playing == false:
		$"Background music".playing = true
	mPos = get_global_mouse_position()
	difference = mPos - self.position
	rotationZ = atan2(difference.y, difference.x)
	self.rotate(rotationZ - self.rotation)
	$"Main camera".rotation = -self.global_rotation
