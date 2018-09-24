extends Button

func _on_PlayBtn_button_down():
	get_node("../TCPConnection").Send({
		"_type" : "PlayerController.new",
		"_info" : {"username" : "Ali"}
	})


func _on_TCPConnection_on_message_received(msg):
	print(msg)
