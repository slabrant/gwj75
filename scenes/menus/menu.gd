extends Control

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene
@onready var camera_2d: Camera2D = $Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if level.open_menu:
		level.open_menu.close()
	level.open_menu = self
	position = Vector2(-size.x/2, -size.y/2)
	scale = Vector2(1/camera_2d.zoom.x, 1/camera_2d.zoom.y)
	position += Vector2(size.x/(2*camera_2d.zoom.x), size.y/(2*camera_2d.zoom.y))
	
#func close() -> void:
	#level.open_menu = null
	#queue_free()
