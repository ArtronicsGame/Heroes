extends Button

func _on_PlayBtn_button_down():
	TCPConnection.Send({
		"_type" : "PlayerController.new",
		"_info" : {"username" : "Mobin"}
	})


func _on_TCPConnection_on_message_received(msg):
	print(msg)
