extends Area2D

var voorbeeld: float = 0
#signal when something touches the coin
func _on_body_entered(body: Node2D) -> void:
	print("Je hebt een munt opgepakt!")
	queue_free()
	PlayerStats.coins+=1
	pass # Replace with function body.
