## declare a base class named State in the global namespace
class_name State
extends Node

## export allows these variabels to be set in  de editor
@export
var animation_name: String	## stores the name of the animation that should play when the state is active
@export
var move_speed: float = 120 ## Define the movement speed, with a default of 120

## load gravity from the project, so all states use the same
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

## Hold a reference to the parent so that it can be controlled by the state
var parent: Player

## is called when the state becomes active
func enter() -> void:
	## plays the animation assigned to this state using parent.animations
	parent.animations.play(animation_name)

## called before switching to a different state
func exit() -> void:
	pass	## does nothing can be overidden bay the subclasses

## handeler user input (keyboard/ gamepad events)
func process_input(event: InputEvent) -> State:
	return null ## retuns NULL by default can be overriden by subclass

## runs every frame (like _process(delta) in a regular script)
func process_frame(delta: float) -> State:
	return null ## returns NULL by default can be overridden by subclasses

## runs during the physics (like _physics_process(delta))
## usefull for handeling movement, gravity or collsions
func process_physics(delta: float) -> State:
	return null ## returns NULL by default can be overriden by subclasses
