extends CharacterBody2D
var is_dashing: bool = false
var dash_target: Vector2
var dash_speed: float = 800.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass

func start_moving() -> void:
	anim.play()
	
func stop_moving() -> void:
	anim.stop()
	



func dash(direction: Vector2, distance: float = 8000.0, speed: float = 800.0) -> void:
	is_dashing = true
	dash_speed = speed
	dash_target = global_position + (direction.normalized() * distance)
	
	# Optional: Play your left animation if dashing left
	if direction.x < 0 and has_node("AnimatedSprite2D"):
		$AnimatedSprite2D.play("walk_left") # Replace with your animation name

func _physics_process(delta: float) -> void:
	if is_dashing:
		var distance_left: float = global_position.distance_to(dash_target)
		
		# Stop if we reached the target OR bumped into a wall
		if distance_left <= dash_speed * delta or is_on_wall():
			if not is_on_wall():
				global_position = dash_target # Snap cleanly to the exact 200px spot
			velocity = Vector2.ZERO
			is_dashing = false
			if has_node("AnimatedSprite2D"):
				$AnimatedSprite2D.stop()
		else:
			velocity = global_position.direction_to(dash_target) * dash_speed
			move_and_slide()
