extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass

func start_moving() -> void:
	anim.play()
	
func stop_moving() -> void:
	anim.stop()
