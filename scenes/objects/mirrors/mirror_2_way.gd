extends "res://scenes/objects/mirrors/mirror.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func duplicate_body(body: Node2D) -> void:
	var new_body = body.duplicate(DUPLICATE_SIGNALS | DUPLICATE_GROUPS)
	new_body.position += 10 * Vector2(cos(new_body.rotation), sin(new_body.rotation))
	body.add_sibling(new_body)


func _on_body_entered(body: Node2D) -> void:
	#duplicate_body(body)
	reflect(body)
