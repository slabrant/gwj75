extends Node

@onready var build_mode_button: CheckButton = $BuildModeButton

@export var is_build_mode : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_build_mode_button_pressed() -> void:
	is_build_mode = !is_build_mode
