extends Node2D


var other:=preload("res://build/other_snowball.tscn")

#子节点等于数量。 
var other_index:int=1

#每一次要增加子节点的数量 
var add_other_num=1
# 
var all_scale=Vector2(1,1)
# 
var max_scale:=Vector2(4,4)
var scale_num:float=1
var display_current_scale=Vector2(1,1)
# 
@onready var label: Label = $Player/Label
@onready var player: CharacterBody2D = %Player
@onready var jump: AudioStreamPlayer = $"../sound_manger/jump"



func _ready() -> void:
	pass



func _input(event:InputEvent):
	
	if GlobalParms.is_mobile_platform():
		return
	
	if not GlobalParms.is_mobile_platform() and GlobalParms.use_V_stick:
		return
	
	
		
	if event is InputEventMouseButton :
		if event.button_index==MOUSE_BUTTON_LEFT and event.is_pressed() :
			all_jump()
			return
	
#	合并在这里
	if Input.is_action_just_pressed("ui_accept") :
		combine()
		return

#	分裂在这里。 
	if event is InputEventMouseButton :
		if event.button_index==MOUSE_BUTTON_RIGHT and event.is_pressed() :
				split()
				pass
		pass



func _process(_delta: float) -> void:
	print(self.all_scale)
	
	
	for c in get_children():
		c.scale=all_scale
		
	if self.all_scale>max_scale:
		self.all_scale=max_scale

	scale_num=display_current_scale.x/Vector2(1,1).x
	if scale_num<0.5:
		label.self_modulate=Color(255,0,0,255)
	if scale_num<0.2:
		get_tree().change_scene_to_packed(load("res://lost.tscn"))
		
	label.text=str("X","%.1f" % scale_num)
	
	pass



func split():
	if self.all_scale>Vector2(2,2): 
		self.all_scale/=2
		display_current_scale/=2
		for i in range(0,add_other_num):
			var a:CharacterBody2D=other.instantiate()
			a.position.x=+player.position.x+(other_index*-200)*self.all_scale.x
			a.position.y=player.position.y+(-200*self.all_scale.y)
			
			other_index+=1
			self.add_child(a)
			add_other_num*=2
			
			


func all_jump():
	if player.shape_cast_2d.is_colliding():
		for c in get_children():
			c.mjump()
		jump.play()



func combine():
	for c in self.get_children():
			if c.is_in_group("snow_ball"):
				c.queue_free()
				
			pass
	display_current_scale=self.all_scale*other_index  
	# 缩放不能超过最大值
	if self.all_scale*other_index >max_scale:
		self.all_scale=max_scale
	else:
		self.all_scale*=other_index
	# 重置其他数量
	other_index=1
	add_other_num=1


func _on_combine_button_up() -> void:
	combine()
	pass # Replace with function body.


func _on_split_button_up() -> void:
	split()
	pass # Replace with function body.


func _on_up_button_up() -> void:
	all_jump()
	pass # Replace with function body.
