extends StaticBody2D

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D
@onready var rotate_button: TextureButton = $RotateButton
@onready var minus_button: TextureButton = $MinusButton
@onready var lock_button: TextureButton = $LockButton
@onready var reflect_sound: AudioStreamPlayer = $Reflect
const ROTATE_SPRITE = preload("res://sprites/rotate.png")
const ROTATE_PRESSED_SPRITE = preload("res://sprites/rotate_pressed.png")

@export var mirror_rotation : float = 0:
	set(value):
		if !sprite:
			return
		sprite.rotation = value
		collision.rotation = value
		mirror_rotation = value
@export var locked : bool = true
@export var mirror_rotation_amount : float = PI/8
@export var is_rotating : bool = false:
	set(value):
		is_rotating = value
		if !rotate_button:
			return
		if value:
			rotate_button.texture_normal = ROTATE_PRESSED_SPRITE
		else:
			rotate_button.texture_normal = ROTATE_SPRITE
			rotate_button.texture_pressed = ROTATE_PRESSED_SPRITE
var last_mirror_rotation : float = 0
var last_mouse_position : Vector2


func _ready() -> void:
	lock_button.rotation -= rotation
	rotate_button.hide()
	minus_button.hide()
	lock_button.hide()
	level.mirror_count += 1


func _process(delta: float) -> void:
	if Input.is_action_just_released("input_action"):
		is_rotating = false
		last_mirror_rotation = mirror_rotation
	elif is_rotating:
		var mouse_position = get_local_mouse_position() - last_mouse_position
		var rotation_snap_angle_setting = deg_to_rad(world.rotation_snap_angle_setting) if world.rotation_snap_angle_setting != 0 else deg_to_rad(1)
		
		var mouse_angle = mouse_position.angle()
		if world.slow_rotation_setting:
			mouse_angle = mouse_angle / 2
		var temp_mirror_rotation = last_mirror_rotation + mouse_angle
		mirror_rotation = round(temp_mirror_rotation / rotation_snap_angle_setting) * rotation_snap_angle_setting


func remove():
	var level_mirrors : Array = level.mirrors
	level_mirrors.erase(self)
	level.mirror_count -= 1
	queue_free()


func build_mode_checks() -> void:
	if level.is_build_mode and not locked:
		rotate_button.show()
		minus_button.show()
		lock_button.hide()
	elif level.is_build_mode and locked:
		lock_button.show()
	else:
		rotate_button.hide()
		minus_button.hide()
		lock_button.hide()


func reflect(body: Node2D) -> void:
	var new_velocity = body.velocity
	var combined_rotation = rotation + mirror_rotation
	
	new_velocity = new_velocity.rotated(-(combined_rotation))
	new_velocity.y *= -1
	new_velocity = new_velocity.rotated(combined_rotation)
	
	body.rotation = new_velocity.angle()
	reflect_sound.play()


func _on_touch_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if level.is_build_mode and not locked and event.has_method("is_action_pressed") and event.is_action_pressed("input_action"):
		level.active_mirror = self


func _on_minus_button_pressed() -> void:
	remove()


func _on_rotate_button_button_down() -> void:
	var center = Vector2(rotate_button.size.x/2, rotate_button.size.y/2)
	last_mouse_position = rotate_button.get_local_mouse_position() - center
	is_rotating = true
