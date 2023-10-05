extends Node3D


func _on_interactable_focused(interactor):
	scale_object_local(Vector3(15, 15, 15))


func _on_interactable_interacted(interactor):
	rotate(Vector3(1, 0, 0), 0.1)
	rotate_y(0.0001)


func _on_interactable_unfocused(interactor):
	pass # Replace with function body.
