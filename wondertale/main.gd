extends Node

const START_SCREEN = preload("res://start_screen.tscn")
const GAME = preload("res://game.tscn")
const basic_dialogue: ParleyDialogueSequenceAst = preload("res://dialogue_sequences/new_dialogue.ds")

var start_screen

func _ready():
	start_screen = START_SCREEN.instantiate()
	add_child(start_screen)
	start_screen.start_game.connect(_on_start_game)

func _on_start_game():
	start_screen.queue_free()
	add_child(GAME.instantiate())
