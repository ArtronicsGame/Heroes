extends Node2D

var words_dict = {0xD8A7 : [-1, -1, [0xEF, 0xBA, 0x8E]], #Alef
			0xD8A8 : [[0xEF, 0xBA, 0x91], [0xEF, 0xBA, 0x92], [0xEF, 0xBA, 0x90]], #Be
			0xD9BE : [[0xEF, 0xAD, 0x98], [0xEF, 0xAD, 0x99], [0xEF, 0xAD, 0x97]], #Pe
			0xD8AA : [[0xEF, 0xBA, 0x97], [0xEF, 0xBA, 0x98], [0xEF, 0xBA, 0x96]], #Te
			0xD8AB : [[0xEF, 0xBA, 0x9B], [0xEF, 0xBA, 0x9C], [0xEF, 0xBA, 0x9A]], #Se
			0xD8AC : [[0xEF, 0xBA, 0x9F], [0xEF, 0xBA, 0xA0], [0xEF, 0xBA, 0x9E]], #Jim
			0xDA86 : [[0xEF, 0xAD, 0xBC], [0xEF, 0xAD, 0xBD], [0xEF, 0xAD, 0xBB]], #Che
			0xD8AD : [[0xEF, 0xBA, 0xA3], [0xEF, 0xBA, 0xA4], [0xEF, 0xBA, 0xA2]], #He
			0xD8AE : [[0xEF, 0xBA, 0xA7], [0xEF, 0xBA, 0xA8], [0xEF, 0xBA, 0xA6]], #Khe
			0xD8AF : [-1, -1, [0xEF, 0xBA, 0xAA]], #Dal
			0xD8B0 : [-1, -1, [0xEF, 0xBA, 0xAC]], #Zal
			0xD8B1 : [-1, -1, [0xEF, 0xBA, 0xAE]], #Re
			0xD8B2 : [-1, -1, [0xEF, 0xBA, 0xB0]], #Ze
			0xDA98 : [-1, -1, [0xEF, 0xAE, 0x8B]], #Zhe
			0xD8B3 : [[0xEF, 0xBA, 0xB3], [0xEF, 0xBA, 0xB4], [0xEF, 0xBA, 0xB2]], #Sin
			0xD8B4 : [[0xEF, 0xBA, 0xB7], [0xEF, 0xBA, 0xB8], [0xEF, 0xBA, 0xB6]], #Shin
			0xD8B5 : [[0xEF, 0xBA, 0xBB], [0xEF, 0xBA, 0xBC], [0xEF, 0xBA, 0xBA]], #Sad
			0xD8B6 : [[0xEF, 0xBA, 0xBF], [0xEF, 0xBB, 0x80], [0xEF, 0xBA, 0xBE]], #Zad
			0xD8B7 : [[0xEF, 0xBB, 0x83], [0xEF, 0xBB, 0x84], [0xEF, 0xBB, 0x82]], #Ta
			0xD8B8 : [[0xEF, 0xBB, 0x87], [0xEF, 0xBB, 0x88], [0xEF, 0xBB, 0x86]], #Za
			0xD8B9 : [[0xEF, 0xBB, 0x8B], [0xEF, 0xBB, 0x8C], [0xEF, 0xBB, 0x8A]], #Eyn
			0xD8BA : [[0xEF, 0xBB, 0x8F], [0xEF, 0xBB, 0x90], [0xEF, 0xBB, 0x8E]], #Qeyn
			0xD981 : [[0xEF, 0xBB, 0x93], [0xEF, 0xBB, 0x94], [0xEF, 0xBB, 0x92]], #Fe
			0xD982 : [[0xEF, 0xBB, 0x97], [0xEF, 0xBB, 0x98], [0xEF, 0xBB, 0x96]], #Qaf
			0xDAA9 : [[0xEF, 0xAE, 0x90], [0xEF, 0xAE, 0x91], [0xEF, 0xAE, 0x8F]], #Kaf
			0xDAAF : [[0xEF, 0xAE, 0x94], [0xEF, 0xAE, 0x95], [0xEF, 0xAE, 0x93]], #Gaf
			0xD984 : [[0xEF, 0xBB, 0x9F], [0xEF, 0xBB, 0xA0], [0xEF, 0xBB, 0x9E]], #Lam
			0xD985 : [[0xEF, 0xBB, 0xA3], [0xEF, 0xBB, 0xA4], [0xEF, 0xBB, 0xA2]], #Min
			0xD986 : [[0xEF, 0xBB, 0xA7], [0xEF, 0xBB, 0xA8], [0xEF, 0xBB, 0xA6]], #Non
			0xD988 : [-1, -1, [0xEF, 0xBB, 0xAE]], #Vav
			0xD987 : [[0xEF, 0xBB, 0xAB], [0xEF, 0xBB, 0xAC], [0xEF, 0xBB, 0xAA]], #Heh
			0xDB8C : [[0xEF, 0xAF, 0xBE], [0xEF, 0xAF, 0xBF], [0xEF, 0xAF, 0xBD]]} #Ye
