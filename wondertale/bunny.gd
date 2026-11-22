extends CharacterBody2D

@export var speed: float = 60.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var is_moving: bool = false
var target_x: float = 0.0
var dialogue_started: bool = false

const basic_dialogue: ParleyDialogueSequenceAst = preload("res://dialogue_sequences/hare_dialogue.ds")

var ctx: ParleyContext

func _exit_tree() -> void:
	if ctx:
		ctx.free()

func start_moving() -> void:
	target_x = global_position.x + 80.0
	is_moving = true
	dialogue_started = false
	anim.play("walk")

func _physics_process(_delta: float) -> void:
	if not is_moving:
		anim.frame = 1
		return

	# Check if we reached or passed the target distance
	if global_position.x >= target_x:
		global_position.x = target_x
		_stop_and_start_dialogue()
		return

	velocity = Vector2(speed, 0)
	move_and_slide()

	# Stop early if it bumps into a wall/player
	if is_on_wall():
		_stop_and_start_dialogue()

func _stop_and_start_dialogue() -> void:
	velocity = Vector2.ZERO
	is_moving = false
	anim.stop()

	if not dialogue_started:
		dialogue_started = true
		ctx = ParleyContext.create(basic_dialogue)
		var _result: Node = Parley.run_dialogue(ctx, basic_dialogue)
