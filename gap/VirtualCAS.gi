#############################################################################
##
##  VirtualCAS.gi                                         VirtualCAS package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##                 Andreas Steenpaß, University of Kaiserslautern
##
##  Implementation stuff for VirtualCAS.
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
        IsHomalgRing and IsHomalgRingOrFinitelyPresentedModuleRep,
        [ "ring", "homalgTable" ] );

##  <#GAPDoc Label="IsHomalgVirtualRingElementRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="r" Name="IsHomalgVirtualRingElementRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of elements of virtual &homalg; rings. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgRingElement"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgVirtualRingElementRep",
        IsHomalgRingElement,
        [ ] );

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
        IsHomalgMatrix,
        [ ] );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "TheTypeHomalgVirtualRing",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgVirtualRingRep ) );

# two new types:
BindGlobal( "TheTypeHomalgVirtualRingElement",
        NewType( TheFamilyOfHomalgRingElements,
                IsHomalgVirtualRingElementRep ) );

BindGlobal( "TheTypeHomalgVirtualMatrix",
        NewType( TheFamilyOfHomalgMatrices,
                IsHomalgVirtualMatrixRep ) );

####################################
#
# methods for operations:
#
####################################

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( HomalgRingOfIntegersInVirtualCAS,
  function( arg )
    local ZZ;
    
    ZZ := CallFuncList( HomalgRingOfIntegersInSingular, arg );

    ZZ := rec(
              ring := ZZ,
             );
    
    ## Objectify:
    Objectify(
        TheTypeHomalgVirtualRing, ZZ );
    
    return ZZ;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInVirtualCAS,
  function( arg )
    
    return CallFuncList( HomalgFieldOfRationalsInSingular, arg );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg virtual rings",
        [ IsHomalgVirtualRingRep ],
        
  function( R )
    
    Print( "<A homalg virtual ring>" );
    
end );
