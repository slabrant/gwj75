extends Control

@onready var world: Node = get_tree().root.get_child(0)
#@onready var win_label: Label = $WinLabel


func _ready() -> void:
	position = Vector2(-size.x/2, -size.y/2)
	#win_label.text = "Congratulations and thanks for playing my game!"


func close() -> void:
	queue_free()


func _on_main_menu_button_pressed() -> void:
	close()
	world.scene_path = "res://scenes/menus/start_menu.tscn"
