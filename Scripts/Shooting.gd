extends Node2D

var bullet
var loadBullet
#export (PackedScene) var pause       does not working
export var cdGoal = 0.9
var cd = 0

func _ready():
	loadBullet = load("res://Prefabs/Bullet.tscn")
	$Player/Character/Gun.hide()

func _process(delta):
	cd += delta
#	if Input.is_action_just_pressed("ui_cancel"):     does not working
#		var inst = pause.instance()     does not working
#		add_child(inst)     does not working
	if Input.is_action_pressed("ui_select"):
		$Player/Character/Gun.show()
		if cd >= cdGoal:
			$Player/Character/Gun.play("Shooting")
			$Player/Character.play("Shooting")
			$Cursor.play("Shooting")
			bullet = loadBullet.instance()
			add_child(bullet)
			cd = 0
		else:
			$Player/Character.play("Prepare")
			$Player/Character/Gun.play("Prepare")
			$Cursor.play("Idle")
	else:
		$Player/Character/Gun.hide()
		$Player/Character.play("Idle")
		
