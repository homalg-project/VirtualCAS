#############################################################################
##
##  VirtualRings.gd                                       VirtualCAS package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##                 Andreas Steenpaß, University of Kaiserslautern
##
##  Declaration stuff for virtual rings.
##
#############################################################################

####################################
#
# categories:
#
####################################

DeclareCategory( "IsHomalgVirtualRing",
        IsHomalgRing );

DeclareCategory( "IsHomalgVirtualRingElement",
        IsHomalgRingElement );

####################################
#
# attributes:
#
####################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "UnderlyingNonVirtualRing",
        [ IsHomalgVirtualRing ] );
        
DeclareOperation( "UnderlyingNonVirtualRing",
        [ IsHomalgVirtualRingElement ] );

DeclareOperation( "UnderlyingNonVirtualRingElement",
        [ IsHomalgVirtualRingElement ] );

# constructor methods:

DeclareOperation ( "VirtualRing",
        [ IsHomalgRing ] );

DeclareGlobalFunction( "HomalgFieldOfRationalsInVirtualCAS" );

DeclareGlobalFunction( "HomalgRingOfIntegersInVirtualCAS" );

DeclareGlobalFunction( "VirtualRingElement" );

