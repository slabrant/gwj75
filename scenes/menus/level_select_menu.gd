extends Control

var dir = DirAccess.open("res://scenes/levels")

const LevelButton = preload("res://scenes/level_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file_count: int = 0
	for file in dir.get_files():
		var level_button = LevelButton.instantiate()
		level_button.position = Vector2((file_count % 4 + 1) * 150 - 125, (floor(file_count/4) + 0.5) * 64)
		level_button.level_path = file.get_file()
		file_count += 1
		level_button.text = "Level " + str(file_count)
		add_child(level_button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
