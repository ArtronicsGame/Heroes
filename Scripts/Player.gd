extends Area2D

export (int) var speed  # How fast the player will move (pixels/sec).
var screensize  # Size of the game window.
var deltaT = 0

signal position_changed(newPos)

func _ready():
	screensize = get_viewport_rect().size
	set_process(true)
	$AnimatedSprite.play();
	emit_signal("position_changed", position)

func _process(delta):
	deltaT = delta

func move(movementVector):
	var velocity = movementVector.normalized() * 0.5
	velocity += movementVector.normalized() * ((movementVector.length() - 20) / 80) 
	if movementVector.length() > 20:
		position += velocity * speed * deltaT
		emit_signal("position_changed", position)
	
	if velocity.x > 0.3 && movementVector.length() > 20:
		if velocity.y > 0.3:
			$AnimatedSprite.animation = "down-right"
		elif velocity.y < -0.3:
			$AnimatedSprite.animation = "up-right"
		else:
			$AnimatedSprite.animation = "right"
	elif velocity.x < -0.3 && movementVector.length() > 20:
		if velocity.y > 0.3:
			$AnimatedSprite.animation = "down-left"
		elif velocity.y < -0.3:
			$AnimatedSprite.animation = "up-left"
		else:
			$AnimatedSprite.animation = "left"
	else:
		if velocity.y > 0.3 && movementVector.length() > 20:
			$AnimatedSprite.animation = "down"
		elif velocity.y < -0.3 && movementVector.length() > 20:
			$AnimatedSprite.animation = "up"
		else:
			if $AnimatedSprite.animation.find("stand") == -1:
				$AnimatedSprite.animation = $AnimatedSprite.animation + "-stand"
