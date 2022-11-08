extends KinematicBody2D

# Player movement
export var ACCELERATION = 500
export var FRICTION = 500
export var ROLL_SPEED = 125
export var SPEED = 80

enum { 
	MOVE, 
	ROLL, 
	ATTACK,
}

onready var timer = $RefreshTimer

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var Sword = $HitBoxPivot/Sword

func _ready():
	animationTree.active = true
	Sword.knockback_vector = roll_vector

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		
		ROLL:
			roll_state(delta)
			
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
			roll_vector = input_vector
			Sword.knockback_vector = input_vector
			animationTree.set("parameters/Idle/blend_position", input_vector)
			animationTree.set("parameters/Run/blend_position", input_vector)
			animationTree.set("parameters/Attack/blend_position", input_vector)
			animationTree.set("parameters/Roll/blend_position", input_vector)
			animationState.travel("Run")
			velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION)
	else:
			animationState.travel("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION)

	move()
	
	if Input.is_action_just_pressed("Roll"):
		state = ROLL
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		
func roll_state(delta):
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()
	
func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func move():
	velocity = move_and_slide(velocity)
	
func roll_animation():
	state = MOVE
	
func attack_animation_finished():
	state = MOVE
