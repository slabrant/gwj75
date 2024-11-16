extends Button

@onready var world: Node = get_tree().root.get_child(0)

@export var level_path : String = ""
@export var level_id : int
@export var level_score : int = 0


func _ready():
	var x = level_id % 4 * 150 + 16
	var y = (floor(level_id/4) + 1) * 64
	position = Vector2(x, y)
	text = str(level_id) + " - " + str(level_score) + "/3"


func _on_pressed() -> void:
	world.level_id = level_id
	world.scene_path = "res://scenes/levels/" + level_path
