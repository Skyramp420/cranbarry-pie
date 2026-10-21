extends CanvasLayer

@onready var panel = $Panel
@onready var container = $Panel/VBoxContainer

func _ready():
	panel.hide()

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		if panel.visible:
			panel.hide()
		else:
			update_inventory_ui()
			panel.show()

func update_inventory_ui():
	# Vymaže staré tlačidlá, aby sa pri opakovanom otvorení inventára neduplikovali
	for child in container.get_children():
		child.queue_free()
		
	# Vytvorí nové tlačidlo pre každý predmet v globálnom poli
	for item_name in GlobalInventory.items:
		var btn = Button.new()
		btn.text = item_name
		# Prepojíme stlačenie tlačidla s funkciou a pošleme jej názov predmetu
		btn.pressed.connect(_on_item_clicked.bind(item_name))
		container.add_child(btn)

func _on_item_clicked(item_name: String):
	print("Klikol si v inventári na predmet: ", item_name)
	# Sem neskôr vložíme logiku pre zobrazenie kontextového menu "Use"
