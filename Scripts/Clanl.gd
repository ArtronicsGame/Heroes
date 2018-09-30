extends Panel
const _string_corrector = preload("res://Scripts/StringCorrector.gd")

func _ready():
	var string_corrector = _string_corrector.new();
	$ClanCreateBtn.text = string_corrector.correct("ساخت تیره")
	$SearchClanBtn.text = string_corrector.correct("جستوجوی تیره");
	