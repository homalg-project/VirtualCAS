#############################################################################
##
##  VirtualMatrices.gd                                    VirtualCAS package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##                 Andreas Steenpaß, University of Kaiserslautern
##
##  Declaration stuff for virtual matrices.
##
#############################################################################

####################################
#
# categories:
#
####################################

DeclareCategory( "IsHomalgVirtualMatrix",
        IsHomalgMatrix );


####################################
#
# attributes:
#
####################################

##
DeclareProperty( "Twitter",
        IsHomalgMatrix );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "UnderlyingNonVirtualRing",
        [ IsHomalgVirtualMatrix ] );

DeclareOperation( "UnderlyingMatrix",
        [ IsHomalgVirtualMatrix ] );

# constructor methods:

DeclareOperation( "BlindlyCopyMatrixPropertiesToHomalgVirtualMatrix",
        [ IsHomalgMatrix, IsHomalgVirtualMatrix ] );

DeclareOperation( "HomalgVirtualMatrix",
        [ IsHomalgMatrix, IsHomalgVirtualRing ] );

DeclareOperation( "HomalgVirtualMatrix",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgVirtualRing ] );

DeclareOperation( "HomalgVirtualMatrix",
        [ IsList, IsInt, IsInt, IsHomalgVirtualRing ] );


