extends CharacterBody2D

const SPEED = 500.0
var heart_list : Array[TextureRect]
var end_score : int
@export var lifes := 3

@onready var hearts_container: HBoxContainer = $"../UserInterface/Healthbar/HBoxContainer"
@onready var score_label: Label = $"../UserInterface/ScoreLabel"
@onready var ball: CharacterBody2D = %Ball

signal final_score(score: String)

func _ready() -> void:
	for child in hearts_container.get_children():
		heart_list.append(child)
	
	ball.hit_ceiling.connect(change_sprite)
	change_sprite(ball.ceiling)
	
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
	end_score = int(score_label.text.substr(7, 4).lstrip("0"))
	final_score.emit(end_score)
	get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")


func change_sprite(check: bool) -> void:
	if check:
		$Sprite2D.scale = $Sprite2D.scale * 0.5
		$CollisionShape2D.scale = $CollisionShape2D.scale * 0.5


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_collide(velocity * delta)
