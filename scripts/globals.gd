extends Node

enum Place { TABLE, DOOR, BED, COMPUTER }
enum Enemy { DAD, MOM, NOTHING }

var place: Place = Place.TABLE
var door_closed: bool = false
var dog_distressed: bool = false
var lost_to: Enemy = Enemy.NOTHING

var functions = {
	"getDogComfortCooldownTimer" = func() -> float:
		return 25 + randf() * 20,
	"getDogComfortDeadline" = func() -> float:
		return 10 + randf() * 7
}

func _ready() -> void:
	functions["getDogComfortCooldownTimer"].call()
	functions["getDogComfortDeadline"].call()
