extends Button


func _ready():
	pass


func _on_ClanCreateBtn_button_down():
	get_node("../TCPConnection").Send({
		"_type" : "ClanController.search",
		'_info': 
        {
		'clanName': "A"}
		
	}) 

func _on_TCPConnection_on_message_received(msg):
	print(msg)