extends StaticBody

export(NodePath) var leg

const SAW_FORWARD_THRESHOLD := -1.0
const SAW_BACK_THRESHOLD := 4.0
const FORWARD := 0
const BACK := 1
var direction : int = FORWARD
var last_drag_pos := Vector2()
var saw_time := 0.0

func _ready():
	leg = get_node(leg)
	assert(leg)

	translation.z = SAW_BACK_THRESHOLD

func _input(event):
	if event.is_action_pressed("click"):
		last_drag_pos = get_viewport().get_mouse_position()

func _process(delta):
	saw_time += delta

	if Input.is_action_pressed("click"):
		var new_drag_pos : Vector2 = get_viewport().get_mouse_position()
		var drag_delta : float = (new_drag_pos - last_drag_pos).x * -0.01
		last_drag_pos = new_drag_pos
		move_saw(drag_delta)

func move_saw(amount: float):
	if get_parent().get_parent().done:
		return

	translation.z = clamp(translation.z + amount, SAW_FORWARD_THRESHOLD, SAW_BACK_THRESHOLD)
	if direction == FORWARD:
		if amount < 0.0:
			translation.y += amount * 0.01

		if is_equal_approx(translation.z, SAW_FORWARD_THRESHOLD):
			direction = BACK
			$ForwardSound.pitch_scale = max(1.0 / saw_time * 0.4, 1.0)
			$ForwardSound.play()
			saw_time = 0.0

			if translation.y < 0.3:
				leg.amputate()
	else:
		if is_equal_approx(translation.z, SAW_BACK_THRESHOLD):
			direction = FORWARD
			$BackSound.pitch_scale = max(1.0 / saw_time * 0.4, 1.0)
			$BackSound.play()
			saw_time = 0.0

"""
func _saw_pitch(delta) :
	var blood = get_parent().get_node("Blood")
	var pitch_value = audio_player_in.get_pitch_scale() * delta / 10
	audio_player_in.set_pitch_scale(delta + audio_player_in.get_pitch_scale())
	audio_player_out.set_pitch_scale(delta + audio_player_out.get_pitch_scale())

	if(delta > .1) :
		audio_player_in.set_pitch_scale(1)
		audio_player_out.set_pitch_scale(1)
"""
