extends Area2D
#path to a node in the three (in this case the Timer)
@onready var timer: Timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	print("u died") ## print debugger
	Engine.time_scale = 0.5 ## set speed to halve speed
	body.get_node("collision").queue_free() #player died -> verwijder collsion shape (val door de map heen)
	timer.start()

#when timer ends: reloads the scene (restart the game)
func _on_timer_timeout() -> void:
	Engine.time_scale = 1 ## set speed of game back to 1
	get_tree().reload_current_scene()
