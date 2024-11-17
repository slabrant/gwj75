extends "res://scenes/objects/mirrors/mirror.gd"

const BEAM = preload("res://scenes/objects/beam.tscn")


func shoot(shoot_rotation) -> CharacterBody2D:
	var beam : CharacterBody2D = BEAM.instantiate()
	beam.position = position + 8 * Vector2(cos(shoot_rotation), -sin(shoot_rotation))
	beam.rotation = Vector2(cos(shoot_rotation), -sin(shoot_rotation)).angle()
	add_sibling(beam)
	return beam


func _on_body_entered(body: Node2D) -> void:
	var combined_rotation = mirror_rotation + rotation
	var green_beam = shoot(deg_to_rad(30) - combined_rotation)
	green_beam.color = [0, 255, 0]
	var red_beam = shoot(deg_to_rad(150) - combined_rotation)
	red_beam.color = [255, 0, 0]
	var blue_beam = shoot(deg_to_rad(270) - combined_rotation)
	blue_beam.color = [0, 0, 255]
	body.queue_free()
