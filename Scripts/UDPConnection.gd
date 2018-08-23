extends Node2D

var IP_SERVER = '185.55.226.196'
var PORT_SERVER = 8008
var PORT_CLIENT = 8008
var socketUDP = PacketPeerUDP.new()

signal on_message_received(msg)

func _ready():
	start_client()
	set_process(true)

func _process(delta):
	# get data
	if socketUDP.get_available_packet_count() > 0:
		var array_bytes = socketUDP.get_packet()
		var message = array_bytes.get_string_from_ascii()
		var json = JSON.parse(message).result
		print(json)
		emit_signal("on_message_received", json)


func start_client():
	if (socketUDP.listen(PORT_CLIENT, IP_SERVER) != OK):
		printt("Error listening on port: " + str(PORT_CLIENT) + " in server: " + IP_SERVER)
	else:
		printt("Listening on port: " + str(PORT_CLIENT) + " in server: " + IP_SERVER)

func _exit_tree():
	socketUDP.close()

func send(msg):
	print(msg)
	if socketUDP.is_listening():
		socketUDP.set_dest_address(IP_SERVER, PORT_SERVER)
		socketUDP.put_var(JSON.print(msg))