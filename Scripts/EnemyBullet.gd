extends KinematicBody2D

var velocity = Vector2()
var difference = Vector3()
var rotationZ = float()
export var speed = 50
export var damage = 101
var move = true
var destroy = false
var counter = 1
var daddy
var player

func _ready():
	player = $"/root/Game/Player"
	daddy = $"../Enemy/EnemyAnimator"
	difference = player.global_position - daddy.global_position
	rotationZ = atan2(difference.y, difference.x)
	self.rotate(rotationZ - self.rotation + rand_range(-0.3, 0.3))
	self.global_position = $"../Enemy/EnemyAnimator/Gun".global_position

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
				$"Particle".emitting = true
				$"Bullet texture".hide()
				body.collider.setHealth(damage)
				destroy = true
				$CollisionShape2D.disabled = true
			
			if body.collider.name == "Wall":
				$"Particle".emitting = true
				$"Bullet texture".hide()
				destroy = true
				$CollisionShape2D.disabled = true
