#############################################################################
##
##  VirtualCASTable.gi                                    VirtualCAS package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##                 Andreas Steenpaß, University of Kaiserslautern
##
##  Implementations for virtual rings.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( CreateHomalgTableForVirtualCAS,
  function( R )
    local RP;
    
    RP := rec(
              Zero := Zero( R ),
              
              One := One( R ),
              
              MinusOne := MinusOne( R ),
              );
    
    ## RP_General
    AppendToAhomalgTable( RP, CommonHomalgTableForVirtualRing );
    
    ## RP_Basic
    AppendToAhomalgTable( RP, CommonHomalgTableForVirtualRingBasic );
    
    ## RP_Tools
    AppendToAhomalgTable( RP, CommonHomalgTableForVirtualRingTools );
    
    ## Objectify
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );

