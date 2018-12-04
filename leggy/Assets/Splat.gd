extends Spatial

var throw_dir = Vector3 (0.0, 0.0, 0.0)
var life = 0
var pos_o_neg = true

func _ready():
	randomize()

	var dir_posOneg = randf()
	if dir_posOneg < .4 :
		pos_o_neg = false
		pass

	#var material = get_child(0).get_surface_material(0)
	var material = get_child(0).mesh.material
	_set_rand_transform()
	_lighten(material)
	pass

func _set_rand_transform() :
	var loc = self.get_translation()
	var location = Vector3( randf() + loc.x, randf() + loc.y, randf() + loc.z)
	var rotation = Vector3( randi() % 50, randi() % 20, randi() % 20 )
	var scale = Vector3( randf(), randf(), randf() )

	self.set_translation(location)
	#self.set_rotation(rotation)
	self.set_scale(scale)
	pass

func _direction_set() :
	var multiplier = -1.0
	if pos_o_neg:
		multiplier = 1.0

	throw_dir = Vector3( multiplier * 10, 15, multiplier * 10 )
	pass

func _toss() :
	self.translate(self.translation + throw_dir)
	pass

func _lighten(mat):
	if (mat != null) :
		yield(get_tree().create_timer(0.10), "timeout")
		if life > 6 :
			_destruct()
			pass
		else :
			life += 1
			_toss()
			_lighten(mat)
			pass
	pass

func _destruct():
	queue_free()
