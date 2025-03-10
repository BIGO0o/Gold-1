extends State

## exported variabels that references to other states
@export
var fall_state: State
@export
var idle_state: State
@export
var move_state: State
@export
var doublejump_state: State
@export
var dash_state: State

## makes it possible to change jump force within inspector of godot
@export 
var jump_force: float = 300 

## calls the parent class: Enter() with super
func enter() -> void:
	super()
	parent.velocity.y = -jump_force ## sets the velocity to a negative which makes the postion fall

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('jump') and not parent.is_on_floor() and PlayerStats.doubleJump < 2 :
		PlayerStats.doubleJump+=1
		print(PlayerStats.doubleJump)
		print("double jump state")
		return doublejump_state
	if Input.is_action_pressed("dash") and dash_state.magDash(): ## input is left or right?
		print("dash state")
		return dash_state
		
	return null

## handles physics processing for the state
func process_physics(delta: float) -> State:
	##voor double jump reset on wall
	if parent.is_on_wall():
		PlayerStats.onWall = 1
		PlayerStats.doubleJump = 0
	else:
		PlayerStats.onWall = 0
	
	parent.velocity.y += gravity * delta ## apply gravity
	
	
	
	## transition to fall state
	if parent.velocity.y > 0: ## if veloctity y is negative
		print("fall state")
		return fall_state ## enter falling state
	
	## calculate horizontal x as movement
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	## -1 : move_left key is pressed
	## 1: move_right key is pressed
	## 0: neither keys are pressed
	
	if movement < 0:
		PlayerStats.faceLeft()
	if movement > 0:
		PlayerStats.faceRight()
	
	## transition to movement state
	if movement != 0: ## if the movement is 1 : move to right 
		parent.animations.flip_h = movement < 0 ## check need to flip animation: 1 < 0 == false but -1 < 0: true
	parent.velocity.x = movement ## update the horizontal movement of the parent
	parent.move_and_slide() ## moves the parent object based on its velocity and handles collision
	
	## transition to move or idle when on the floor
	if parent.is_on_floor():
		PlayerStats.doubleJump=0
		if movement != 0:
			print("run")
			return move_state ## transitio to move_state
		return idle_state ## transition to idle state
	
	return null
