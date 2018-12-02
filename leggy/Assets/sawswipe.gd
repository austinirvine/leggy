extends Node2D



func _on_SwipeDetector_swipe_started( partial_gesture ):
	var point = partial_gesture.last_point()

func _on_SwipeDetector_swipe_updated( partial_gesture ):
	var point = partial_gesture.last_point()
	var player = get_parent().get_node(get_parent().charOBJ)
	player._saw_loc(point, partial_gesture.get_direction())

func _on_SwipeDetector_swipe_updated_with_delta( partial_gesture, delta ):
	var player = get_parent().get_node(get_parent().charOBJ)
	player._saw_pitch(delta)

func _on_SwipeDetector_swipe_ended( gesture ):
	var player = get_parent().get_node(get_parent().charOBJ)
	player._swipe_signal(gesture.get_direction())

func _on_SwipeDetector_swiped( gesture ):
	print(gesture.get_direction())
