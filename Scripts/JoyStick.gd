extends Sprite

var movementVector = Vector2(0, 0)
var joyStickIndex = -1
var startPos = Vector2(0, 0)
var endPos
var nulls = false

signal on_joyStick_changed(moveVector)

func _ready():
	set_process(true)
	set_process_input(true)
	visible = false
	self.connect("on_joyStick_changed", get_node("../YSort/Player"), "move")

func _process(delta):
	position = startPos  - get_node("..").position - get_viewport_transform().get_origin()
	emit_signal("on_joyStick_changed", movementVector)

func _input(event):
	if event is InputEventScreenTouch: 
		if joyStickIndex == -1 && event.is_pressed():
			startPos = event.position
			endPos = event.position
			joyStickIndex = event.index
			position = startPos
			$Joystick.position = Vector2(0, 0)
			visible = true
		elif joyStickIndex == event.index && !event.is_pressed():
			movementVector = Vector2(0, 0)
			visible = false
			joyStickIndex = -1
	elif event is InputEventScreenDrag:
		if joyStickIndex == event.index:
			endPos = event.position
			movementVector = endPos - startPos
			if movementVector.length() > 60:
				movementVector = movementVector.normalized() * 60
			$Joystick.position = movementVector
