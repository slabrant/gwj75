extends Area2D

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene
const WIN_MENU = preload("res://scenes/menus/win_menu.tscn")
@onready var sprite: Sprite2D = $Sprite2D

@export var color: Array:
	set(value):
		set_color(value[0], value[1], value[2])
		color = value


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_shader(true)


func set_shader(value):
	if sprite:
		sprite.material.set("shader_param/active", value)


func set_color(red: int = 0, green: int = 0, blue: int = 0):
		sprite.material.set("shader_param/red", red / 255)
		sprite.material.set("shader_param/green", green / 255)
		sprite.material.set("shader_param/blue", blue / 255)


func _on_body_entered(body: Node2D) -> void:
	if level.shot_count <= 8 and level.mirror_count <= 2:
		world.level_score = 3
	elif level.shot_count <= 15 and level.mirror_count <= 5:
		world.level_score = 2
	else:
		world.level_score = 1
		
	set_shader(false)
	color = body.color
	
	body.queue_free()
	var menu = WIN_MENU.instantiate()
	get_tree().root.add_child(menu)
