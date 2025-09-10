extends Node

enum Place { TABLE, DOOR, BED, COMPUTER }
enum Enemy { DAD, MOM, TIME, NOTHING }

var clock_speed: int = 45
var time: int = 0
var place: Place = Place.TABLE
var door_closed: bool = false
var dog_distressed: bool = false
var lost_to: Enemy = Enemy.NOTHING

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
