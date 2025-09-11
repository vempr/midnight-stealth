extends Node

enum Place { TABLE, DOOR, BED, COMPUTER }
enum Enemy { DAD, MOM, TIME, NOTHING, OXYGEN }

const STARTING_GAME_WON: bool = false
const CLOCK_SPEED: int = 60
const STARTING_TIME: int = 0
const STARTING_PLACE: Place = Place.TABLE
const STARTING_DOOR_CLOSED: bool = false
const STARTING_LAPTOP_CLOSED: bool = false
const STARTING_DOG_DISTRESSED: bool = false
const STARTING_LOST_TO: Enemy = Enemy.NOTHING
const STARTING_ASSIGNMENTS_TO_SUBMIT: int = 2
const STARTING_SUBMITTED_ASSIGNMENTS: int = 0

var game_won: bool = STARTING_GAME_WON
var time: int = STARTING_TIME
var place: Place = STARTING_PLACE
var door_closed: bool = STARTING_DOOR_CLOSED
var laptop_closed: bool = STARTING_LAPTOP_CLOSED
var dog_distressed: bool = STARTING_DOG_DISTRESSED
var lost_to: Enemy = STARTING_LOST_TO

var assignments_to_submit: int = STARTING_ASSIGNMENTS_TO_SUBMIT
var submitted_assignments: int = STARTING_SUBMITTED_ASSIGNMENTS

var functions = {
	"reset_game_state" = func() -> void:
		game_won = STARTING_GAME_WON
		time = STARTING_TIME
		place = STARTING_PLACE
		door_closed = STARTING_DOOR_CLOSED
		laptop_closed = STARTING_LAPTOP_CLOSED
		dog_distressed = STARTING_DOG_DISTRESSED
		lost_to = STARTING_LOST_TO
		assignments_to_submit = STARTING_ASSIGNMENTS_TO_SUBMIT
		submitted_assignments = STARTING_SUBMITTED_ASSIGNMENTS,
	"getDogComfortCooldownTimer" = func() -> float:
		return 25 + randf() * 20,
	"getDogComfortDeadline" = func() -> float:
		return 10 + randf() * 7,
	"getDadCooldown" = func() -> float:
		return 30 + randf() * 5,
	"getMomCooldown" = func() -> float:
		return 50 + randf() * 5,
}

func _ready() -> void:
	functions["getDogComfortCooldownTimer"].call()
	functions["getDogComfortDeadline"].call()
