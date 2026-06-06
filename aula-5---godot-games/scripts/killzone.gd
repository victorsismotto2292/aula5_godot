
extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	print("Colisão detectada com: ", body.name)
	if body.has_method("die"):
		body.die()
