extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_hit_box_body_entered(body: TileMapLayer) -> void:
	velocity = Vector2()
	sprite.frame = 1
	z_index = -1
