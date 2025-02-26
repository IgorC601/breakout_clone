extends Node

@export var rows := 6
@export var cols := 16
@export var margin = 60

@onready var brick_collection: Node = $Bricks
@onready var brick = preload("res://scenes/brick.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_level()

func setup_level() -> void:
	for r in rows:
		for c in cols:
			# Generate Brick
			var new_brick = brick.instantiate()
			brick_collection.add_child(new_brick)
			new_brick.name = "Brick_" + str(r) + "_" + str(c)
			new_brick.position = Vector2(margin + (39 * c), margin + (32 * r))
			
			# Change sprite based on row
			var sprite = new_brick.get_node("Sprite2D")
			sprite.region_rect = Rect2(112, 16*r, 32, 16)
		
