extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dict_to_save = {
	"sound" : 100
}

var save = File.new()
export (PackedScene) var play

# Called when the node enters the scene tree for the first time.
func _ready():
	if save.file_exists("user://settings.save"):
		print_debug("Save found, reading..")
		save.open("user://settings.save", File.READ)
		var read = save.get_var()
		dict_to_save = read
		if read.has("sound"):
			print_debug("Save is valid")
		$Settings/Sound.value = read["sound"]
		print_debug("Reading complete")
		save.close()
	else:
		print_debug("Save not found, is this first start?")
		create_save()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_pressed():
	if get_tree().change_scene_to(play) == ERR_CANT_CREATE:
		print_debug("Cannot create scene")
	pass # Replace with function body.

func _on_Settings_pressed():
	$Menu.visible = false
	$Settings.visible = true
	pass # Replace with function body.

func create_save():
	save.open("user://settings.save", File.WRITE)
	save.store_var(dict_to_save)
	save.close()

func _on_Menu_pressed():
	$Menu.visible = true
	$Settings.visible = false
	create_save()
	pass # Replace with function body.

func _on_Sound_value_changed(value):
	dict_to_save["sound"] = value
	pass # Replace with function body.


func _on_Exit_pressed():
	get_tree().quit()
	pass # Replace with function body.
