extends Node2D

var bullet
var loadBullet
#export (PackedScene) var pause       does not working
export var cdGoal = 0.1
var cd = 0

func _ready():
	loadBullet = load("res://Prefabs/Bullet.tscn")

func _process(delta):
	cd += delta
#	if Input.is_action_just_pressed("ui_cancel"):     does not working
#		var inst = pause.instance()     does not working
#		add_child(inst)     does not working
	if Input.is_action_pressed("ui_select") && cd >= cdGoal:
		bullet = loadBullet.instance()
		add_child(bullet)
		cd = 0
