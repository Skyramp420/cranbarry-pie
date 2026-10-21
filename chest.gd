@tool
extends Node3D

var is_player_near = false
var is_open = false

var interact_area: Area3D
var ui_layer: CanvasLayer
var ui_panel: Panel
var use_button: Button
var lid: CSGBox3D

func _ready():
	# Poistka proti duplikovaniu uzlov pri každom uložení
	if get_child_count() > 0:
		# Prepojíme premennú veka s už existujúcim uzlom, ak editor uzly vytvoril
		for child in get_children():
			if child is CSGBox3D and child.position.y > 0.4:
				lid = child
	else:
		var scene_root = get_tree().edited_scene_root
		
		# 1. AUTOMATICKÉ VYTVORENIE 3D MODELU TRUHLY (Viditeľné v editore)
		var base = CSGBox3D.new()
		base.size = Vector3(1.0, 0.5, 0.8)
		base.position = Vector3(0, 0.25, 0)
		base.use_collision = true
		add_child(base)
		if Engine.is_editor_hint(): base.owner = scene_root
		
		lid = CSGBox3D.new()
		lid.size = Vector3(1.0, 0.2, 0.8)
		lid.position = Vector3(0, 0.6, 0)
		lid.use_collision = true
		add_child(lid)
		if Engine.is_editor_hint(): lid.owner = scene_root

	# Zastavíme vykonávanie zvyšku skriptu, ak sme v editore (aby sa netvorilo UI a Area)
	if Engine.is_editor_hint():
		return

	# 2. AUTOMATICKÉ VYTVORENIE ZÓNY PRE DETEKCIU HRÁČA (Iba v hre)
	interact_area = Area3D.new()
	add_child(interact_area)
	
	var col_shape = CollisionShape3D.new()
	var shape = BoxShape3D.new()
	shape.size = Vector3(2.5, 2.0, 2.5)
	col_shape.shape = shape
	interact_area.add_child(col_shape)
	
	interact_area.body_entered.connect(_on_body_entered)
	interact_area.body_exited.connect(_on_body_exited)

	# 3. AUTOMATICKÉ VYTVORENIE UI ROZHRANIA (Iba v hre)
	ui_layer = CanvasLayer.new()
	add_child(ui_layer)
	
	ui_panel = Panel.new()
	ui_panel.size = Vector2(300, 120)
	ui_panel.position = get_viewport().get_visible_rect().size / 2.0 - (ui_panel.size / 2.0)
	ui_layer.add_child(ui_panel)
	
	var label = Label.new()
	label.text = "Locked Chest"
	label.position = Vector2(100, 20)
	ui_panel.add_child(label)
	
	use_button = Button.new()
	use_button.size = Vector2(130, 40)
	use_button.position = Vector2(85, 60)
	use_button.pressed.connect(_on_use_pressed)
	ui_panel.add_child(use_button)
	
	ui_layer.hide()

func _input(event):
	# Ignorujeme vstupy, kým sme len v editore
	if Engine.is_editor_hint():
		return
		
	# Ak stlačíš F, si blízko a truhla je zatvorená
	if is_player_near and not is_open and event.is_action_pressed("interact"):
		ui_layer.show()
		
		# Kontrola, či je kľúč v globálnom inventári
		if "Rusty Key" in GlobalInventory.items:
			use_button.text = "Use Rusty Key"
			use_button.disabled = false
		else:
			use_button.text = "Need a Key!"
			use_button.disabled = true

func _on_body_entered(body):
	if body.is_in_group("Player"):
		is_player_near = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		is_player_near = false
		if ui_layer != null:
			ui_layer.hide()

func _on_use_pressed():
	if "Rusty Key" in GlobalInventory.items:
		is_open = true
		ui_layer.hide()
		
		# 1. Odstránenie kľúča z inventára
		GlobalInventory.items.erase("Rusty Key")
		
		# 2. Vizuálne otvorenie veka truhly (posun dozadu a rotácia)
		lid.position = Vector3(0, 0.8, -0.4)
		lid.rotation_degrees = Vector3(-60, 0, 0)
		
		print("Truhla sa otvorila a kľúč bol použitý!")
