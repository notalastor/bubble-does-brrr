extends Area2D
var count: int

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.win = true 
		$winning.visible = true
		create_tween().tween_property($winning/Label2,"modulate",Color(1, 1, 1),0.5)
		$winning/Label2.text = "YOU DID 
G R E A T !
" + str(body.shoot)+ "/"+str(count)
