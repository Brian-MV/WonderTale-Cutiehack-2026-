extends Area2D

@export var npc: CharacterBody2D
const egg_dialogue: ParleyDialogueSequenceAst = preload("res://dialogue_sequences/humpty_dialogue.ds")

var ctx: ParleyContext
var has_triggered: bool = false # Prevents re-triggering if the player steps back in

func _exit_tree() -> void:
	if ctx:
		ctx.free()

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not has_triggered:
		has_triggered = true
		ctx = ParleyContext.create(egg_dialogue)
		npc.start_moving()
		# Capture the dialogue balloon node returned by Parley
		var result: Node = Parley.run_dialogue(ctx, egg_dialogue)
		
		# Pause here until the dialogue balloon closes and leaves the scene
		if result:
			await result.tree_exited
		
		# Trigger the fast movement once dialogue is completely done
		if npc:
			npc.dash(Vector2.LEFT, 8000.0, 900.0)
