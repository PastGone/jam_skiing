extends CharacterBody2D



@onready var sprite_2d: Sprite2D = $Sprite2D



	

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("gold"):
		print(body)
		
		body.queue_free()
	elif body.is_in_group("pitfall"):
		print(body)
		self.queue_free()
		body.queue_free()
		
	pass # Replace with function body.
