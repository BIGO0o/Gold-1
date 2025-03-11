class_name Player
extends CharacterBody2D

@onready
var animations = $animations
@onready
var state_machine = $state_machine

##IDLE SETTINGS

##MOVE SETTINGS

##JUMP SETTINGS

##FALL SETTINGS

##RUN SETTINGS

##DOUBLEJUMP SETTINGS

##DASH SETTINGS

##POGO SETTINGS

##TIMERS
@export var dash_cooldown_timer: Timer
@export var coyoteTimer: Timer




func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
