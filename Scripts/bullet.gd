extends KinematicBody2D

var mPos = Vector2()
var velocity = Vector2()
var difference = Vector3()
var rotationZ = float()
export var speed = 50
var cameraOffsetX = round(rand_range(0, 5))
var cameraOffsetY = round(rand_range(0, 5))
export var damage = 101
var move = true
var destroy = false
var counter = 1

func _ready():
	self.position = get_node("../Player/Character").global_position
	mPos = get_global_mouse_position()
	difference = mPos - self.position
	rotationZ = atan2(difference.y, difference.x)
	self.rotate(rotationZ - self.rotation)
	self.position = get_node("../Player/Character/Gun").global_position
	get_node("../Player/Main camera").position += Vector2(cameraOffsetX, cameraOffsetY)

func _process(delta):
	if cameraOffsetX > 0:
		get_node("../Player/Main camera").position -= Vector2(1, 0)
		cameraOffsetX -= 1
	if cameraOffsetX < 0:
		get_node("../Player/Main camera").position += Vector2(1, 0)
		cameraOffsetX += 1
	
	if cameraOffsetY > 0:
		get_node("../Player/Main camera").position -= Vector2(0, 1)
		cameraOffsetY -= 1
	if cameraOffsetY < 0:
		get_node("../Player/Main camera").position += Vector2(0, 1)
		cameraOffsetY += 1
	
	
	if destroy:
		counter -= delta
	if counter <= 0:
		if destroy:
			self.queue_free()
	
func _physics_process(_delta):
	if !destroy:
		mPos = get_global_mouse_position()
		difference = mPos - self.position
		rotationZ = atan2(difference.y, difference.x)

		var body = self.move_and_collide(Vector2(speed * cos(rotation), speed * sin(rotation)))
		if body:
			if body != get_node("../Player"):
				get_node("Particle").emitting = true
				get_node("Bullet texture").hide()
				if body.collider.name == "Enemy":
					body.collider.setHealth(damage)
				destroy = true
				$CollisionShape2D.disabled = true
