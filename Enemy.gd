extends KinematicBody2D


export var health = 100

func _ready():
	pass

func setHealth(damage):
	health -= damage

func _process(delta):
	if health <= 0:
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
