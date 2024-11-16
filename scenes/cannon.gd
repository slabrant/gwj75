extends Node2D

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene.find_child("Level")
@onready var sprite: Sprite2D = $Sprite2D

const BEAM = preload("res://scenes/beam.tscn")


func _process(delta: float) -> void:
	sprite.rotation = (get_global_mouse_position() - position).angle()
	if Input.is_action_just_released("input_action") and not level.is_build_mode:
		var beam : CharacterBody2D = BEAM.instantiate()
		beam.position = position
		beam.rotation = ((get_global_mouse_position() - position).normalized()).angle()
		add_sibling(beam)
