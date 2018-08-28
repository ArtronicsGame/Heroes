extends Node2D

var movementVector = Vector2(0, 0)
var joyStickIndex = -1
var startPos = Vector2(0, 0)
var endPos
var nulls = false


export (int) var SwitchTimeInterval = 500
export (float) var SwitchDistIntervalRatio = 1.0/75
var SwitchDistInterval 

export (Color) var AimColor = Color(255, 0, 0)
export (Color) var MoveColor = Color(0 ,255, 0)

var lastPos = Vector2(0, 0)
var lastTime = -10000

var aimingMode = false

signal on_joyStick_changed(moveVector)

func _ready():
	self.modulate = MoveColor
	SwitchDistInterval = (get_viewport_rect().size * SwitchDistIntervalRatio).length()
	set_process(true)
	set_process_input(true)
	visible = false
	self.connect("on_joyStick_changed", get_node("../YSort/Player"), "move")

func _process(delta):
	$JoyStickBack.position = startPos  - get_node("..").position - get_viewport_transform().get_origin()
	emit_signal("on_joyStick_changed", movementVector)

func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			var now = OS.get_ticks_msec()
			if (now - lastTime) < SwitchTimeInterval:
				if (lastPos - event.position).length() < SwitchDistInterval:
					aimingMode = !aimingMode
					if aimingMode:
						self.modulate = AimColor
					else:
						self.modulate = MoveColor
	
	if event is InputEventScreenTouch:
		lastPos = event.position
		lastTime = OS.get_ticks_msec()
	
	if event is InputEventScreenTouch: 
		if joyStickIndex == -1 && event.is_pressed():
			startPos = event.position
			endPos = event.position
			joyStickIndex = event.index
			$JoyStickBack.position = startPos
			$JoyStickBack/Joystick.position = Vector2(0, 0)
			visible = true
		elif joyStickIndex == event.index && !event.is_pressed():
			movementVector = Vector2(0, 0)
			visible = false
			joyStickIndex = -1
	elif event is InputEventScreenDrag:
		if joyStickIndex == event.index:
			endPos = event.position
			var temp = endPos - startPos
			if temp.length() > 60:
				temp = temp.normalized() * 60
			$JoyStickBack/Joystick.position = temp
			
			if aimingMode:
				temp = temp.normalized() * 10
			movementVector = temp
