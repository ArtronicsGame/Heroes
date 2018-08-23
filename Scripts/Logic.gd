extends Node2D

const SlavePlayer = preload("res://Scenes/MasterPlayer.tscn")
const Joystick = preload("res://Scenes/JoyStick.tscn")

var id
var udp

signal position_changed(id, pos, rotation)

func _ready():
	udp = find_node_by_name(get_node('/root'), "UDPConnection")
	udp.send({"_type" : "get_ready"})

func _on_message(msg):
	var type = msg['_type']
	print(type)
	var info = msg['_info']
	match type:
		'update_pos':
			print("Nice")
			pass
		'id_callback':
			id = info['_id']
			var player = SlavePlayer.instance()
			player.set_name("Player")
			get_node("../YSort").add_child(player)
			get_node("..").add_child(Joystick.instance())
			player.connect("master_position_changed", get_node("../../Logic"), "send_transform")
			print("Yeeeeeah : " + str(id))

func send_transform(position, rotation):
	if udp == null :
		udp = find_node_by_name(get_node('/root'), "UDPConnection")
	var type = 'update_pos'
	var pos = {"x" : position.x, "y" : position.y}
	var info = {"_id" : id, "_pos" : pos, "_rotation" : rotation}
	var msg = {"_type" : type, "_info" : info}
	udp.send(msg)

func find_node_by_name(root, name):
	if(root.get_name() == name): return root
	for child in root.get_children():
		if(child.get_name() == name):
			return child
		var found = find_node_by_name(child, name)
		if(found): return found
	return null
