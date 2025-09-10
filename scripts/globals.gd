extends Node

enum Place { TABLE, DOOR, BED, COMPUTER }
enum Enemy { DAD, MOM, TIME, NOTHING }

const CLOCK_SPEED: int = 45
const STARTING_TIME: int = 0
const STARTING_PLACE: Place = Place.TABLE
const STARTING_DOOR_CLOSED: bool = false
const STARTING_DOG_DISTRESSED: bool = false
const STARTING_LOST_TO: Enemy = Enemy.NOTHING

var time: int = STARTING_TIME
var place: Place = STARTING_PLACE
var door_closed: bool = STARTING_DOOR_CLOSED
var dog_distressed: bool = STARTING_DOG_DISTRESSED
var lost_to: Enemy = STARTING_LOST_TO

var assignments_to_submit: int = 2
var submitted_assignments: int = 0

var functions = {
	"getDogComfortCooldownTimer" = func() -> float:
		return 25 + randf() * 20,
	"getDogComfortDeadline" = func() -> float:
		return 10 + randf() * 7
}

func _ready() -> void:
	functions["getDogComfortCooldownTimer"].call()
	functions["getDogComfortDeadline"].call()
