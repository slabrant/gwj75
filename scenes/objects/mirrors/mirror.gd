extends Area2D

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene.find_child("Level")

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
@export var last_mirror_rotation : float = 0
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
		var relative_mouse_position = get_local_mouse_position()
		mirror_rotation = relative_mouse_position.angle() + last_mirror_rotation


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
	body.velocity = Vector2()
	var velocity_angle = new_velocity.angle()
	var combined_rotation = rotation + mirror_rotation
	
	new_velocity = new_velocity.rotated(-(combined_rotation))
	new_velocity.y *= -1
	new_velocity = new_velocity.rotated(combined_rotation)
	
	body.velocity = new_velocity
	body.rotation = new_velocity.angle()
	reflect_sound.play()


func _on_touch_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if level.is_build_mode and not locked and event.has_method("is_action_pressed") and event.is_action_pressed("input_action"):
		level.active_mirror = self


func _on_minus_button_pressed() -> void:
	var level_mirrors : Array = level.mirrors
	level_mirrors.erase(self)
	level.mirror_count -= 1
	queue_free()


func _on_rotate_button_button_down() -> void:
	is_rotating = true