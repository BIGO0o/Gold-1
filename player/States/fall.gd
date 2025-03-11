extends State

@export
var idle_state: State
@export
var move_state: State
@export
var doublejump_state : State
@export
var jump_state : State
@export
var dash_state : State


func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and parent.coyoteTimer.time_left >0 and PlayerStats.doubleJump<1:
		PlayerStats.doubleJump+=1
		print("jump")
		return jump_state
	if Input.is_action_just_pressed('jump') and not parent.is_on_floor() and PlayerStats.doubleJump<2 and parent.doubleJump:
		PlayerStats.doubleJump+=1
		print("double jump state")
		return doublejump_state
	if Input.is_action_pressed("dash") and dash_state.magDash(): ## input is left or right?
		print("dash state")
		return dash_state
	return null

func process_physics(delta: float) -> State:
	
	##voor double jump reset on wall
	if parent.is_on_wall():
		PlayerStats.onWall = 1
		PlayerStats.doubleJump = 0
	else:
		PlayerStats.onWall = 0
	
	parent.velocity.y += gravity * delta

	var movement = Input.get_axis('move_left', 'move_right') * parent.move_force
	
	if movement != 0:
		parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		PlayerStats.doubleJump=0
		if movement != 0:
			print("move state")
			return move_state
		return idle_state
	return null
