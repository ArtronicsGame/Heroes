extends Node2D

const ConvTemp = preload("StringCorrector.gd")
var StringCorrector

func _ready():
	StringCorrector = ConvTemp.new()
	set_process_input(true)


var text
func _on_LineEdit_text_changed(new_text):
	text = text + new_text.substr($LineEdit.caret_position - 1, 1)
	$LineEdit.text = StringCorrector.correct(text)

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_BACKSPACE and event.pressed and $LineEdit.get_focus_owner() == $LineEdit:
			text = text.substr(0, text.length() - 1)
		$LineEdit.text = StringCorrector.correct(text)
