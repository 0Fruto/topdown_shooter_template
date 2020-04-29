extends Sprite

var cursorPos

func _ready():
	pass

func _process(_delta):
	cursorPos = get_global_mouse_position()
	self.position = cursorPos
	self.rotate(0.05)
