#############################################################################
##
##  VirtualMatrices.gi                                    VirtualCAS package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##                 Andreas Steenpaß, University of Kaiserslautern
##
##  Implementation stuff for virtual matrices.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsHomalgVirtualMatrixRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="A" Name="IsHomalgVirtualMatrixRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of &homalg; virtual matrices. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgMatrix"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgVirtualMatrixRep",
        IsHomalgVirtualMatrix,
        [ ] );

####################################
#
# families and types:
#
####################################

##
BindGlobal( "TheTypeHomalgVirtualMatrices",
        NewType( TheFamilyOfHomalgMatrices,
                IsHomalgVirtualMatrixRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( UnderlyingMatrix,
        "for homalg virtual matrices",
        [ IsHomalgVirtualMatrixRep and IsEmptyMatrix ],
        
  function( A )
    local B;
    
    if not HasEval( A ) then
      
      B := HomalgZeroMatrix( NrRows( A ), NrColumns( A ), UnderlyingNonVirtualRing( HomalgRing( A ) ) );
      
      SetEval( A, B );
    
    fi;
    
    return Eval( A );
  
end );

##
InstallMethod( UnderlyingMatrix,
        "for homalg virtual matrices",
        [ IsHomalgVirtualMatrixRep ],
        
  Eval );

##  <#GAPDoc Label="UnderlyingNonVirtualRing:matrix">
##  <ManSection>
##    <Oper Arg="mat" Name="UnderlyingNonVirtualRing" Label="for homalg virtual matrices"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      The nonvirtual ring underlying <C>HomalgRing</C>(<A>mat</A>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnderlyingNonVirtualRing,
        "for homalg virtual matrices",
        [ IsHomalgVirtualMatrixRep ],
        
  function( A )
    
    return UnderlyingNonVirtualRing( HomalgRing( A ) );
    
end );

##
InstallMethod( BlindlyCopyMatrixPropertiesToHomalgVirtualMatrix,	## under construction
        "for homalg virtual matrices",
        [ IsHomalgMatrix, IsHomalgVirtualMatrixRep ],
        
  function( S, T )
    local c;
    
    for c in [ NrRows, NrColumns ] do
        if Tester( c )( S ) then
            Setter( c )( T, c( S ) );
        fi;
    od;
    
    for c in [ IsZero, IsOne, IsDiagonalMatrix ] do
        if Tester( c )( S ) and c( S ) then
            Setter( c )( T, c( S ) );
        fi;
    od;
    
end );

##  <#GAPDoc Label="SetEntryOfHomalgMatrix">
##  <ManSection>
##    <Oper Arg="mat, i, j, r, R" Name="SetEntryOfHomalgMatrix" Label="for homalg virtual matrices"/>
##    <Description>
##      Changes the entry (<A>i,j</A>) of the virtual matrix <A>mat</A> to the value <A>r</A>. Here <A>R</A> is the (virtual) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg virtual matrices",
        [ IsHomalgVirtualMatrixRep and IsMutable, IsInt, IsInt, IsVirtualRingElementRep, IsHomalgVirtualRingRep ],
        
  function( M, r, c, s, R )
    
    SetEntryOfHomalgMatrix( UnderlyingMatrix( M ), r, c, UnderlyingNonVirtualRingElement( s ), UnderlyingNonVirtualRing( R ) );
    
end );

##  <#GAPDoc Label="AddToEntryOfHomalgMatrix">
##  <ManSection>
##    <Oper Arg="mat, i, j, r, R" Name="AddToEntryOfHomalgMatrix" Label="for homalg virtual matrices"/>
##    <Description>
##      Changes the entry (<A>i,j</A>) of the virtual matrix <A>mat</A> by adding the value <A>r</A> to it. Here <A>R</A> is the (virtual) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( AddToEntryOfHomalgMatrix,
        "for homalg virtual matrices",
        [ IsHomalgVirtualMatrixRep and IsMutable, IsInt, IsInt, IsVirtualRingElementRep, IsHomalgVirtualRingRep ],
        
  function( M, r, c, s, R )
    
    AddToEntryOfHomalgMatrix( UnderlyingMatrix( M ), r, c, UnderlyingNonVirtualRingElement( s ), UnderlyingNonVirtualRing( R ) );
    
end );

##  <#GAPDoc Label="GetEntryOfHomalgMatrixAsString">
##  <ManSection>
##    <Oper Arg="mat, i, j, R" Name="GetEntryOfHomalgMatrixAsString" Label="for homalg virtual matrices"/>
##    <Returns>a string</Returns>
##    <Description>
##      Returns the entry (<A>i,j</A>) of the virtual matrix <A>mat</A> as a string. Here <A>R</A> is the (virtual) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for homalg virtual matrices",
        [ IsHomalgVirtualMatrixRep, IsInt, IsInt, IsHomalgVirtualRingRep ],
        
  function( M, r, c, R )
    
    return GetEntryOfHomalgMatrixAsString( UnderlyingMatrix( M ), r, c, UnderlyingNonVirtualRing( R ) );
    
end );

