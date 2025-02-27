extends CharacterBody2D

# Vars & Consts
const ACELERATION = 20.0
var init_speed = 205.0
var SPEED = 205.0
var direction := Vector2.DOWN
var ceiling := false

# Node's Callable
@onready var player: CharacterBody2D = $"../Player"
@onready var hit_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Signals
signal score_update(score : int)
signal hit_ceiling(check: bool)

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = direction * SPEED
	var collision = move_and_collide(velocity * delta)
	
	# If it collides it bounces
	if collision:
		hit_sound.play()
		if collision.get_collider() == player:
			direction = (global_position - player.global_position).normalized()
		elif str(collision.get_collider()).contains("Brick"):
			direction = direction.bounce(collision.get_normal())
			
			var points := assign_points(collision.get_collider())
			score_update.emit(points)
			
			collision.get_collider().queue_free()
			SPEED += ACELERATION
		else:
			direction = direction.bounce(collision.get_normal())
		
		if collision.get_collider().name == "Wall" and !ceiling:
			ceiling = true
			hit_ceiling.emit(ceiling)


func assign_points(brick: Node2D) -> int:
	# Brick Name = Brick_RowID_ColID
	# Points based on the RowID, from 1 -> 6
	var points = 7 - (int(str(brick.name)[6]) + 1)
	return points

func reset_ball() -> void:
	position = Vector2(player.global_position.x, player.global_position.y - 10)
	SPEED = init_speed
	
