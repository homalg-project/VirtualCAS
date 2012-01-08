#############################################################################
##
##  ProcessGraph.gd                                       VirtualCAS package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##                 Andreas Steenpaß, University of Kaiserslautern
##
##  Declaration stuff for process graphs.
##
#############################################################################

####################################
#
# categories:
#
####################################

DeclareCategory( "IsProcessForHomalg",
        IsComponentObjectRep );

DeclareCategory( "IsProcessGraph",
        IsComponentObjectRep );

####################################
#
# filters:
#
####################################

DeclareFilter( "IsBlockingProcess", 0 );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "NrVertices",
        [ IsProcessGraph ] );

DeclareOperation( "Add",
        [ IsProcessGraph, IsProcessForHomalg ] );

# constructor methods:

DeclareGlobalFunction( "ProcessForHomalg" );

DeclareGlobalFunction( "ProcessGraph" );
