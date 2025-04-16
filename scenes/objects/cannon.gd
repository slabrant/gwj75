extends Node2D

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene
@onready var sprite: Sprite2D = $Sprite2D

const BEAM = preload("res://scenes/objects/beam.tscn")


func _unhandled_input(event: InputEvent) -> void:
	if level.is_build_mode or level.open_menu:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
		var beam : CharacterBody2D = BEAM.instantiate()
		var spr_ang = sprite.rotation
		beam.position = position + 14 * Vector2(cos(spr_ang), sin(spr_ang))
		beam.rotation = spr_ang
		add_sibling(beam)
		level.shot_count += 1


func _process(delta: float) -> void:
	sprite.rotation = (get_global_mouse_position() - position).angle()
