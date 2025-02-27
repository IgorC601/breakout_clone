extends Label

var high_score := 0
var save_path = "user://score.save"
var last_score_path = "user://last_score.save"

@onready var player: CharacterBody2D = %Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get score when player dies
	player.final_score.connect(check_high_score)
	
	# Check if it updates
	check_high_score(player.end_score)
	
	# Show High Score
	text = "HIGH SCORE: %0*d" % [4, high_score]


func check_high_score(score: int) -> void:
	save_last_score(score)
	high_score = load_score()
	if score > high_score:
		save_score(score)


func load_score() -> int:
	# If file exists, read it and get the high score
	if FileAccess.file_exists(save_path):
		print("file found")
		var file = FileAccess.open(save_path, FileAccess.READ)
		high_score = file.get_var()
	else:
		print("file not found")
		high_score = 0
	return high_score


func save_last_score(prev_score: int):
	var file = FileAccess.open(last_score_path, FileAccess.WRITE)
	file.store_var(prev_score)


func save_score(end_score: int):
	# Write in file to update the high score
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(end_score)
