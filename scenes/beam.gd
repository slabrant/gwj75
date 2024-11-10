extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_hit_box_body_entered(body: Node2D) -> void:
	queue_free()
	pass # Replace with function body.
