extends Button

func _ready():
	TCPConnection.connect("on_message_received", self, "msg_show")

func _on_PlayBtn_button_down():
	TCPConnection.Send({
		"_type" : "PlayerController.new",
		"_info" : {"username" : "Ahmad"}
	})
	
func msg_show(msg):
	print(msg["_userId"])


func _on_TCPConnection_on_message_received(msg):
	print(msg)
