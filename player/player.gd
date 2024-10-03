extends CharacterBody2D

const speed = 200
var run_multiplier = 2.5

func _physics_process(delta):
	player_movement()
	animation()
	pass

func animation():
	# Flip horizontally based on direction
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false

	# Play animations based on movement
	if velocity.length() > 0:
		if Input.is_action_pressed("run"):
			$AnimatedSprite2D.play("run") # Play run animation when running
		else:
			$AnimatedSprite2D.play("side_walk") # Play walk animation
	else:
		$AnimatedSprite2D.play("idle") # Idle when not moving

func player_movement():
	velocity = Vector2.ZERO
	var current_speed = speed

	# Check if the player is running
	if Input.is_action_pressed("run"):
		current_speed *= run_multiplier

	# Horizontal movement
	if Input.is_action_pressed("right"):
		velocity.x = current_speed
	elif Input.is_action_pressed("left"):
		velocity.x = -current_speed

	# Vertical movement
	if Input.is_action_pressed("up"):
		velocity.y = -current_speed
	elif Input.is_action_pressed("down"):
		velocity.y = current_speed

	# Move the player
	move_and_slide()
