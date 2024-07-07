extends Node
enum mode{nomal,display,hard}
var cur_mode=mode.nomal 
var use_V_stick:bool=true

func is_mobile_platform():
	var platform_name = OS.get_name()

	if platform_name == "iOS" or platform_name == "Android":
		return true
	else:
		return false
