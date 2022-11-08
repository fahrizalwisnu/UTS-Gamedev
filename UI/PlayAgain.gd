extends Control

func initialize(status):
	if status == "Won":
		$VBoxContainer/Label.text = "cms"
	else:
		$VBoxContainer/Label.text = ""


func _on_Button_pressed():
	var _return = get_tree().change_scene("res://Entities/Level.tscn")
	queue_free()


func _on_Button2_pressed():
	var _return = get_tree().change_scene("res://UI/Setting.tscn")
	queue_free()


func _on_Button3_pressed():
	get_tree().quit()




func _on_Level_1_pressed():
	var _return = get_tree().change_scene("res://World.tscn")
	queue_free()


func _on_Level_2_pressed():
	var _return = get_tree().change_scene("res://LV 2/LV2.tscn")
	queue_free()


func _on_Level_3_pressed():
	var _return = get_tree().change_scene("res://LV 3/LV3.tscn")
	queue_free()


func _on_Level_4_pressed():
	var _return = get_tree().change_scene("res://LV 4/LV4.tscn")
	queue_free()


func _on_Level_5_pressed():
	var _return = get_tree().change_scene("res://LV 5/LV5.tscn")
	queue_free()


func _on_Quit_pressed():
	var _return = get_tree().change_scene("res://UI/PlayAgain.tscn")
	queue_free()
