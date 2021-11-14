extends Node2D

export(PackedScene) var Coin
export(PackedScene) var Hurt
export(PackedScene) var Pow
export(int) var playtime

var level
var scroce = 0
var time_left = 0
var screen_size
var palying = false

func _ready():
	randomize()
	screen_size = get_viewport().get_visible_rect().size
	$Player.scress_size = screen_size
	
# warning-ignore:unused_argument
func _process(delta):
	$HUD.update_scroce(scroce)
	$HUD.scroce_text = scroce
	$HUD.time_text = time_left
	if palying and $CoinsContainer.get_child_count() == 0:
		$Level_up.play()
		level += 1
		scroce += 5
		time_left += 5
		spawn_coins()
		random_hurt()
		random_pow()

func random_hurt():
	for i in range(level):
		var h = Hurt.instance()
		$HurtContainer.add_child(h)
		h.screen_size = screen_size
		h.position = Vector2(rand_range(0, screen_size.x), rand_range(0, screen_size.y))

func random_pow():
	if level > 1:
		var p = Pow.instance()
		$PowContainer.add_child(p)
		p.screen_size = screen_size
		p.position = Vector2(rand_range(0, screen_size.x), rand_range(0, screen_size.y))

func spawn_coins():
# warning-ignore:unused_variable
	for i in range(4 + level):
		var c = Coin.instance()
		$CoinsContainer.add_child(c)
		c.screen_size = screen_size
		c.position = Vector2(rand_range(0, screen_size.x), rand_range(0, screen_size.y))

func new_game():
	palying = true
	level = 1
	scroce = 0
	time_left = 30
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTime.start()
	spawn_coins()
	random_hurt()

func _on_HUD_start_game():
	$HUD/GameStart.hide()
	new_game()

func _on_Player_pick_up():
	scroce += 1
