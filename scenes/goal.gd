extends Area2D

@onready var sprite: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setShader(true)


func setShader(value):
	if sprite:
		sprite.material.set("shader_param/active", value)


func _on_body_entered(body: Node2D) -> void:
	setShader(false)
	body.queue_free()
