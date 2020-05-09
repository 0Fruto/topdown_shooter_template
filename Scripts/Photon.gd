extends KinematicBody2D

var playerPos = Vector2()
var velocity = Vector2()
var difference = Vector3()
var rotationZ = float()
export var speed = 50
export var damage = 101
var move = true
var destroy = false
var counter = 1
var daddy

func _ready():
	daddy = $".."
	playerPos = $"/root/Game/Player".global_position
	difference = playerPos - daddy.global_position
	rotationZ = atan2(difference.y, difference.x)
	self.rotate(rotationZ - self.rotation)
	self.global_position = daddy.global_position
	

func _process(delta):
	if destroy:
		counter -= delta
	if counter <= 0:
		if destroy:
			self.queue_free()
	
func _physics_process(_delta):
	if !destroy:

		var body = self.move_and_collide(Vector2(speed * cos(rotation), speed * sin(rotation)))
		if body:
			if body.collider.name == "Player":
				daddy.seePlayer = true
				destroy = true
				$CollisionShape2D.disabled = true
				
			if body.collider.name == "Wall":
				daddy.seePlayer = false
				destroy = true
				$CollisionShape2D.disabled = true
