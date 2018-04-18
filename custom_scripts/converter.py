map1 = "Pelican Town   "
map2 = "Aquatic Lake   "
map3 = "Route 1        "
map4 = "Illuminati Cave"
map5 = "Flora Town     "
a = map1+map2+map3+map4+map5
f = open('somedata.txt', 'w')
for c in a:
	f.write(str(ord(c) - 32))
	f.write('\n')
