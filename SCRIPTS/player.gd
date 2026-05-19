extends CharacterBody2D

const SPEED = 125

var current_direction

enum direction{
	UP,
	UP_RIGHT,
	UP_LEFT,
	DOWN,
	DOWN_RIGHT,
	DOWN_LEFT,
	LEFT,
	RIGHT,
	IDLE
}

var KEY_UP = false
var KEY_DOWN = false
var KEY_LEFT = false
var KEY_RIGHT = false

func _process(_delta: float) -> void:
	get_input()
	set_direction()
	move()

func get_input():
	if Input.is_action_pressed("move_up"): KEY_UP = true
	else: KEY_UP = false

	if Input.is_action_pressed("move_down"): KEY_DOWN = true
	else: KEY_DOWN = false

	if Input.is_action_pressed("move_left"): KEY_LEFT = true
	else: KEY_LEFT = false

	if Input.is_action_pressed("move_right"): KEY_RIGHT = true
	else: KEY_RIGHT = false

func set_direction():
	if KEY_UP:
		if KEY_LEFT:
				current_direction= direction.UP_LEFT
		elif KEY_RIGHT:
				current_direction = direction.UP_RIGHT
		else: current_direction = direction.UP

	elif KEY_DOWN:
		if KEY_LEFT:
				current_direction= direction.DOWN_LEFT
		elif KEY_RIGHT:
				current_direction = direction.DOWN_RIGHT
		else: current_direction = direction.DOWN

	elif KEY_LEFT:
		current_direction = direction.LEFT

	elif KEY_RIGHT:
		current_direction = direction.RIGHT

	else: current_direction = direction.IDLE

func move():
	match current_direction:
		direction.UP: 
			self.velocity = Vector2(0, -SPEED)
			$AnimatedSprite2D.play("up")
		direction.DOWN: 
			self.velocity = Vector2(0, SPEED)
			$AnimatedSprite2D.play("down")
		direction.LEFT: 
			self.velocity = Vector2(-SPEED, 0)
			$AnimatedSprite2D.play("left")
		direction.RIGHT: 
			self.velocity = Vector2(SPEED, 0)
			$AnimatedSprite2D.play("right")
		direction.UP_LEFT: 
			self.velocity = cartesian_to_isomentric(Vector2(-SPEED, 0))
			$AnimatedSprite2D.play("up_left")
		direction.UP_RIGHT: 
			self.velocity = cartesian_to_isomentric(Vector2(0, -SPEED))
			$AnimatedSprite2D.play("up_right")
		direction.DOWN_LEFT: 
			self.velocity = cartesian_to_isomentric(Vector2(0, SPEED))
			$AnimatedSprite2D.play("down_left")
		direction.DOWN_RIGHT: 
			self.velocity = cartesian_to_isomentric(Vector2(SPEED, 0))
			$AnimatedSprite2D.play("down_right")
		direction.IDLE: 
			self.velocity = Vector2(0, 0)
			$AnimatedSprite2D.play("idle")
		
	move_and_slide()

func cartesian_to_isomentric(cartesian):
	return Vector2(cartesian.x - cartesian.y, (cartesian.x + cartesian.y) / 2)
