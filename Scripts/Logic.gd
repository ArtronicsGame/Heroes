extends Node2D

const MasterPlayer = preload("res://Scenes/Objects/Players/MasterPlayer.tscn")
const SlavePlayer = preload("res://Scenes/Objects/Players/SlavePlayer.tscn")
const Joystick = preload("res://Scenes/Objects/Utils/JoyStick.tscn")

var id
var udp

signal position_changed(id, pos, rotation)

func _ready():
	udp = get_node("../UDPConnection")
	#udp.send({"_type" : "get_ready"})

func _on_message(msg):
	var type = msg['_type']
	print(type)
	var info = msg['_info']
	match type:
		'update_pos':
			var name = "Player" + str(info['_id'])
			if has_node("../YSort/" + name):
				var slavePlayer = get_node("../YSort/" + name)
				slavePlayer.moveSlave(Vector2(info['_pos']['x'], info['_pos']['y']), Vector2(info['_rotation']['x'], info['_rotation']['y']))
			else:
				var slavePlayer = SlavePlayer.instance()
				slavePlayer.set_name(name)
				get_node("../YSort").add_child(slavePlayer)
		'id_callback':
			id = info['_id']
			var player = MasterPlayer.instance()
			player.set_name("Player")
			get_node("../YSort").add_child(player)
			get_node("..").add_child(Joystick.instance())
			player.connect("master_position_changed", get_node("."), "send_transform")
			print("Yeeeeeah : " + str(id))

func send_transform(position, rotation):
	var type = 'update_pos'
	var pos = {"x" : position.x, "y" : position.y}
	var rot = {"x" : rotation.x, "y" : rotation.y}
	var info = {"_id" : id, "_pos" : pos, "_rotation" : rot}
	var msg = {"_type" : type, "_info" : info}
	udp.send(msg)