extends KinematicBody2D


export var health = 100
var first = true
var rightPutin

func _ready():
	rightPutin = selectPutin(1, 5)
	get_node("Putin/" + rightPutin).playing = true

func setHealth(damage):
	health -= damage

func selectPutin(RangeStart, RangeEnd):
	var putin = "Putin" + str(round(rand_range(RangeStart, RangeEnd)))
	return putin


func _process(_delta):
	if health <= 0:
		$EnemyAnimator.play("Death")
		if first:
			$EnemyAnimator.rotate(deg2rad(180))
			get_node("Putin/" + rightPutin).playing = false
			first = false
		$CollisionShape2D.set_deferred("disabled", true)
