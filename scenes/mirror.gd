extends Area2D

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene.find_child("Level")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D
@onready var rotate_button: TextureButton = $RotateButton
@onready var minus_button: TextureButton = $MinusButton
@onready var lock_button: TextureButton = $LockButton
@onready var reflect: AudioStreamPlayer = $Reflect
const ROTATE_SPRITE = preload("res://sprites/rotate.png")
const ROTATE_PRESSED_SPRITE = preload("res://sprites/rotate_pressed.png")

@export var mirror_rotation : float = 0:
	set(value):
		sprite_2d.rotation = value
		collision.rotation = value
		mirror_rotation = value
@export var locked : bool = true
@export var mirror_rotation_amount : float = PI/8
@export var is_moving : bool = false:
	set(value):
		is_moving = value
		#if value:
			#rotate_button.texture_normal = ROTATE_PRESSED_SPRITE
		#else:
			#rotate_button.texture_normal = ROTATE_SPRITE
			#rotate_button.texture_pressed = ROTATE_PRESSED_SPRITE
			
@export var is_rotating : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lock_button.rotation -= rotation
	rotate_button.hide()
	minus_button.hide()
	lock_button.hide()
	level.mirror_count += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("input_action"):
		is_moving = false
		is_rotating = false
	if is_moving:
		position = get_global_mouse_position()
	elif is_rotating:
		mirror_rotation = get_local_mouse_position().angle()


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


func _on_body_entered(body: Node2D) -> void:
	var new_velocity = body.velocity
	body.velocity = Vector2()
	var velocity_angle = new_velocity.angle()
	var combined_rotation = rotation + mirror_rotation
	
	new_velocity = new_velocity.rotated(-(combined_rotation))
	new_velocity.y *= -1
	new_velocity = new_velocity.rotated(combined_rotation)
	
	body.velocity = new_velocity
	body.rotation = new_velocity.angle()
	reflect.play()


func _on_touch_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if level.is_build_mode and not locked and event.has_method("is_action_pressed") and event.is_action_pressed("input_action"):
		is_moving = true


func _on_minus_button_pressed() -> void:
	var level_mirrors : Array = level.mirrors
	level_mirrors.erase(self)
	level.mirror_count -= 1
	queue_free()


func _on_rotate_button_button_down() -> void:
	is_rotating = true
