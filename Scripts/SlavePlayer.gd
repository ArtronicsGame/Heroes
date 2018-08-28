extends Area2D

export (int) var speed  # How fast the player will move (pixels/sec).
var screensize  # Size of the game window.

var lastMove
var moving = false

var destination

func _ready():
	destination = position
	screensize = get_viewport_rect().size
	lastMove = OS.get_ticks_msec()
	$AnimatedSprite.play();
	set_process(true)

func _process(delta):
	var maxDelta = 1.2 * speed * delta
	var movementVec = destination - position
	if movementVec.length() > maxDelta:
		position += movementVec.normalized() * maxDelta
	else:
		position += movementVec
		
	if movementVec.length() == 0 and $AnimatedSprite.animation.find("stand") == -1:
		$AnimatedSprite.animation = $AnimatedSprite.animation + "-stand"
	
	if moving and OS.get_ticks_msec() - lastMove > 500:
		moving = false 
		if $AnimatedSprite.animation.find("stand") == -1:
			$AnimatedSprite.animation = $AnimatedSprite.animation + "-stand"

func moveSlave(dest, angle):
	var delta = dest - position
	if delta.length() == 0:
		moving = false
		if angle.x > 0.3:
			if angle.y > 0.3:
				$AnimatedSprite.animation = "down-right-stand"
			elif angle.y < -0.3:
				$AnimatedSprite.animation = "up-right-stand"
			else:
				$AnimatedSprite.animation = "right-stand"
		elif angle.x < -0.3:
			if angle.y > 0.3:
				$AnimatedSprite.animation = "down-left-stand"
			elif angle.y < -0.3:
				$AnimatedSprite.animation = "up-left-stand"
			else:
				$AnimatedSprite.animation = "left-stand"
		else:
			if angle.y > 0.3:
				$AnimatedSprite.animation = "down-stand"
			elif angle.y < -0.3:
				$AnimatedSprite.animation = "up-stand"
		return
	
	destination = dest
	
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
	
