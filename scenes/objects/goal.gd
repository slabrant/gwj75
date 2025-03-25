extends StaticBody2D

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene
@onready var sprite: Sprite2D = $Sprite2D

@export var color: Array = [255, 255, 255]


func _ready() -> void:
	sprite.material = sprite.material.duplicate()
	set_color(color[0], color[1], color[2])


func set_color(red: float = 0.0, green: float = 0.0, blue: float = 0.0):
	if !sprite:
		sprite = $Sprite2D
	sprite.material.set("shader_param/red", red / 255)
	sprite.material.set("shader_param/green", green / 255)
	sprite.material.set("shader_param/blue", blue / 255)


func reflect(body: Node2D) -> void:
	body.queue_free()
	
	if color == body.color:
		win()


func win():
	level.remove_goal(self)
	set_color(255, 255, 255)


func unwin():
	level.goals.append(self)
	set_color(color[0], color[1], color[2])
