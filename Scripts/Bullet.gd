extends KinematicBody2D
export (float) var speed
var _direction
var destroy = 0

func _shoot(direction):
	 _direction = direction
	 set_physics_process(true)
	
func _physics_process(delta):
	var t = move_and_collide(_direction * delta * speed) 
#	get_node("Collision").disabled = true
	destroy += delta
	if(destroy > 3):
		get_parent().remove_child(self)