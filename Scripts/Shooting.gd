extends Node2D

var bullet
var loadBullet
export var cdGoal = 0.2
var cd = 0
var bullets
var reloading = false
export var reloadingDuration = 100
var reloadingCounter = reloadingDuration

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	loadBullet = load("res://Prefabs/Bullet.tscn")
	$Player/Character/Gun.hide()
	bullets = $Player.fullMagazine

func ReloadWeapon():
	if $Player.magazineCount >= 1:
		reloading = true
		$Player/Character/Gun.play("Reloading")
		$Player/Character.play("Reloading")

func Shooting():
	$Player/Character/Gun.play("Shooting")
	$Player/Character.play("Shooting")
	$Cursor.play("Shooting")
	$"Player/Player Shoot col".disabled = false
	$"Player/Player Idle col".disabled = true
	bullet = loadBullet.instance()
	add_child(bullet)
	cd = 0
	bullets -= 1
	
func Prepare():
	$Player/Character/Gun.show()
	$Player/Character.play("Prepare")
	$Player/Character/Gun.play("Prepare")
	$Cursor.play("Idle")
	$"Player/Player Shoot col".disabled = false
	$"Player/Player Idle col".disabled = true
	if bullets < 1:
		ReloadWeapon()

func RemoveWeapon():
	$Cursor.play("Idle")
	$Player/Character/Gun.hide()
	$Player/Character.play("Idle")
	$"Player/Player Shoot col".disabled = true
	$"Player/Player Idle col".disabled = false

func _process(delta):
	$"Player/Main camera/Bullets".text = (str(bullets) + "/" + str($Player.magazineCount))
	cd += delta
	if Input.is_action_pressed("ui_select") and not reloading:
		if cd >= cdGoal and bullets > 0:
			Shooting()
		else:
			Prepare()
	else:
		if not reloading:
			RemoveWeapon()
	
	
	if reloading:
		reloadingCounter -= 1
		if reloadingCounter <= 0:
			bullets = $Player.fullMagazine
			$Player.magazineCount -= 1
			reloading = false
			reloadingCounter = reloadingDuration
