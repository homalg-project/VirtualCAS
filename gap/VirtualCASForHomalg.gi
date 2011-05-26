#############################################################################
##
##  VirtualCASForHomalg.gi                                VirtualCAS package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##                 Andreas Steenpaß, University of Kaiserslautern
##
##  Implementation stuff for VirtualCAS.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

##
InstallValue( HOMALG_VIRTUAL_CAS,
        rec(
            )
);

##
InstallValue( CommonHomalgTableForVirtualRing,
        rec(
            RingName :=
              function( S )
                
                if HasName( S ) then
                    return Name( S );
                fi;
                
                return RingName( UnderlyingNonVirtualRing( S ) );
                
              end,
              
         )
);

