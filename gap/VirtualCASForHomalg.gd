#############################################################################
##
##  VirtualCASForHomalg.gd                                VirtualCAS package
##                                                          Andreas Steenpaß
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##                 Andreas Steenpaß, University of Kaiserslautern
##
##  Declaration stuff for VirtualCAS.
##
#############################################################################


# our info class:
DeclareInfoClass( "InfoVirtualCASForHomalg" );
SetInfoLevel( InfoVirtualCASForHomalg, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_VIRTUAL_CAS" );

##
DeclareGlobalVariable( "CommonHomalgTableForVirtualRing" );
