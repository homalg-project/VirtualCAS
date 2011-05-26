#############################################################################
##
##  VirtualRings.gi                                       VirtualCAS package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##                 Andreas Steenpaß, University of Kaiserslautern
##
##  Implementation stuff for virtual rings.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsHomalgVirtualRingRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="R" Name="IsHomalgVirtualRingRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The internal representation of &homalg; rings. <P/>
##      (It is a representation of the &GAP; category <C>IsHomalgRing</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgVirtualRingRep",
        IsHomalgVirtualRing and IsHomalgRingOrFinitelyPresentedModuleRep,
        [ "ring", "homalgTable" ] );

##  <#GAPDoc Label="IsVirtualRingElementRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="r" Name="IsVirtualRingElementRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of elements of virtual &homalg; rings. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgRingElement"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsVirtualRingElementRep",
        IsHomalgVirtualRingElement,
        [ ] );

####################################
#
# families and types:
#
####################################

##
BindGlobal( "TheTypeHomalgVirtualRing",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgVirtualRingRep ) );

##
BindGlobal( "TheTypeVirtualRingElement",
        NewType( TheFamilyOfHomalgRingElements,
                IsVirtualRingElementRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( UnderlyingNonVirtualRingElement,
        "for homalg virtual ring elements",
        [ IsVirtualRingElementRep ],
        
  EvalRingElement );

##  <#GAPDoc Label="UnderlyingNonVirtualRing:ring">
##  <ManSection>
##    <Oper Arg="R" Name="UnderlyingNonVirtualRing" Label="for homalg virtual rings"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      Internally there is a ring, in which computations take place.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnderlyingNonVirtualRing,
        "for homalg virtual rings",
        [ IsHomalgVirtualRingRep ],
        
  function( R )
    
    return R!.ring;
    
end );

##  <#GAPDoc Label="UnderlyingNonVirtualRing:element">
##  <ManSection>
##    <Oper Arg="r" Name="UnderlyingNonVirtualRing" Label="for homalg Virtual ring elements"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      Internally there is a ring, in which computations take place.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnderlyingNonVirtualRing,
        "for homalg virtual ring elements",
        [ IsVirtualRingElementRep ],
        
  function( r )
    
    return UnderlyingNonVirtualRing( HomalgRing( r ) );
    
end );

##  <#GAPDoc Label="Name">
##  <ManSection>
##    <Oper Arg="r" Name="Name" Label="for homalg virtual ring elements"/>
##    <Returns>a string</Returns>
##    <Description>
##      The name of the Virtual ring element <A>r</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Name,
        "for homalg virtual ring elements",
        [ IsVirtualRingElementRep ],
        
  function( o )
    
    return Name( UnderlyingNonVirtualRingElement( o ) );
    
end );

##
InstallMethod( String,
        "for homalg virtual ring elements",
        [ IsVirtualRingElementRep ],
        
  Name );

####################################
#
# constructor functions and methods:
#
####################################


##
InstallMethod( VirtualRing,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( R )
    local RP, S, A, rel, c;
    
    ## create ring RP with R as underlying ring
    RP := CreateHomalgTableForVirtualRings( R );
    
    ## create the virtual ring
    S := CreateHomalgRing( R, [ TheTypeHomalgVirtualRing, ValueGlobal( "TheTypeHomalgVirtualMatrices" ) ], VirtualRingElement, RP );
    SetConstructorForHomalgMatrices( S,
      function( arg )
        local nargs, R, mat, l;
        nargs := Length( arg );
        R := arg[nargs];
        l := Concatenation( arg{[ 1 .. nargs - 1 ]}, [ UnderlyingNonVirtualRing( R ) ] );
        mat := CallFuncList( HomalgMatrix, l );
        return HomalgVirtualMatrix( mat, R );
      end
    );
    
    ## for the view methods:
    ## <A virtual ring>
    ## <A matrix over a virtual ring>
    S!.description := " virtual";
    
    if HasZero( R ) then
        SetZero( S, VirtualRingElement( Zero( R ), S ) );
    fi;
    
    if HasOne( R ) then
        SetOne( S, VirtualRingElement( One( R ), S ) );
    fi;
    
    if HasMinusOne( R ) then
        SetMinusOne( S, VirtualRingElement( MinusOne( R ), S ) );
    fi;
    
    if HasRingRelations( R ) then
        A := VirtualRing( AmbientRing( R ) );
        rel := RingRelations( R );
        if IsHomalgRingRelationsAsGeneratorsOfLeftIdeal( rel ) then
            rel := HomalgVirtualMatrix( MatrixOfRelations( rel ), A );
            rel := HomalgRingRelationsAsGeneratorsOfLeftIdeal( rel );
        else
            rel := HomalgVirtualMatrix( MatrixOfRelations( rel ), A );
            rel := HomalgRingRelationsAsGeneratorsOfRightIdeal( rel );
        fi;
        SetRingRelations( S, rel );
    fi;
    
    MatchPropertiesAndAttributes( R, S, LIRNG.intrinsic_properties, LIRNG.intrinsic_attributes );
    
    return S;
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInVirtualCAS,
  function( arg )
    
    return VirtualRing( CallFuncList( HomalgRingOfIntegersInSingular, arg ) );
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInVirtualCAS,
  function( arg )
    
    return VirtualRing( CallFuncList( HomalgFieldOfRationalsInSingular, arg ) );
    
end );

