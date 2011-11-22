#############################################################################
##
##  VirtualCAS.gd                                         VirtualCAS package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##
##  Declaration stuff for VirtualCAS.
##
#############################################################################

# our info class:
DeclareInfoClass( "InfoVirtualCAS" );
SetInfoLevel( InfoVirtualCAS, 1 );

# a central place for configurations:
DeclareGlobalVariable( "VirtualCAS" );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "LaunchVirtualCAS" );

DeclareGlobalFunction( "SendBlockingToVirtualCAS" );

DeclareGlobalFunction( "TerminateVirtualCAS" );

# basic operations:

