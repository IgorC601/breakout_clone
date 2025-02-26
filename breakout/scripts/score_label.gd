extends Label

var score : int = 0

@onready var ball: CharacterBody2D = %Ball

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ball.score_update.connect(update_label)

func update_label(points: int) -> void:
	score += points
	text = "Score: %0*d" % [4, score]
