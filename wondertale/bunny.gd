extends CharacterBody2D

@export var speed: float = 80.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D # Change if using AnimationPlayer

var is_moving: bool = false
var target_x: float = 0.0


func _ready() -> void:
	# Trigger automatically at start, or remove this line and call start_moving() from a signal/cutscene
	start_moving()

func start_moving() -> void:
	target_x = global_position.x + 100.0
	is_moving = true
	anim.play("walk") # Replace with your actual animation name

func _physics_process(delta: float) -> void:
	if not is_moving:
		anim.frame=1
		return

	# Check if we reached or passed the 50-pixel mark
	if global_position.x >= target_x:
		global_position.x = target_x # Snap to exact 50px mark
		velocity = Vector2.ZERO
		is_moving = false
		anim.stop() # Or anim.play("idle")
		return

	velocity = Vector2(speed, 0)
	move_and_slide()
	
	# Stop early if it bumps into a wall/player
	if is_on_wall():
		velocity = Vector2.ZERO
		is_moving = false
		anim.stop()
