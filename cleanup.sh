for i in `find . -name ".bmx"`
do
	rm -rf $i
done
for i in `find . -name "*.i"`
do
	rm -rf $i
done
for i in `find . -name "*.debug.*.a"`
do
	rm -rf $i
done
for i in `find . -name "*.release.*.a"`
do
	rm -rf $i
done
for i in `find . -name "*~"`
do
	rm -rf $i
done
for i in `find . -name "*.bak"`
do
	rm -rf $i
done
for i in `find . -name "commands.html"`
do
	rm -rf $i
done
