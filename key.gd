extends Area3D

var is_player_near = false
@onready var ui_panel = $CanvasLayer/Panel # Cesta k tvojmu UI panelu
@onready var yes_button = $CanvasLayer/Panel/ButtonYes # Cesta k tlačidlu Yes
@onready var no_button = $CanvasLayer/Panel/ButtonNo # Cesta k tlačidlu No

func _ready():
	ui_panel.hide()
	# Prepojíme signály z tlačidiel cez kód
	yes_button.pressed.connect(_on_yes_pressed)
	no_button.pressed.connect(_on_no_pressed)

func _input(event):
	# Ak je hráč blízko a stlačí klávesu "F"
	if is_player_near and event.is_action_pressed("interact"):
		ui_panel.show()
		# Voliteľné: tu môžeš napr. pozastaviť hru, aby hráč nemohol odísť kým neodpovie

# Tieto dve funkcie musíme prepojiť cez Node -> Signals (body_entered a body_exited)
func _on_body_entered(body):
	if body.is_in_group("Player"):
		is_player_near = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		is_player_near = false
		ui_panel.hide() # Skryjeme UI ak hráč odíde preč

func _on_yes_pressed():
	GlobalInventory.add_item("Rusty Key") # Zapíše kľúč do pamäte
	print("Kľúč bol zobratý!")
	ui_panel.hide()
	queue_free() # Zničí kľúč zo scény (hráč ho "zobral")

func _on_no_pressed():
	print("Kľúč zostáva na mieste.")
	ui_panel.hide()
