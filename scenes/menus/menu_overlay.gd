extends Control

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if level.open_menu:
		level.open_menu.close()
	level.open_menu = self
	if level.camera:
		var x_zoomed = size.x / level.camera.zoom.x
		var y_zoomed = size.y / level.camera.zoom.y
		
		scale = Vector2(1/level.camera.zoom.x, 1/level.camera.zoom.y)
		global_position = Vector2(-x_zoomed / 2 + level.camera.offset.x, -y_zoomed / 2 + level.camera.offset.y)
	
func close() -> void:
	level.open_menu = null
	queue_free()
