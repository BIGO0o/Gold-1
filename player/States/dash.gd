extends State

## exported variabels that references to other states
@export
var fall_state: State
@export
var idle_state: State
@export
var move_state: State
##@export
##var dash_cooldown_timer: Timer 

@export
var cooldown_dash : int = 0
@export
var dash_max_distance = 300.0
@export 
var dash_speed: float = 20
@export
var dash_curve : Curve

var is_dashing = false
var dash_start_position = 0
var dash_timer = 0


## makes it possible to change jump force within inspector of godot


func enter() -> void:
	super()
	parent.dash_cooldown_timer.start(cooldown_dash)
	dash_start_position = parent.position.x
	is_dashing = true
	
	
	##if PlayerStats.face_direction():
		##parent.position.x += dash_force
	##else:
		##parent.position.x -= dash_force


## handles physics processing for the state
func process_physics(delta: float) -> State:
	
	##voor double jump reset on wall
	if parent.is_on_wall():
		PlayerStats.onWall = 1
		PlayerStats.doubleJump = 0
	else:
		PlayerStats.onWall = 0
	var current_distance = abs(parent.position.x - dash_start_position)
	if current_distance >= dash_max_distance or parent.is_on_wall():
		parent.velocity.y += gravity * delta
		if parent.velocity.y > 0: ## if veloctity y is negative
			print("fall state")
			return fall_state ## enter falling state
		
	else:
		parent.velocity.x = PlayerStats.face_direction() * dash_speed * dash_curve.sample(current_distance / dash_max_distance)
		parent.velocity.y = 0
	parent.move_and_slide()
	
	## transition to fall state
	
	
	## calculate horizontal x as movement
	var movement = Input.get_axis('move_left', 'move_right') * parent.move_force
	## -1 : move_left key is pressed
	## 1: move_right key is pressed
	## 0: neither keys are pressed
	
	
	
	## transition to movement state
	##if movement != 0: ## if the movement is 1 : move to right 
		##print("Run state")
		##parent.animations.flip_h = movement < 0 ## check need to flip animation: 1 < 0 == false but -1 < 0: true
	##parent.velocity.x = movement ## update the horizontal movement of the parent
	##parent.move_and_slide() ## moves the parent object based on its velocity and handles collision
	
	## transition to move or idle when on the floor
	##if parent.is_on_floor():
		##PlayerStats.doubleJump=0
		##if movement != 0:
			##return move_state ## transitio to move_state
		##return idle_state ## transition to idle state
	
	return null

func magDash():
	if parent.dash_cooldown_timer.time_left == 0:
		parent.dash_cooldown_timer.stop()
		return true
	else:
		print(parent.dash_cooldown_timer.time_left)
		return false
