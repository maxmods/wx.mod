for i in `find . -type f -name "*.bmx"`
do
	wc -l $i
done | awk '{ count+=$1} END { print "bmx = " count}'

for i in `find . -type f -name "*.cpp"`
do
	wc -l $i
done | awk '{ count+=$1} END { print "cpp = " count}'
