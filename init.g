#############################################################################
##
##  init.g                                                VirtualCAS package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##                 Andreas Steenpaß, University of Kaiserslautern
##
##  Reading the declaration part of the VirtualCAS package.
##
#############################################################################

## init
ReadPackage( "VirtualCAS", "gap/VirtualCASForHomalg.gd" );

## virtual rings
ReadPackage( "VirtualCAS", "gap/VirtualRings.gd" );

## virtual matrices
ReadPackage( "VirtualCAS", "gap/VirtualMatrices.gd" );

## the basic matrix operations
ReadPackage( "VirtualCAS", "gap/VirtualCASBasic.gd" );

## the matrix tool operations
ReadPackage( "VirtualCAS", "gap/VirtualCASTools.gd" );

## build the homalgTable
ReadPackage( "VirtualCAS", "gap/VirtualCASTable.gd" );

