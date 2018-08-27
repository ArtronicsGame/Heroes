extends Area2D

export (int) var speed  # How fast the player will move (pixels/sec).
var screensize  # Size of the game window.
var deltaT = 0

export (int) var updateInterval = 500
var lastSend 
var lastAngle
var lastPos
var secondSame = false

var angle = Vector2(0, 1)

signal master_position_changed(newPos, newRotation)

func _ready():
	screensize = get_viewport_rect().size
	set_process(true)
	$AnimatedSprite.play();
	lastSend = OS.get_ticks_msec()

func _process(delta):
	deltaT = delta
	var now = OS.get_ticks_msec()
	if now - lastSend > updateInterval:
		lastSend = now
		if lastPos == position and lastAngle == angle:
			if !secondSame:
				secondSame = true
				emit_signal("master_position_changed", position, angle)
		else:
			secondSame = false
			lastPos = position
			lastAngle = angle
			emit_signal("master_position_changed", position, angle)

var direction_angle = { "down-right" : 45,
						"up-right" : -45,
						"right" : 0,
						"down-left" : 135,
						"up-left" : -135,
						"left" : -180,
						"down" : 90,
						"up" : -90}

func move(movementVector):
	var velocity = movementVector.normalized() * 0.5
	if movementVector.length() != 0:
		angle = movementVector.normalized()
	velocity += movementVector.normalized() * ((movementVector.length() - 20) / 80) 
	if movementVector.length() == 0:
		$Aim.rotation = deg2rad(direction_angle[$AnimatedSprite.animation.replace("-stand", "")])
	else:
		$Aim.rotation = atan2(velocity.x, -velocity.y) - deg2rad(90)
	if movementVector.length() > 20:
		position += velocity * speed * deltaT
	
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
	
	if movementVector.length() < 20:
		if $AnimatedSprite.animation.find("stand") == -1:
				$AnimatedSprite.animation = $AnimatedSprite.animation + "-stand"
