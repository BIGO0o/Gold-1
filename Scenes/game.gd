extends Node

func _process(delta: float) -> void:
	print("FPS: " + str(Engine.get_frames_per_second()))
