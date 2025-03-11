class_name Player
extends CharacterBody2D

@onready
var animations = $animations
@onready
var state_machine = $state_machine

##IDLE SETTINGS

##MOVE SETTINGS
@export var move_force: float = 120
##JUMP SETTINGS
@export 
var jump_force: float = 300 
##FALL SETTINGS

##RUN SETTINGS

##DOUBLEJUMP SETTINGS
@export
var doubleJump: bool
##DASH SETTINGS
@export
var dash_speed: float = 250
@export
var dash_max_distance: float = 90
@export 
var dash_curve: Curve
@export
var cooldown_dash : int = 2
##POGO SETTINGS
@export 
var  pogo_jump_force: float = 500
##TIMERS
@export var dash_cooldown_timer: Timer
@export var coyoteTimer: Timer
@export var coyoteTimerLenght: float




func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	print(coyoteTimer.time_left)
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
