extends Node2D


var bullet
var loadBullet
var cd
export var cdGoal = 30

func _ready():
	cd = cdGoal
	loadBullet = load("res://Prefabs/EnemyBullet.tscn")

func Shoot():
	if cd <= 0:
		$Enemy/EnemyAnimator/Gun.play("Shooting")
		$Enemy/EnemyAnimator.play("Shooting")
		bullet = loadBullet.instance()
		add_child(bullet)
		cd = cdGoal

func _process(_delta):
	if cd > 0:
		cd-=1
