extends State

@export
var fall_state: State
@export
var idle_state: State
@export
var jump_state: State
@export
var run_state : State
@export
var dash_state : State


func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('jump') and parent.is_on_floor():
		PlayerStats.doubleJump+=1
		print("jump state")
		return jump_state
	if Input.is_action_pressed("run") and (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")): ## input is left or right?
		print("run state")
		return run_state ## transition to new state: dash
	if Input.is_action_pressed("dash") and dash_state.magDash(): ## input is left or right?
		print("dash state")
		return dash_state ##
		
	return null

func process_physics(delta: float) -> State:
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if movement == 0:
		print("IDLE state")
		return idle_state
	
	if movement < 0:
		PlayerStats.faceLeft()
	if movement > 0:
		PlayerStats.faceRight()
	
	parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
 	
		
	if !parent.is_on_floor():
		print("FALL state")
		return fall_state
	return null
