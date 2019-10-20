all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		PackageInfo.g \
		doc/VirtualCAS.bib doc/*.xml \
		gap/*.gd gap/*.gi examples/*.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

test-with-coverage:	doc
	OUTPUT=$$(/usr/bin/time --quiet --format="%U %S" --output=performance.out gap --banner --quitonbreak --cover stats maketest.g 2>&1); \
	echo "$$OUTPUT"; \
	! echo "$$OUTPUT" | sed "s/\r//" | grep -v "Running list" | grep -v "^#I  " | grep "" > /dev/null
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

ci-test:	test-with-coverage

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/VirtualCAS.tar.gz --exclude ".DS_Store" --exclude "*~" VirtualCAS/doc/*.* VirtualCAS/doc/clean VirtualCAS/gap/*.{gi,gd} VirtualCAS/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g} VirtualCAS/examples/*.g)

WEBPOS=public_html
WEBPOS_FINAL=~/public_html/VirtualCAS

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.VirtualCAS
	cp doc/manual.pdf ${WEBPOS}/VirtualCAS.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/VirtualCAS.tar.gz ${WEBPOS}/VirtualCAS-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s VirtualCAS-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/VirtualCAS.tar.gz
