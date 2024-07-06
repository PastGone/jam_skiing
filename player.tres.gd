extends CharacterBody2D
@export var is_editor:bool
@onready var shape_cast_2d: ShapeCast2D = $ShapeCast2D

const SPEED = 600.0
const JUMP_VELOCITY = -800.0



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		pass

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	if Input.is_action_just_pressed("ui_accept") and shape_cast_2d.is_colliding()  :

		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if is_editor:
		velocity.x = SPEED
	move_and_slide()
	
	
func _input(event:InputEvent):
	if event is InputEventMouseButton and shape_cast_2d.is_colliding():
		if event.button_index==MOUSE_BUTTON_LEFT and event.is_pressed() :
			velocity.y = JUMP_VELOCITY
			return
					#清除路标
		
	pass
