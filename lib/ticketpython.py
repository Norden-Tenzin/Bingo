SPACER = "__"


def numlistmkr():
    listmkr = []
    for x in range(1, 101):
        listmkr.append(x)
    return listmkr


def noisemkr():
    noiselist = []
    listready = True
    while listready:
        for x in range(0, 9):
            chance = random.randint(0, 9)
            if chance > 4:
                noiselist.append(str(1))
            else:
                noiselist.append(str(0))
        if (countnoise(noiselist) == 5) & (countspace(noiselist) < 2):
            return noiselist
        noiselist = []


def countnoise(noiselist):
    count = 0
    for x in noiselist:
        if x == "1":
            count += 1
    return count


def countspace(noiselist):
    count = 0
    for x in noiselist:
        if count > 2:
            break
        else:
            if x == "0":
                count += 1
            elif x == "1":
                count = 0
    return count


def linemkr(numlist, noise):
    line = []
    check = True
    for x in noise:
        if x == "0":
            line.append(SPACER)
            line.append(",")
        elif x == "1":
            while check:
                rannum = random.randint(1, 101)
                if rannum in numlist:
                    line.append(str(rannum))
                    line.append(",")
                    numlist.remove(rannum)
                    check = False
            check = True
    return [line, numlist]


def main():
    numlist = numlistmkr()
    noise = noisemkr()
    line1 = linemkr(numlist, noise)
    print(line1[0])
    noise = noisemkr()
    line2 = linemkr(line1[1], noise)
    print(line2[0])
    noise = noisemkr()
    line3 = linemkr(line2[1], noise)
    print(line3[0])

    file = open("player.txt", "w+")
    file.writelines(line1[0])
    file.writelines("\n")
    file.writelines(line2[0])
    file.writelines("\n")
    file.writelines(line3[0])