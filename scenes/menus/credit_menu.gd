extends "res://scenes/menus/menu_page.gd"

#@onready var win_label: Label = $WinLabel


func _ready() -> void:
	position = Vector2(-size.x/2, -size.y/2)
	world.level_id = 0
	#win_label.text = "Congratulations and thanks for playing my game!"


func close() -> void:
	queue_free()


func _on_main_menu_button_pressed() -> void:
	close()
	world.scene_path = "res://scenes/menus/start_menu.tscn"
