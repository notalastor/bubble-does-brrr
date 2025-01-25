extends Control
var rotate: float
@onready var label: Label = $Label
func _ready() -> void:
	$AnimationPlayer.play_backwards("start")
	await get_tree().create_timer(2).timeout
	$CanvasLayer.visible = false
func _physics_process(delta: float) -> void:
	rotate += delta
	label.position.y = ((sin(rotate) * cos(rotate)) * 20 + 100) 
	$VBoxContainer.position.y = -((sin(rotate/4) * cos(rotate)) * 20 - 300) 
var smsm = 0

#ضغوطات نفسية و جسدية
func _on_get_out_pressed() -> void:
	$AudioStreamPlayer.play()
	smsm+=1
	if smsm == 1:
		$"VBoxContainer/GET OUT".text = "you sure ?"
	elif smsm == 2:
		$"VBoxContainer/GET OUT".text = "please no:("
	elif smsm == 3:
		$"VBoxContainer/GET OUT".text = "dude plz no !"
	elif smsm ==4:
		$"VBoxContainer/GET OUT".text = "NOOOOO!!!"
		await get_tree().create_timer(2).timeout
		get_tree().quit()
	
func _on_begin_pressed() -> void:
	$AudioStreamPlayer.play()
	$CanvasLayer.visible = true
	$AnimationPlayer.play("start")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/test.tscn")

# جماليات
func _on_get_out_mouse_entered() -> void:
	$AudioStreamPlayer.play()
	create_tween().tween_property($"VBoxContainer/GET OUT","theme_override_font_sizes/font_size", 88, 0.2)
func _on_begin_mouse_entered() -> void:
	$AudioStreamPlayer.play()
	create_tween().tween_property($VBoxContainer/Begin,"theme_override_font_sizes/font_size", 88, 0.2)
func _on_begin_mouse_exited() -> void:
	create_tween().tween_property($VBoxContainer/Begin,"theme_override_font_sizes/font_size", 77, 0.2)
func _on_get_out_mouse_exited() -> void:
	create_tween().tween_property($"VBoxContainer/GET OUT","theme_override_font_sizes/font_size", 77, 0.2)

var lang: String
func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		lang = "arabic"
		$Label.text = "سبلت !"
		$Label/Label2.text = "لو مكيف"
		$VBoxContainer/Begin.text = "ابدأ"
		$"VBoxContainer/GET OUT".text = "خروج"
	else:
		lang = "english"
		$VBoxContainer/Begin.text = "begin"
		$"VBoxContainer/GET OUT".text = "Exit"
		$Label.text = "SPLIT!"
		$Label/Label2.text = "DEMO"
	print(lang)
