@tool
extends Node3D

func _ready():
	# Poistka, aby sa model negeneroval opakovane pri každom načítaní
	if get_child_count() > 0:
		return
		
	var scene_root = get_tree().edited_scene_root
		
	# Hlava kľúča (očko na zavesenie)
	var head = CSGTorus3D.new()
	head.inner_radius = 0.05
	head.outer_radius = 0.1
	head.position = Vector3(0, 0, -0.2)
	head.rotation_degrees = Vector3(90, 0, 0)
	add_child(head)
	if Engine.is_editor_hint(): head.owner = scene_root

	# Telo kľúča (hlavná tyčka)
	var shaft = CSGCylinder3D.new()
	shaft.radius = 0.02
	shaft.height = 0.4
	shaft.rotation_degrees = Vector3(90, 0, 0)
	add_child(shaft)
	if Engine.is_editor_hint(): shaft.owner = scene_root

	# Základňa pre zúbky kľúča
	var teeth = CSGBox3D.new()
	teeth.size = Vector3(0.02, 0.08, 0.1)
	teeth.position = Vector3(0, 0.04, 0.1)
	add_child(teeth)
	if Engine.is_editor_hint(): teeth.owner = scene_root
	
	# Procedurálny výrez v zúbkoch pre detailnejší tvar
	var cut = CSGBox3D.new()
	cut.operation = CSGShape3D.OPERATION_SUBTRACTION
	cut.size = Vector3(0.04, 0.08, 0.04)
	cut.position = Vector3(0, 0.04, 0.1)
	teeth.add_child(cut)
	if Engine.is_editor_hint(): cut.owner = scene_root
