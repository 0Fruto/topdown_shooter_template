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
	self.position = $"/root/Game/Player/Character".global_position
	mPos = get_global_mouse_position()
	difference = mPos - self.position
	rotationZ = atan2(difference.y, difference.x)
	self.rotate(rotationZ - self.rotation)
	self.position = $"/root/Game/Player/Character/Gun".global_position
	$"/root/Game/Player/Main camera".position += Vector2(cameraOffsetX, cameraOffsetY)

func _process(delta):
	if cameraOffsetX > 0:
		$"/root/Game/Player/Main camera".position -= Vector2(1, 0)
		cameraOffsetX -= 1
	if cameraOffsetX < 0:
		$"/root/Game/Player/Main camera".position += Vector2(1, 0)
		cameraOffsetX += 1
	
	if cameraOffsetY > 0:
		$"/root/Game/Player/Main camera".position -= Vector2(0, 1)
		cameraOffsetY -= 1
	if cameraOffsetY < 0:
		$"/root/Game/Player/Main camera".position += Vector2(0, 1)
		cameraOffsetY += 1
	
	
	if destroy:
		counter -= delta
	if counter <= 0:
		if destroy:
			self.queue_free()
	
func _physics_process(_delta):
	if !destroy:
		var body = self.move_and_collide(Vector2(speed * cos(rotation), speed * sin(rotation)))
		if body:
			if body != $"/root/Game/Player":
				$"Particle".emitting = true
				$"Bullet texture".hide()
				if body.collider.name != "Wall":
					$"Particle".set_modulate(Color(1, 0.2, 0.2, 0.5))
					if body.collider.health > 0:
						body.collider.setHealth(damage)
				destroy = true
				$CollisionShape2D.disabled = true
