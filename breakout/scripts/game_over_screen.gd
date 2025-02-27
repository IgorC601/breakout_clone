extends Control

var save_path = "user://score.save"
var last_score_path = "user://last_score.save"

var high_score := 0
var last_score := 0

var finished = true
var time = 0.0
var time_to_current_score = 2.0
var a = true


func _process(delta):
	if finished and a:
		time += delta
		$CurrentScoreLabel.text = "Score: %0*d" % [4, int(time / time_to_current_score * last_score)]
		if time >= time_to_current_score:
			a = false
			$CurrentScoreLabel.text = "Score: %0*d" % [4, last_score]


func _ready() -> void:
	high_score = load_score()
	last_score = load_prev_score()
	$HighScoreLabel.text = "Highest Score: %0*d" % [4, high_score]
	
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
	
	
func load_prev_score() -> int:
	# If file exists, read it and get the high score
	if FileAccess.file_exists(last_score_path):
		print("file found")
		var file = FileAccess.open(last_score_path, FileAccess.READ)
		last_score = file.get_var()
	else:
		print("file not found")
		last_score = 0
	return last_score
	

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level1.tscn")
