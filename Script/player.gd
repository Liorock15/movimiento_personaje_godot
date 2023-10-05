extends CharacterBody3D
@onready var camara = $camara
@onready var Animation_Player = $visual/mixamo_base/AnimationPlayer


var SPEED = 2.8
const JUMP_VELOCITY = 4.5

var wilkeng = 3.0
var running_speed = 5.0 

var running= false

@export var sens_horizontal= 0.5 
@export var sens_vertical = 0.5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode= Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x*sens_horizontal))

		camara.rotate_x(deg_to_rad(-event.relative.y*sens_vertical))
		

func _physics_process(delta):
	if Input.is_action_pressed("run"):
		SPEED=running_speed
		running=Tree
	else :
		SPEED=wilkeng 
		running=false
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if running:
			if Animation_Player.current_animation != "running": 
				Animation_Player.play("running")
		else:
			if Animation_Player.current_animation != "wilkeng": 
				Animation_Player.play("walking")
			

		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if Animation_Player.current_animation != "idle": 
			Animation_Player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
