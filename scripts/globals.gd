extends Node

enum Place { TABLE, DOOR, BED, COMPUTER }
enum Enemy { DAD, MOM, NOTHING }

var place: Place = Place.TABLE
var door_closed: bool = false
var dog_distressed: bool = false
var lost_to: Enemy = Enemy.NOTHING
