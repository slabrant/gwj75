extends "res://scenes/objects/mirrors/mirror.gd"


func duplicate_body(body: Node2D) -> void:
	var new_body = body.duplicate(DUPLICATE_SIGNALS | DUPLICATE_GROUPS)
	new_body.position += 10 * Vector2(cos(new_body.rotation), sin(new_body.rotation))
	body.add_sibling(new_body)


func _on_body_entered(body: Node2D) -> void:
	#duplicate_body(body)
	reflect(body)
