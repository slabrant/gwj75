extends "res://scenes/objects/mirrors/mirror.gd"


func _on_body_entered(body: Node2D) -> void:
	reflect(body)
