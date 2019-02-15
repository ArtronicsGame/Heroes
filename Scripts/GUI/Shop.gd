extends MarginContainer

func _ready():
	var e_container = get_node("VBoxContainer/EquipmentContainer/HBoxContainer")
	var b_container = get_node("VBoxContainer/BoxContainer/HBoxContainer")
	
	for i in range(20):
		var button = Button.new()
		button.text = "Hello World"
		e_container.add_child(button)
	for i in range(20):
		var button = Button.new()
		button.text = "Hello World"
		b_container.add_child(button)
	

