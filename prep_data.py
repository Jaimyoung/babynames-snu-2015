outfile = open("onefile.txt", "w")
for year in range(1880, 2015):
    fname = "data/yob%s.txt" % year
    f = open(fname)
    for line in f:
        outfile.write("%s,%s" % (year, line))
    f.close()
outfile.close()