extends Node2D

@onready var world: Node = get_tree().root.get_child(0).find_child("World")

const BEAM = preload("res://scenes/beam.tscn")


func _process(delta: float) -> void:
	rotation = (get_global_mouse_position() - position).angle()
	if Input.is_action_just_released("input_action") and not world.is_build_mode:
		var beam : CharacterBody2D = BEAM.instantiate()
		beam.position = position
		beam.rotation = ((get_global_mouse_position() - position).normalized()).angle()
		add_sibling(beam)
