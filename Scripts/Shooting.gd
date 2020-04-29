extends Node2D

var bullet
var loadBullet

export var cdGoal = 0.1
var cd = 0

func _ready():
	loadBullet = load("res://Prefabs/Bullet.tscn")

func _process(delta):
	cd += delta
	if Input.is_action_pressed("ui_select") && cd >= cdGoal:
		bullet = loadBullet.instance()
		add_child(bullet)
		cd = 0
