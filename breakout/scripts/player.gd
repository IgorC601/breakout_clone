extends CharacterBody2D

const SPEED = 500.0
var heart_list : Array[TextureRect]
@export var lifes := 3

@onready var hearts_container: HBoxContainer = $"../UserInterface/Healthbar/HBoxContainer"

func _ready() -> void:
	for child in hearts_container.get_children():
		heart_list.append(child)
		
		
func take_dmg() -> void:
	if lifes > 0:
		lifes -= 1
		update_heart_display()
	else: 
		death()


func update_heart_display() -> void:
	for i in range(heart_list.size()):
		heart_list[i].visible = i < lifes


func death() -> void:
	get_tree().reload_current_scene()


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_collide(velocity * delta)