var state_dict = {0xD8A7 : 1, #Alef
			0xD8A8 : 2, #Be
			0xD9BE : 2, #Pe
			0xD8AA : 2, #Te
			0xD8AB : 2, #Se
			0xD8AC : 2, #Jim
			0xDA86 : 2, #Che
			0xD8AD : 2, #He
			0xD8AE : 2, #Khe
			0xD8AF : 1, #Dal
			0xD8B0 : 1, #Zal
			0xD8B1 : 1, #Re
			0xD8B2 : 1, #Ze
			0xDA98 : 1, #Zhe
			0xD8B3 : 2, #Sin
			0xD8B4 : 2, #Shin
			0xD8B5 : 2, #Sad
			0xD8B6 : 2, #Zad
			0xD8B7 : 2, #Ta
			0xD8B8 : 2, #Za
			0xD8B9 : 2, #Eyn
			0xD8BA : 2, #Qeyn
			0xD981 : 2, #Fe
			0xD982 : 2, #Qaf
			0xDAA9 : 2, #Kaf
			0xDAAF : 2, #Gaf
			0xD984 : 2, #Lam
			0xD985 : 2, #Min
			0xD986 : 2, #Non
			0xD988 : 1, #Vav
			0xD987 : 2, #Heh
			0xDB8C : 2} #Ye
var conv_dict = { 1 : 0, 2 : 2, 3 : 1 }

var pool

func correct(st):
	var npool = PoolByteArray()
	var nstr = invert_str(st)
	pool = nstr.to_utf8()
	var i = 0
	var past_state = 0
	while i < pool.size():
		if pool[i] < 128: # 1 Byte Character
			npool.append(pool[i])
			past_state = 0
			i = i + 1
		elif pool[i] < 224: # 2 Bytes Character
			var id = (pool[i] * 256) + pool[i + 1]
			if id in words_dict.keys():
				var index = 0
				if getState(i + 2) == 2:
					index = index + 2
				if (past_state > 0) and (state_dict[id] == 2):
					index = index + 1
				if index == 0:
					npool.append(pool[i])
					npool.append(pool[i + 1])
				else:
					npool.append(words_dict[id][conv_dict[index]][0])
					npool.append(words_dict[id][conv_dict[index]][1])
					npool.append(words_dict[id][conv_dict[index]][2])
				past_state = state_dict[id]
			else:
				npool.append(pool[i])
				npool.append(pool[i + 1])
				past_state = 0
			i = i + 2
		elif pool[i] < 240: # 3 Bytes Character
			npool.append(pool[i])
			npool.append(pool[i + 1])
			npool.append(pool[i + 2])
			past_state = 0
			i = i + 3
		else: # 4 Bytes Character
			npool.append(pool[i])
			npool.append(pool[i + 1])
			npool.append(pool[i + 2])
			npool.append(pool[i + 3])
			past_state = 0
			i = i + 4
	var stri = npool.get_string_from_utf8()
	return stri


func getState(index):
	if index >= pool.size():
		return 0
	var byte = pool[index]
	if byte < 128: # 1 Byte Character
		return 0
	elif byte < 224: # 2 Bytes Character
		var id = (pool[index] * 256) + pool[index + 1]
		if id in words_dict.keys():
			return state_dict[id]
		else:
			return 0
	else: # 4 Bytes Character
		return 0
		
func getID(word):
	if word.size() == 2 :
		var id = (word[0] * 256) + word[1]
		return id
	else:
		return -1

func invert_str(st):
	var temp
	var st_list = []
	var str_list = []
	var english = []
	var flag = false
	var last_char = 0
	for temp in st:
		st_list.append(temp)
	while st_list.size() > 0:
		if (getID(st_list.front().to_utf8()) in words_dict.keys()):
			if flag:
				if last_char == 0x20:
					english.pop_front()
				while english.size() > 0:
					str_list.push_front(english.front())
					english.pop_front()
				if last_char == 0x20:
					str_list.push_front(" ")
				flag = false
			str_list.push_front(st_list.front())
			last_char = st_list.front().to_utf8()[0]
			st_list.pop_front()
		else:
			if !flag and st_list.front().to_utf8()[0] == 0x20:
				str_list.push_front(st_list.front())
				st_list.pop_front()
			else:
				english.push_front(st_list.front())
				last_char = st_list.front().to_utf8()[0]
				st_list.pop_front()
			flag = true
	if flag:
		if last_char == 0x20:
			english.pop_front()
		while english.size() > 0:
			str_list.push_front(english.front())
			english.pop_front()
		if last_char == 0x20:
			str_list.push_front(" ")
	st = ""
	for temp in str_list:
		st = st + str(temp)
	return st