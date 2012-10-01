##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/VirtualCAS.bib" );
WriteBibXMLextFile( "doc/VirtualCASForHomalgBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "VirtualCAS" )[1].Version );

MakeGAPDocDoc( "doc", "VirtualCASForHomalg", list, "VirtualCASForHomalg" );

GAPDocManualLab("VirtualCAS");

QUIT;
