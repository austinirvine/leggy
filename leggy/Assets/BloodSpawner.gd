extends Spatial

var blood_splat = preload("res://Assets/Splat.tscn")
var max_instances = 30
var cur_instances = 0

var array_instances = []

var cur_sawing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_instance_particles()
	pass # Replace with function body.

func _instance_particles() :
	if(cur_instances < max_instances) :
		var splatstance = blood_splat.instance()
		get_parent().get_parent().add_child(splatstance)
		cur_instances += 1
	else :
		yield(get_tree().create_timer(randi() % 2), "timeout")

	yield(get_parent().get_node("Character"), "_on_sawing")
	_instance_particles()


func _on_sawing(sawing):
	cur_sawing = sawing
	_blood_sound()
	print("change of state")

func _blood_sound():
	print("FIXME")
	# Not working for some reason
	var b_sound = get_node("AudioStreamPlayer3D")
	print(cur_sawing)
	#print("scumlade")
	b_sound._set_playing(cur_sawing)
