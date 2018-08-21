extends Node2D

signal change_pos(id, pos, rotation)

func _on_message(msg):
	var type = msg['_type']
	var info = msg['_info']
	if type == 'updatePos':
		var ip = info['_ip']
		var pos = Vector2(info['_pos']['x'], info['_pos']['y'])
		#var rotation = info['rotation']
		var rotation = 0;
		emit_signal("change_pos", "player" + str(ip), pos, rotation)