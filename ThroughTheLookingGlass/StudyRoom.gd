extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_view()
	pass

func change_view():
	if Input.is_action_just_pressed("glasses"):
		get_node("ParentView").visible = not get_node("ParentView").visible
		get_node("ChildView").visible = not get_node("ChildView").visible

