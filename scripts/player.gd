extends CharacterBody3D
@onready var neck: Node3D = $Neck
@onready var camera_3d: Camera3D = $Neck/Camera3D
@onready var grab_range: RayCast3D = $Neck/grabRange
var object = Object
@onready var key: StaticBody3D = $"../Key"


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const sprintSpeed = 10.0

func _ready() -> void:
	grab_range.target_position = Vector3(0, 0, -5)

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if Input.is_action_pressed("sprint"):
			velocity.x = direction.x * sprintSpeed
			velocity.z = direction.z * sprintSpeed
		else:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	if Input.MOUSE_MODE_CAPTURED:
		#Camera movement logic
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x*0.005)
			camera_3d.rotate_x(-event.relative.y*0.005)
			camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-60), deg_to_rad(60))
			grab_range.global_transform = camera_3d.global_transform

	if Input.is_action_just_pressed("interact"):
		#Interaction Login
		if grab_range.is_colliding(): #Checks if raycast is colliding
			var target = grab_range.get_collider() #Assigns raycast to the target object
			while target and not (target.is_in_group("Collectible") or target.is_in_group("Door")): #Ensures target exists and constantly loops until it finds a target with the proper tag
				target = target.get_parent() #Sets the target to the actual object rather than the collision shape
				
				
			if target: #Ensures target exists
				if target.is_in_group("Collectible"): #If its a collectible do this
					print("Picked up: ", target.name)
					LeGame.inventory["key_count"] = LeGame.inventory.get("key_count", 0) + 1 #Adds to the key count so key names dont matter
					target.queue_free()
				elif target.is_in_group("Door"): #If its a door do this
					print("Attempting to open door")
					if LeGame.inventory["key_count"] > 0:
						LeGame.inventory["key_count"] -= 1
						print("Opening Door")
						print("Current key count: ", LeGame.inventory["key_count"])
						target.call_deferred("queue_free")
				else: #Anything else do this (debug)
					print("Hit object, but it's not collectible.")
		else: #Extra debug
			print("Nothing to interact with.")
	
	if Input.is_action_just_pressed("openInventory"):
		#Inventory Logic
		if LeGame.inventory:
			pass
		pass
		
		
	
