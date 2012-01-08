#############################################################################
##
##  ProcessGraph.gi                                       VirtualCAS package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##                 Andreas Steenpaß, University of Kaiserslautern
##
##  Implementation stuff for process graphs.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsProcessForHomalgRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="R" Name="IsProcessForHomalgRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of a process. <P/>
##      (It is a representation of the &GAP; category <C>IsProcessForHomalg</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsProcessForHomalgRep",
        IsProcessForHomalg,
        [ ] );

##  <#GAPDoc Label="IsProcessGraphRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="R" Name="IsProcessGraphRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of process graphs. <P/>
##      (It is a representation of the &GAP; category <C>IsProcessGraph</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsProcessGraphRep",
        IsProcessGraph,
        [ ] );

####################################
#
# families and types:
#
####################################

##
BindGlobal( "TheFamilyOfProcessesForHomalg",
        NewFamily( "TheFamilyOfProcessesForHomalg" ) );

##
BindGlobal( "TheFamilyOfProcessGraphs",
        NewFamily( "TheFamilyOfProcessGraphs" ) );

##
BindGlobal( "TheTypeProcessForHomalg",
        NewType( TheFamilyOfProcessesForHomalg,
                IsProcessForHomalgRep ) );
##
BindGlobal( "TheTypeProcessGraph",
        NewType( TheFamilyOfProcessGraphs,
                IsProcessGraphRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( NrVertices,
        "for a process graph",
        [ IsProcessGraphRep ],
        
  function( pg )
    
    return Length( pg!.processes );
    
end );

##
InstallMethod( Add,
        "for a process graph and a process",
        [ IsProcessGraphRep, IsProcessForHomalgRep ],
        
  function( pg, p )
    
    Add( pg!.processes, p );
    
end );

####################################
#
# constructor functions and methods:
#
####################################


##
InstallGlobalFunction( ProcessForHomalg,
  function( description, string )
    local p;
    
    p := rec( identifier := description[1],
              parents := description[2],
              pictogram := description[4],
              string := string );
    
    ## Objectify
    Objectify( TheTypeProcessForHomalg, p );
    
    if description[3] then
        ResetFilterObj( p, IsBlockingProcess );
    else
        SetFilterObj( p, IsBlockingProcess );
    fi;
    
    return p;
    
end );

##
InstallGlobalFunction( ProcessGraph,
  function( )
    local pg;
    
    pg := rec( processed := 0, processes := [ ] );
    
    ## Objectify
    Objectify( TheTypeProcessGraph, pg );
    
    return pg;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for processes for homalg",
        [ IsProcessForHomalgRep ],
        
  function( o )
    local non, id, parents;
    
    if IsBlockingProcess( o ) then
        non := "";
    else
        non := "non";
    fi;
    
    if o!.identifier <> [ ] then
        id := Concatenation( " id=", String( o!.identifier[1] ) );
    else
        id := "";
    fi;
    
    if o!.parents <> [ ] then
        parents := Concatenation( " parents=", String( o!.parents ) );
    else
        parents := "";
    fi;
    
    Print( "<A ", non, "blocking process", id, parents, " (", o!.pictogram, ")>" );
    
end );

##
InstallMethod( ViewObj,
        "for process graphs",
        [ IsProcessGraphRep ],
        
  function( o )
    
    Print( "<A graph with ", NrVertices( o ), " processes for homalg>" );
    
end );

##
InstallMethod( Display,
        "for processes for homalg",
        [ IsProcessForHomalgRep ],
        
  function( o )
    
    ViewObj( o!.string );
    Print( "\n" );
    
end );

##
InstallMethod( Display,
        "for process graphs",
        [ IsProcessGraphRep ],
        
  function( o )
    
    ViewObj( o!.processes );
    Print( "\n" );
    
end );
