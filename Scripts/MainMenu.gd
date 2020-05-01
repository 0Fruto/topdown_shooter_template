extends Control

var dict_to_save = {
	"sound" : 100
}

var save = File.new()
export (PackedScene) var play

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
	pass

func _on_Play_pressed():
	if get_tree().change_scene_to(play) == ERR_CANT_CREATE:
		print_debug("Cannot create scene")
	pass

func _on_Settings_pressed():
	$Menu.visible = false
	$Settings.visible = true
	pass

func create_save():
	save.open("user://settings.save", File.WRITE)
	save.store_var(dict_to_save)
	save.close()

func _on_Menu_pressed():
	$Menu.visible = true
	$Settings.visible = false
	create_save()
	pass

func _on_Sound_value_changed(value):
	dict_to_save["sound"] = value
	pass


func _on_Exit_pressed():
	get_tree().quit()
	pass
