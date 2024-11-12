extends CharacterBody2D

@onready var hit_box: Area2D = $HitBox
@onready var bounce_box: CollisionShape2D = $BounceBox
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING
	pass


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta, false, 1000, true)
	#if collision:
		#velocity = velocity.slide(collision.normal)
	


func _on_hit_box_body_entered(body: TileMapLayer) -> void:
	velocity = Vector2()
	sprite.frame = 1
	z_index = -1
	hit_box.queue_free()
	bounce_box.queue_free()
