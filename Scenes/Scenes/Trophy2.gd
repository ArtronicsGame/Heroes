extends Panel

var style = StyleBoxFlat.new()

func _ready():
	# The Panel doc tells you which style names there are
	add_stylebox_override("panel", style)
	style.set_bg_color(Color.red)
	update()
    
	#set_process(true)
"""
func _process(delta):
	var color = Color.white
	style.set_bg_color(color)
    # Don't forget to update so the control will redraw
	update()
    # Some basic code animation
    #var color = Color(0.5*sin(OS.get_ticks_msec()/100.0)+0.5, 0, 0)
	"""