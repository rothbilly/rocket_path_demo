extends Resource
class_name GameData

@export var player_nick_name: String

@export var game_coins: int
var run_playeds: int


func player_name_setup(new_name):
	self.player_nick_name = new_name
	ResourceSaver.save("res://Data/testData.tres",self)
	#GameDataUpdater.nickname = new_name
	pass
