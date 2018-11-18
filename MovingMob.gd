extends PathFollow2D

export var mobName = 'libeluliste'
var health = 2
var reward = 15
var mobSpeed = 100
var vanishing = false
var teleporting = false

var i = 0

func _ready():
	randomize()

func _enter_tree():
	$Mob.mobName = mobName
	
	$MobArea.connect("area_entered", self, "hit")
	
	if mobName == 'cyclo fumeur':
		health = 1
	elif mobName == 'poulpi':
		health = 2
		reward = 20
	elif mobName == 'medusar':
		health = 2
		reward = 25
		mobSpeed = 150
	elif mobName == 'lunique':
		health = 2
		reward = 30
		mobSpeed = 130
		vanishing = true
	elif mobName == 'Mr. citrus':
		health = 3
		reward = 35
		mobSpeed = 170
	elif mobName == 'libeluliste':
		health = 3
		reward = 40
		mobSpeed = 170
		vanishing = true
	elif mobName == 'Mr. citrus':
		health = 3
		reward = 45
		mobSpeed = 200
	elif mobName == 'menthe religieuse':
		health = 3
		reward = 50
		mobSpeed = 180
		teleporting = true
	elif mobName == 'roubi on kenoby':
		health = 4
		reward = 55
		mobSpeed = 220
	elif mobName == 'grenoux':
		health = 4
		reward = 60
		mobSpeed = 220
		vanishing = true
	elif mobName == 'florax':
		health = 5
		reward = 65
		mobSpeed = 220
		vanishing = true
		teleporting = true
	
	$ProgressBar.set_max(health)
	$ProgressBar.set_value(health)

func _process(delta):
	i += 1
	
	if i % 100 == 0 and teleporting:
		set_offset(get_offset() + randf(-1, 1) * 90.0)
	
	set_offset(get_offset() + mobSpeed * delta)
	if vanishing:
		set_visible(int(floor(get_unit_offset() / 0.05)) % 2 == 0)
	
	if get_unit_offset() >= 1.0:
		get_game_manager().on_monster_missed()
		queue_free()

func hit(object):
	if object.name == 'BulletArea':
		lose_health()

func lose_health():
	var origin = get_global_transform_with_canvas().get_origin()
	if origin.x <= 0 or origin.y <= 0:
		return
	
	$ProgressBar.set_value($ProgressBar.get_value() - 1)
	
	if $ProgressBar.get_value() == 0:
		get_game_manager().on_monster_killed(reward)
		queue_free()

func get_game_manager():
	return get_tree().get_nodes_in_group("game_manager")[0]
