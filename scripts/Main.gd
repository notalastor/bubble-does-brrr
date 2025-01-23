extends Control
var rotate: float
@onready var label: Label = $Label
func _physics_process(delta: float) -> void:
	rotate += delta
	label.position.y = ((sin(rotate) * cos(rotate)) * 20 + 100) 
	

#ضغوطات نفسية و جسدية
func _on_get_out_pressed() -> void:
	get_tree().quit()
func _on_begin_pressed() -> void:
	print("OMG THATS SO FUNNY, here take one billion dollar")

# جماليات
func _on_get_out_mouse_entered() -> void:
	create_tween().tween_property($"VBoxContainer/GET OUT","theme_override_font_sizes/font_size", 77, 0.2)
func _on_begin_mouse_entered() -> void:
	create_tween().tween_property($VBoxContainer/Begin,"theme_override_font_sizes/font_size", 77, 0.2)
func _on_begin_mouse_exited() -> void:
	create_tween().tween_property($VBoxContainer/Begin,"theme_override_font_sizes/font_size", 66, 0.2)
func _on_get_out_mouse_exited() -> void:
	create_tween().tween_property($"VBoxContainer/GET OUT","theme_override_font_sizes/font_size", 66, 0.2)
