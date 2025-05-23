extends "res://scenes/objects/mirrors/mirror.gd"

const BEAM = preload("res://scenes/objects/beam.tscn")


func shoot(shoot_rotation) -> CharacterBody2D:
	var beam : CharacterBody2D = BEAM.instantiate()
	beam.position = position + 2 * Vector2(cos(shoot_rotation), -sin(shoot_rotation))
	beam.rotation = Vector2(cos(shoot_rotation), -sin(shoot_rotation)).angle()
	add_sibling(beam)
	return beam


func reflect(body: Node2D) -> void:
	body.die()
	reflect_sound.play()
	if body.color != [255, 255, 255]:
		return
	var combined_rotation = mirror_rotation + rotation
	var green_beam = shoot(deg_to_rad(30) - combined_rotation)
	green_beam.laser_shoot.volume_db -= 10
	green_beam.color = [0, 255, 0]
	var red_beam = shoot(deg_to_rad(150) - combined_rotation)
	red_beam.laser_shoot.volume_db -= 10
	red_beam.color = [255, 0, 0]
	var blue_beam = shoot(deg_to_rad(270) - combined_rotation)
	blue_beam.laser_shoot.volume_db -= 10
	blue_beam.color = [0, 0, 255]
