extends State

@export
var fall_state: State
@export
var idle_state: State
@export
var jump_state: State
@export
var move_state: State



func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('jump') and parent.is_on_floor():
		return jump_state
	return null

func process_physics(delta: float) -> State:
	
	
	parent.velocity.y += gravity * delta
	
	var movement = Input.get_axis('move_left', 'move_right') * parent.move_force *1.25
	
	if movement == 0:
		return idle_state
		
	if movement < 0:
		PlayerStats.faceLeft()
	if movement > 0:
		PlayerStats.faceRight()
	
	parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if !Input.is_action_pressed('run'):
		return move_state
	
	if !parent.is_on_floor():
		return fall_state
	return null
