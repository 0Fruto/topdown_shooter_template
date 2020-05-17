extends AnimatedSprite

var cursorPos
var rotZ
var playerRot
var fixed = false
var fixedP = false

func _ready():
	pass

func _process(_delta):
	cursorPos = get_global_mouse_position()
	rotZ = get_node("../Player").rotationZ
	self.rotate(rotZ - self.rotation)
	self.position = cursorPos

