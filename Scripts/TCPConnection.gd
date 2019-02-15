extends Node2D

####################################################################################################
# Config
####################################################################################################
const port = 6624
var ip = "193.176.243.42"

####################################################################################################
# Socket
####################################################################################################
var connection = null
var peerstream = null
var connected = false
var timeout = 5
var timer

signal on_message_received(msg)
signal on_connection_established()
signal on_connection_destroyed()

func IsConnected():
	return connected

func Connect():
	# Connect
	connection = StreamPeerTCP.new()
	connection.connect_to_host(ip, port)
	
	# Timeout
	timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(timeout)
	timer.set_one_shot(true)
	timer.connect("timeout", self, "_TimeoutDisconnect")
	timer.start()
	
	# Proccess
	print("Connecting")
	emit_signal("on_connection_established")
	set_process(true)

# OnClient
func OnClient():
	# Connected
	if (!connected && connection.get_status() == connection.STATUS_CONNECTED):
		print("Connected")
		connected = true
		
		peerstream = PacketPeerStream.new()
		peerstream.set_stream_peer(connection)
		
	# Disconnected
	if (connection.get_status() == connection.STATUS_NONE or connection.get_status() == connection.STATUS_ERROR):
		set_process(false)
		Disconnect()
	
	# Connected and receiving data
	if (connected):
		if (peerstream.get_available_packet_count() > 0):
			print("Yeah")
			var data = peerstream.get_var()
			emit_signal("on_message_received", data)

func Disconnect():
	if (connected):
		print("Disconnected")
		emit_signal("on_connection_destroyed")
		connection.disconnect_from_host()
		connected = false

func _TimeoutDisconnect():
	timer.stop()
	remove_child(timer)
	
	if (!connected):
		print("TimeOut")
		emit_signal("on_time_out")


func _process(delta):
	OnClient()

func _ready():
	Connect()

func Send(data):
	if (data != null):
		peerstream.put_var(data)

