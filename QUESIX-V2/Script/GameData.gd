extends Resource
class_name GameData

export(String) var player_nick_name

export(int) var game_coins
var run_playeds: int


func player_name_setup(new_name):
	self.player_nick_name = new_name
	ResourceSaver.save("res://Data/testData.tres",self)
	#GameDataUpdater.nickname = new_name
	pass
