extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	var new_velocity = body.velocity
	var velocity_angle = new_velocity.angle()
	
	new_velocity = new_velocity.rotated(-(rotation))
	new_velocity.y *= -1
	new_velocity = new_velocity.rotated(rotation)
	
	body.velocity = new_velocity
	body.rotation = new_velocity.angle()
