extends Node

@export
var double_jump = false

##coins
var coins = 0
##movement settings
var maxJumps = 0
##
var doubleJump = 0
var moveSpeed : float = 1
var jumpForce : float = 1

var onWall : float = 0

var is_dashing= false
var starting_position
var facing_right = true

var timerDash = true

##function to set facing direction
func faceLeft():
	facing_right = false
func faceRight():
	facing_right = true
func face_direction():
	if facing_right == true:
		return 1
	else:
		return -1
