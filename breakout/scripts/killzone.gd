extends Area2D

@onready var player: CharacterBody2D = %Player
@onready var ball: CharacterBody2D = %Ball
@onready var timer: Timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	if body.name == ball.name:
		player.take_dmg()

	ball.reset_ball()
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
