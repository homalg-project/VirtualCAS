#############################################################################
##
##  VirtualCAS.gd                     VirtualCAS package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##
##  Implementation stuff for VirtualCAS.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( VirtualCAS,
        rec(
            
            )
);

####################################
#
# initialization
#
####################################

HOMALG_IO_Singular.LaunchCAS := LaunchVirtualCAS;

####################################
#
# methods for operations:
#
####################################

##
InstallGlobalFunction( LaunchVirtualCAS,
  function( arg )
    local s;
    
    if LoadPackage( "IO_ForHomalg" ) <> true then
        Error( "the package IO_ForHomalg failed to load\n" );
    fi;
    
    s := LaunchCAS_IO_ForHomalg( HOMALG_IO_Singular );
    
    if s = fail then
        return fail;
    fi;
    
    s.lines := "";
    s.errors := "";
    s.name := "virtual CAS running Singular";
    s.SendBlockingToCAS := SendBlockingToVirtualCAS;
    s.SendBlockingToCAS_original := SendBlockingToVirtualCAS;
    
    return s;
    
end );

##
InstallGlobalFunction( SendBlockingToVirtualCAS,
  function( arg )
    local stream, container;
    
    if ( Length( arg ) = 2 and IsRecord( arg[1] ) and IsString( arg[2] ) ) then
        
        stream := arg[1];
        container := stream.homalgExternalObjectsPointingToVariables;
        
        Print( arg{[ 2 .. Length( arg ) ]}, "\n" );
        Print( container!.assignments_pending, "\n" );
        
        #r := CallFuncList( SendBlockingToCAS, arg );
        
    else
        Error("Wrong number or type of arguments.");
    fi;
    
end );

InstallGlobalFunction( TerminateVirtualCAS,
  function( arg )
    # Make this a no-op, as we can never re-start LibSingular
    # LibSingular will exit when gap exits
end );
