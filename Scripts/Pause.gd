extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dict_to_save = {  
	"sound" : 100
}
var save = File.new()

func create_save():
	save.open("user://settings.save", File.WRITE)
	save.store_var(dict_to_save)
	save.close()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_rotation(0)
	get_tree().paused = true
	print_debug("_ready()")
	if save.file_exists("user://settings.save"):
		print_debug("Save found, reading..")
		save.open("user://settings.save", File.READ)
		var read = save.get_var()
		dict_to_save = read
		if read.has("sound"):
			print_debug("Save is valid")
		$Settings/Popup/Sound.value = read["sound"]
		print_debug("Reading complete")
		save.close()
	else:
		print_debug("Save not found, is this first start?")
		create_save()
	$Main/Popup.popup()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Pause_tree_exiting():
	create_save()
	get_tree().paused = false
	pass # Replace with function body.


func _on_Sound_value_changed(value):
	dict_to_save["sound"] = value
	pass # Replace with function body.

func _on_Back_pressed():
	$Main/Popup.popup()
	pass # Replace with function body.


func _on_Resume_pressed():
	queue_free()
	get_tree().paused = false
	pass # Replace with function body.


func _on_Settings_pressed():
	$Settings/Popup.popup()
	pass # Replace with function body.


func _on_Exit_pressed():
	pass # Replace with function body.
