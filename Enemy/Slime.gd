extends Enemy

func _ready():
	dvig()

func _physics_process(delta):
	get_inputs()
	apply_gravity()
