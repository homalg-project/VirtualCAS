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
    s.InitialSendBlockingToCAS := s.SendBlockingToCAS;
    s.SendBlockingToCAS := SendBlockingToVirtualCAS;
    s.SendBlockingToCAS_original := SendBlockingToVirtualCAS;
    s.log_processes := true;
    
    s.ProcessGraph := ProcessGraph( );
    
    return s;
    
end );

##
InstallGlobalFunction( SendBlockingToVirtualCAS,
  function( arg )
    local stream, graph, process, processes, execute, p;
    
    if ( Length( arg ) = 2 and IsRecord( arg[1] ) and IsString( arg[2] ) ) then
        
        stream := arg[1];
        
        graph := stream.ProcessGraph;
        
        process := ProcessForHomalg( stream.description_of_last_process, arg[2] );
        
        Add( graph, process );
        
        if IsBlockingProcess( process ) then
            
            processes := graph!.processes;
            
            execute := processes{[ graph!.processed + 1 .. Length( processes ) ]};
            Print( Length( execute ), "\n" );
            ViewObj( execute ); Print( "\n\n" );
            
            for p in execute do
                
                SendBlockingToCAS( stream, p!.string );
                
            od;
            
            graph!.processed := Length( processes );
            
        fi;
        
    else
        Error( "Wrong number or type of arguments." );
    fi;
    
end );

InstallGlobalFunction( TerminateVirtualCAS,
  function( arg )
    # Make this a no-op, as we can never re-start LibSingular
    # LibSingular will exit when gap exits
end );
