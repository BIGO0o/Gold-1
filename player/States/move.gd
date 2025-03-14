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
	if Input.is_action_just_pressed('jump') and (parent.is_on_floor() or parent.coyoteTimer.time_left >0):
		PlayerStats.doubleJump+=1
		return jump_state
	if Input.is_action_pressed("run") and (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")): ## input is left or right?
		return run_state ## transition to new state: dash
	if Input.is_action_pressed("dash") and dash_state.magDash(): ## input is left or right?
		return dash_state ##
		
	return null

func process_physics(delta: float) -> State:
	
	var movement = Input.get_axis('move_left', 'move_right') * parent.move_force
	
	if movement == 0:
		return idle_state
	
	if movement < 0:
		PlayerStats.faceLeft()
	if movement > 0:
		PlayerStats.faceRight()
	
	parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
 	##update coyote timer
	
	
	if !parent.is_on_floor():
		parent.coyoteTimer.start(parent.coyoteTimerLenght)
		return fall_state
	return null
