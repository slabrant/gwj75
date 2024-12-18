extends "res://scenes/menus/menu_overlay.gd"

@onready var speed_value: TextEdit = $SpeedValue
@onready var position_snapping_value: CheckButton = $PositionSnappingValue
@onready var rotation_snap_value: TextEdit = $RotationSnapValue
@onready var slow_rotation_value: CheckButton = $SlowRotationValue


func _ready() -> void:
	super()
	speed_value.text = str(world.bullet_speed_setting)
	position_snapping_value.button_pressed = world.position_snapping_setting
	rotation_snap_value.text = str(world.rotation_snap_angle_setting)
	slow_rotation_value.button_pressed = world.slow_rotation_setting
	


func _on_speed_value_text_changed() -> void:
	world.bullet_speed_setting = speed_value.text


func _on_position_snapping_value_pressed() -> void:
	world.position_snapping_setting = position_snapping_value.button_pressed


func _on_rotation_snap_value_text_changed() -> void:
	world.rotation_snap_angle_setting = rotation_snap_value.text


func _on_slow_rotation_value_pressed() -> void:
	world.slow_rotation_setting = slow_rotation_value.button_pressed


func _on_close_button_pressed() -> void:
	close()
