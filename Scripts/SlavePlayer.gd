extends Area2D

export (int) var speed  # How fast the player will move (pixels/sec).
var screensize  # Size of the game window.

var lastMove
var moving = false

func _ready():
	screensize = get_viewport_rect().size
	lastMove = OS.get_ticks_msec()
	$AnimatedSprite.play();
	set_process(true)

func _process(delta):
	if moving and OS.get_ticks_msec() - lastMove > 500:
		moving = false 
		if $AnimatedSprite.animation.find("stand") == -1:
			$AnimatedSprite.animation = $AnimatedSprite.animation + "-stand"
	pass

func moveSlave(dest, angle):
	var delta = dest - position
	if delta.length() == 0:
		if $AnimatedSprite.animation.find("stand") == -1:
			$AnimatedSprite.animation = $AnimatedSprite.animation + "-stand"
			moving = false
		return
	
	position = dest
	
	lastMove = OS.get_ticks_msec()
	moving = true
	if angle.x > 0.3:
		if angle.y > 0.3:
			$AnimatedSprite.animation = "down-right"
		elif angle.y < -0.3:
			$AnimatedSprite.animation = "up-right"
		else:
			$AnimatedSprite.animation = "right"
	elif angle.x < -0.3:
		if angle.y > 0.3:
			$AnimatedSprite.animation = "down-left"
		elif angle.y < -0.3:
			$AnimatedSprite.animation = "up-left"
		else:
			$AnimatedSprite.animation = "left"
	else:
		if angle.y > 0.3:
			$AnimatedSprite.animation = "down"
		elif angle.y < -0.3:
			$AnimatedSprite.animation = "up"
	