##  <#GAPDoc Label="VirtualRingElement">
##  <ManSection>
##    <Func Arg="numer, denom, R" Name="VirtualRingElement" Label="constructor for virtual ring elements"/>
##    <Func Arg="numer, R" Name="VirtualRingElement" Label="constructor for virtual ring elements"/>
##    <Returns>a virtual ring element</Returns>
##    <Description>
##      Creates the virtual ring element.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( VirtualRingElement,
  function( arg )
    local nargs, el, S, ar, properties, R, degree, c, r;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input\n" );
    fi;
    
    el := arg[1];
    
    if IsVirtualRingElementRep( el ) then
        
        return el;
        
    elif nargs = 2 then
        
        ## extract the properties of the global ring element
        if IsHomalgVirtualRing( arg[2] ) then
            S := arg[2];
            ar := [ el, S ];
            properties := KnownTruePropertiesOfObject( el );	## FIXME: a huge potential for problems
            Add( ar, List( properties, ValueGlobal ) );  ## at least an empty list is inserted; avoids infinite loops
            return CallFuncList( VirtualRingElement, ar );
        else
            Error( "Expected a ring element and a ring" );
        fi;
        
    fi;
    
    properties := [ ];
    
    for ar in arg{[ 2 .. nargs ]} do
        if not IsBound( S ) and IsHomalgVirtualRing( ar ) then
            S := ar;
        elif IsList( ar ) and ForAll( ar, IsFilter ) then
            Append( properties, ar );
        else
            Error( "this argument (now assigned to ar) should be in { IsHomalgRing, IsList( IsFilter )}\n" );
        fi;
    od;
    
    R := UnderlyingNonVirtualRing( S );
    
    if not IsHomalgRingElement( el ) or not IsIdenticalObj( R, HomalgRing( el ) ) then
        el := HomalgRingElement( el, R );
    fi;
    
    if IsBound( S ) then
        
        r := rec(
                 ring := S
                 );
        
        ## Objectify:
        ObjectifyWithAttributes( 
                r, TheTypeVirtualRingElement,
                EvalRingElement, el
                );
        
        if properties <> [ ] then
            for ar in properties do
                Setter( ar )( r, true );
            od;
        fi;
        
        return r;
        
    else
        
        Error( "No virtual ring found in parameters" );
        
    fi;
    
end );

##
InstallMethod( \/,  ## this operation is declared in the file HomalgRelations.gd
        "constructor for virtual residue class	 rings",
        [ IsHomalgVirtualRingRep, IsHomalgRingRelations ],
        
  function( S, ring_rel )
    local left, result, mat, rel, rel_old, mat_old, left_old, c;
    
    left := IsHomalgRingRelationsAsGeneratorsOfLeftIdeal( ring_rel );
    
    mat := UnderlyingMatrix( MatrixOfRelations( ring_rel ) );
    
    if left then
        rel := HomalgRingRelationsAsGeneratorsOfLeftIdeal( mat );
    else
        rel := HomalgRingRelationsAsGeneratorsOfRightIdeal( mat );
    fi;
    
    result := VirtualRing( UnderlyingNonVirtualRing( S ) / rel );
    
    if HasContainsAField( S ) and ContainsAField( S ) then
        SetContainsAField( result, true );
        if HasCoefficientsRing( S ) then
            SetCoefficientsRing( result, CoefficientsRing( S ) );
        fi;
    fi;
    
    if HasAmbientRing( S ) then
        SetAmbientRing( result, AmbientRing( S ) );
    else
        SetAmbientRing( result, S );
    fi;
    
    return result;
    
end );


####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg virtual ring elements",
        [ IsVirtualRingElementRep ],
        
  function( o )
    
    ViewObj(  UnderlyingNonVirtualRingElement( o ) );
    
end );

##
InstallMethod( Display,
        "for homalg virtual ring elements",
        [ IsVirtualRingElementRep ],
        
  function( r )
    
    Display(  UnderlyingNonVirtualRingElement( r ) );
    
end );
