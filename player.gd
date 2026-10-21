extends CharacterBody3D

const SPEED = 5.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") # Načítanie globálnej gravitácie

func _physics_process(delta):
	# Aplikovanie gravitácie, ak hráč nie je na zemi
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Získanie smeru z tvojich nastavení v Input Map
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	# Výpočet globálneho smeru (bez transform.basis)
	var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		# Postava sa otočí v smere chôdze v globálnom priestore
		var look_target = global_position + direction
		look_at(look_target, Vector3.UP)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
