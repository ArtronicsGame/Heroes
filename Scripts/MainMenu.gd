extends Panel
const STRING_CORRECTOR = preload("res://Scripts/StringCorrector.gd")

func _ready():
	var stringCorrectorIns = STRING_CORRECTOR.new()
	var playBtnTxt = stringCorrectorIns.correct("شروع")
	$PlayBtn.text = playBtnTxt


