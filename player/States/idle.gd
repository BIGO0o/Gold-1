extends State

## variabels that references other states (other subclasses) , export allows to change them in the inspector of godot
@export
var fall_state: State
@export
var jump_state: State
@export
var move_state: State
@export
var run_state: State
@export
var dash_state: State
@export
var pogo_state: State

## calls the parent class: enter() with super()
func enter() -> void:
	super()
	parent.velocity.x = 0 ## no movement -> so this idle.

## handles input events and determines if the state should transition to another state based on player input
func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("pogo_jump"):
		print("pogo")
		return pogo_state
	if Input.is_action_just_pressed("dash") and dash_state.magDash():
		print("dash")
		return dash_state
	if Input.is_action_just_pressed('jump') and parent.is_on_floor(): ## check if input is jump + not on the floor
		print("Jump state")
		PlayerStats.doubleJump+=1
		return jump_state ## transition to new state: Jump_state
	if (Input.is_action_just_pressed('move_left') or Input.is_action_just_pressed('move_right')) and not Input.is_action_pressed("run"): ## input is left or right?
		print("move state")
		return move_state ## transition to new state: move_state
	if (Input.is_action_just_pressed('move_left') or Input.is_action_just_pressed('move_right')) and Input.is_action_pressed("run"): ## input is left or right?
		print("run state")
		return run_state ## transition to new state: dash_state
	return null

## handles the physics processing for the state
func process_physics(delta: float) -> State:
	 
	parent.velocity.y += gravity * delta  ## applies gravity to the parent object's vertical velocity
	parent.move_and_slide() ## moves the parent object based on its velocity and handles collision (walls / floors)
	
	if !parent.is_on_floor(): ## if parent not on the floor 
		print("Fall state")
		return fall_state ## returns fall state
	return null
