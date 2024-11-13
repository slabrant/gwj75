extends CharacterBody2D

@onready var hit_box: Area2D = $HitBox
@onready var bounce_box: CollisionShape2D = $BounceBox
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var laser_shoot: AudioStreamPlayer = $LaserShoot

func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING
	laser_shoot.play()


func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_hit_box_body_entered(body: TileMapLayer) -> void:
	velocity = Vector2()
	sprite.frame = 1
	z_index = -1
	hit_box.queue_free()
	bounce_box.queue_free()
