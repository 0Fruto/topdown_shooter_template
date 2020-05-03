extends Node2D

var bullet
var loadBullet
#export (PackedScene) var pause       does not working
export var cdGoal = 0.2
var cd = 0
var bullets

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	loadBullet = load("res://Prefabs/Bullet.tscn")
	$Player/Character/Gun.hide()
	bullets = $Player.fullMagazine

func ReloadWeapon():
	if $Player.magazineCount >= 1:
		bullets = $Player.fullMagazine
		$Player.magazineCount -= 1

func _process(delta):
	$"Player/Main camera/Label".text = (str(bullets) + "/" + str($Player.magazineCount))
	cd += delta
#	if Input.is_action_just_pressed("ui_cancel"):     does not working
#		var inst = pause.instance()     does not working
#		add_child(inst)     does not working
	if Input.is_action_pressed("ui_select"):
		$Player/Character/Gun.show()
		if cd >= cdGoal and bullets > 0:
			$Player/Character/Gun.play("Shooting")
			$Player/Character.play("Shooting")
			$Cursor.play("Shooting")
			bullet = loadBullet.instance()
			add_child(bullet)
			cd = 0
			bullets -= 1
		else:
			$Player/Character.play("Prepare")
			$Player/Character/Gun.play("Prepare")
			$Cursor.play("Idle")
			if bullets < 1:
				ReloadWeapon()
	else:
		$Cursor.play("Idle")
		$Player/Character/Gun.hide()
		$Player/Character.play("Idle")
		
