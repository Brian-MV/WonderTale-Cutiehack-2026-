extends Control

signal start_game

@onready var start_button = $StartButton

func _ready():
	start_button.pressed.connect(_on_start_button_pressed)
	start_button.visible = false
	await get_tree().create_timer(5.0).timeout
	start_button.visible = true

func _on_start_button_pressed():
	print("Start button pressed")  # check the Output panel for this
	start_game.emit()
