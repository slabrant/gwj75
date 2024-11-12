extends Node2D

@onready var world: Node = get_tree().root.get_child(0).find_child("World")

const BEAM = preload("res://scenes/beam.tscn")
@export var SPEED = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation = (get_global_mouse_position() - position).angle()
	if Input.is_action_just_released("input_action") and not world.is_build_mode:
		var beam : CharacterBody2D = BEAM.instantiate()
		beam.position = position
		var angle_vector = (get_global_mouse_position() - position).normalized()
		beam.velocity = angle_vector * SPEED
		beam.rotation = angle_vector.angle()
		add_sibling(beam)
