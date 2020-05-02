extends AnimatedSprite

var cursorPos
var rotZ
var playerRot

func _ready():
	pass

func _process(_delta):
	cursorPos = get_global_mouse_position()
	self.position = cursorPos
	rotZ = get_node("../Player").rotationZ
	self.rotate(rotZ - self.rotation)
