extends CharacterBody2D

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene

@onready var hit_box: Area2D = $HitBox
@onready var bounce_box: CollisionPolygon2D = $BounceBox
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var blur: Sprite2D = $Blur
@onready var laser_shoot: AudioStreamPlayer = $LaserShoot
@onready var ray_cast: RayCast2D = $RayCast2D

@export var SPEED : int
@export var color: Array:
	set(value):
		set_color(value[0], value[1], value[2])
		color = value


func _ready() -> void:
	sprite.material = sprite.material.duplicate()
	blur.material = blur.material.duplicate()
	color = [255, 255, 255]
	motion_mode = MOTION_MODE_FLOATING
	laser_shoot.play()
	SPEED = 125 * world.bullet_speed_setting
	blur.scale.x *= float(world.bullet_speed_setting) / 45 + 0.45
	level.flying_beams.append(self)


func _physics_process(delta: float) -> void:
	velocity = SPEED * delta * Vector2(cos(rotation), sin(rotation))
	if (!!ray_cast and ray_cast.is_colliding()):
		ray_cast.get_collider().reflect(self)
	else:
		move_and_slide()


func set_color(red: int = 0, green: int = 0, blue: int = 0):
	sprite.material.set("shader_param/red", red / 255)
	sprite.material.set("shader_param/green", green / 255)
	sprite.material.set("shader_param/blue", blue / 255)
	blur.material.set("shader_param/red", red / 255)
	blur.material.set("shader_param/green", green / 255)
	blur.material.set("shader_param/blue", blue / 255)


func _on_hit_box_body_entered(body: TileMapLayer) -> void:
	SPEED = 0
	sprite.frame = 1
	blur.queue_free()
	z_index = 1
	hit_box.queue_free()
	ray_cast.queue_free()
	level.flying_beams.erase(self)
