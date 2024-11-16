extends Node2D

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene.find_child("Level")
@onready var sprite: Sprite2D = $Sprite2D

const BEAM = preload("res://scenes/beam.tscn")


func _unhandled_input(event: InputEvent) -> void:
	if level.is_build_mode or level.open_menu:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var beam : CharacterBody2D = BEAM.instantiate()
		beam.position = position
		beam.rotation = ((get_global_mouse_position() - position).normalized()).angle()
		add_sibling(beam)


func _process(delta: float) -> void:
	sprite.rotation = (get_global_mouse_position() - position).angle()
