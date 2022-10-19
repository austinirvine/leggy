extends Spatial


func amputate():
	$calf_norag.set_visible(false)
	$calf_withrag.set_visible(true)
	$calf_withrag.pause_mode = Node.PAUSE_MODE_INHERIT

	get_parent().get_parent().done = true
	Global.hud.stop()
	Global.hud.message("YOU DID IT! Good job. Now get back in the field, soldier.")
