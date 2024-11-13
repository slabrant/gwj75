extends CharacterBody2D

@onready var world: Node = get_tree().root.get_child(0).find_child("World")

@onready var hit_box: Area2D = $HitBox
@onready var bounce_box: CollisionShape2D = $BounceBox
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var laser_shoot: AudioStreamPlayer = $LaserShoot

@export var SPEED = 5000

func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING
	laser_shoot.play()
	world.shot_count += 1


func _physics_process(delta: float) -> void:
	velocity = SPEED * delta * Vector2(cos(rotation), sin(rotation))
	move_and_slide()


func _on_hit_box_body_entered(body: TileMapLayer) -> void:
	SPEED = 0
	sprite.frame = 1
	z_index = -1
	hit_box.queue_free()
	bounce_box.queue_free()
