extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.ded = true
var x = 0
func _physics_process(delta: float) -> void:
	x += delta
	$Goaway.skew = sin(x)/10
