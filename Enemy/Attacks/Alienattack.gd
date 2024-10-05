extends Orange_alien



func alien_attack():
	print(1)


func attack ():
	var atk_chance = randi()%30
	if is_in_table(atk_chance):
		alien_attack
	else: pass
	







func is_in_table(x):
	if x in [2,3,5,7,11,13,17,19,23,29]:
		return true
	else: return false
	