##  <#GAPDoc Label="GetEntryOfHomalgMatrix">
##  <ManSection>
##    <Oper Arg="mat, i, j, R" Name="GetEntryOfHomalgMatrix" Label="for homalg virtual matrices"/>
##    <Returns>a virtual ring element</Returns>
##    <Description>
##      Returns the entry (<A>i,j</A>) of the virtual matrix <A>mat</A>. Here <A>R</A> is the (virtual) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( GetEntryOfHomalgMatrix,
        "for homalg virtual matrices",
        [ IsHomalgVirtualMatrixRep, IsInt, IsInt, IsHomalgVirtualRingRep ],
        
  function( M, r, c, R )
    
    return VirtualRingElement( GetEntryOfHomalgMatrix( UnderlyingMatrix( M ), r, c, UnderlyingNonVirtualRing( R ) ), R );
    
end );

##
InstallMethod( SaveHomalgMatrixToFile,
        "for homalg virtual matrices",
        [ IsString, IsHomalgVirtualMatrixRep, IsHomalgVirtualRingRep ],
        
  function( filename, M, R )
  
    return SaveHomalgMatrixToFile( filename, UnderlyingMatrix( M ), UnderlyingNonVirtualRing( R ) );
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for homalg virtual matrices",
        [ IsString, IsInt, IsInt, IsHomalgVirtualRingRep ],
        
  function( filename, r, c, R )
    
    return HomalgVirtualMatrix( LoadHomalgMatrixFromFile( filename, r, c, UnderlyingNonVirtualRing( R ) ), R );
    
end );


####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="HomalgVirtualMatrix">
##  <ManSection>
##    <Func Arg="numer, denom, R" Name="HomalgVirtualMatrix" Label="constructor for virtual matrices"/>
##    <Func Arg="numer, R" Name="HomalgVirtualMatrix" Label="constructor for virtual matrices"/>
##    <Returns>a virtual matrix</Returns>
##    <Description>
##      Creates the virtual matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomalgVirtualMatrix,
        "constructor for matrices over virtual rings",
        [ IsHomalgMatrix, IsHomalgVirtualRingRep ],
        
  function( A, R )
    local G, type, matrix, ComputationRing, rr, AA;
    
    if IsHomalgVirtualMatrixRep( A ) then
      return A;
    fi;
    
    G := HomalgRing( A );
    
    ComputationRing := UnderlyingNonVirtualRing( R );
    
    if not IsIdenticalObj( ComputationRing , HomalgRing( A ) ) then
      Error( "Underlying rings do not match" );
    fi;
    
    matrix := rec(
      ring := R,
     );
    
    ObjectifyWithAttributes(
      matrix, TheTypeHomalgVirtualMatrices,
      Eval, A
    );
    
    BlindlyCopyMatrixPropertiesToHomalgVirtualMatrix( A, matrix );
    
    return matrix;
    
end );

InstallMethod( HomalgVirtualMatrix,
        "constructor for matrices over virtual rings",
        [ IsList, IsInt, IsInt, IsHomalgVirtualRingRep ],
  function( A, r, c, R )
    
    return HomalgVirtualMatrix( HomalgMatrix( A, r, c, UnderlyingNonVirtualRing( R ) ), R );
    
end );

##
InstallMethod( \*,
        "for homalg matrices",
        [ IsHomalgVirtualRingRep, IsHomalgMatrix ],
        
  function( R, m )
    
    return HomalgVirtualMatrix( UnderlyingNonVirtualRing( R ) * m, R );
    
end );

##
InstallMethod( \*,
        "for matrices over virtual rings",
        [ IsHomalgRing, IsHomalgVirtualMatrixRep ],
        
  function( R, m )
    
    return R * UnderlyingMatrix( m );
    
end );

##
InstallMethod( PostMakeImmutable,
        "for homalg virtual matrices",
        [ IsHomalgVirtualMatrixRep and HasEval ],
        
  function( A )
    
    MakeImmutable( UnderlyingMatrix( A ) );
    
end );

##
InstallMethod( SetIsMutableMatrix,
        "for homalg virtual matrices",
        [ IsHomalgVirtualMatrixRep, IsBool ],
        
  function( A, b )
    
    if b = true then
      SetFilterObj( A, IsMutable );
    else
      ResetFilterObj( A, IsMutable );
    fi;
    
    SetIsMutableMatrix( UnderlyingMatrix( A ), b );
    
end );

##
InstallMethod( SaveHomalgMatrixToFile,
        "for matrices over virtual rings",
        [ IsString, IsHomalgVirtualMatrixRep ],
  function( filename, M )
    
    return SaveHomalgMatrixToFile( filename, UnderlyingMatrix( M ) );
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for a string and a virtual ring",
        [ IsString, IsHomalgVirtualRingRep ],
        
  function( filename, S )
    
    return LoadHomalgMatrixFromFile( filename, UnderlyingNonVirtualRing( S ) );
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for a string, two integers, and a virtual ring",
        [ IsString, IsInt, IsInt, IsHomalgVirtualRingRep ],
        
  function( filename, r, c, S )
    
    return LoadHomalgMatrixFromFile( filename, r, c, UnderlyingNonVirtualRing( S ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for homalg virtual matrices",
        [ IsHomalgVirtualMatrixRep ],
        
  function( A )
    
    Display( UnderlyingMatrix( A ) );
    
end );

