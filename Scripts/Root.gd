extends Node2D

var slavePlayer = load("res://Scenes/SlavePlayer.tscn")

"""func _on_Logic_change_pos(idn, newPos, rotation):
	print(idn)
	var id = str(idn)
	if has_node(id):
		var lastPos = get_node(id).position
		get_node(id).move(newPos - lastPos)
	else:
		var newPlayer = slavePlayer.instance()
		newPlayer.set_name(id)
		add_child(newPlayer)
		get_node(id).position = newPos"""

func _ready():
	set_process(true)

func _process(delta):
	pass