extends CharacterBody2D

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene.find_child("Level")

@onready var hit_box: Area2D = $HitBox
@onready var bounce_box: CollisionShape2D = $BounceBox
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var laser_shoot: AudioStreamPlayer = $LaserShoot

@export var SPEED = 5000
@export var color: Array:
	set(value):
		set_color(value[0], value[1], value[2])
		color = value


func _ready() -> void:
	color = [255, 255, 255]
	motion_mode = MOTION_MODE_FLOATING
	laser_shoot.play()
	level.shot_count += 1


func _physics_process(delta: float) -> void:
	velocity = SPEED * delta * Vector2(cos(rotation), sin(rotation))
	move_and_slide()


func set_color(red: int = 0, green: int = 0, blue: int = 0):
	sprite.material.set("shader_param/red", red / 255)
	sprite.material.set("shader_param/green", green / 255)
	sprite.material.set("shader_param/blue", blue / 255)


func _on_hit_box_body_entered(body: TileMapLayer) -> void:
	SPEED = 0
	sprite.frame = 1
	z_index = 1
	hit_box.queue_free()
	bounce_box.queue_free()
