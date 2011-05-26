#############################################################################
##
##  VirtualCASTools.gd                                    VirtualCAS package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##                 Andreas Steenpaß, University of Kaiserslautern
##
##  Implementations for virtual rings.
##
#############################################################################

####################################
#
# global variables:
#
####################################

##
InstallValue( CommonHomalgTableForVirtualRingTools,
    
    rec(
        
        IsZero := a -> IsZero( UnderlyingNonVirtualRingElement( a ) ),
        
        IsOne := a -> IsZero( UnderlyingNonVirtualRingElement( a ) ),
        
        Minus :=
          function( a, b )
            return VirtualRingElement( UnderlyingNonVirtualRingElement( a ) - UnderlyingNonVirtualRingElement( b ), HomalgRing( a ) );
          end,
        
        DivideByUnit :=
          function( a, b )
            return VirtualRingElement( UnderlyingNonVirtualRingElement( a ) / UnderlyingNonVirtualRingElement( b ), HomalgRing( a ) );
          end,
        
        IsUnit :=
          function( R, a )
            return IsUnit( UnderlyingNonVirtualRing( R ), UnderlyingNonVirtualRingElement( a ) );
          end,
        
        Sum :=
          function( a, b )
            return VirtualRingElement( UnderlyingNonVirtualRingElement( a ) + UnderlyingNonVirtualRingElement( b ), HomalgRing( a ) );
          end,
        
        Product :=
          function( a, b )
            return VirtualRingElement( UnderlyingNonVirtualRingElement( a ) * UnderlyingNonVirtualRingElement( b ), HomalgRing( a ) );
          end,
        
        ShallowCopy := C -> ShallowCopy( Eval( C ) ),
        
        InitialMatrix :=
          function( C )
            HomalgInitialMatrix( NrRows( C ), NrColumns( C ), UnderlyingNonVirtualRing( C ) );
          end,
        
        InitialIdentityMatrix :=
          function( C )
            return HomalgInitialIdentityMatrix( NrRows( C ), UnderlyingNonVirtualRing( HomalgRing( C ) ) );
          end,
        
        ZeroMatrix :=
          function( C )
            return HomalgZeroMatrix( NrRows( C ), NrColumns( C ), UnderlyingNonVirtualRing( HomalgRing( C ) ) );
          end,
        
        IdentityMatrix :=
          function( C )
            return HomalgIdentityMatrix( NrRows( C ), UnderlyingNonVirtualRing( HomalgRing( C ) ) );
          end,
        
        AreEqualMatrices :=
          function( A, B )
            return UnderlyingMatrix( A ) = UnderlyingMatrix( B );
          end,
        
        Involution :=
          function( M )
            return Involution( UnderlyingMatrix( M ) );
          end,
        
        CertainRows :=
          function( M, plist )
            return CertainRows( UnderlyingMatrix( M ), plist );
          end,
        
        CertainColumns :=
          function( M, plist )
            return CertainColumns( UnderlyingMatrix( M ), plist );
          end,
        
        UnionOfRows :=
          function( A, B )
            return UnionOfRows( UnderlyingMatrix( A ), UnderlyingMatrix( B ) );
          end,
        
        UnionOfColumns :=
          function( A, B )
            return UnionOfColumns( UnderlyingMatrix( A ), UnderlyingMatrix( B ) );
          end,
        
        DiagMat :=
          function( e )
            return DiagMat( List( e, UnderlyingMatrix ) );
          end,
        
        KroneckerMat :=
          function( A, B )
            return KroneckerMat( UnderlyingMatrix( A ), UnderlyingMatrix( B ) );
          end,
        
        MulMat :=
          function( a, A )
            return UnderlyingNonVirtualRingElement( a ) * UnderlyingMatrix( A );
          end,
        
        AddMat :=
          function( A, B )
            return UnderlyingMatrix( A ) + UnderlyingMatrix( B );
          end,
        
        SubMat :=
          function( A, B )
            return UnderlyingMatrix( A ) - UnderlyingMatrix( B );
          end,
        
        Compose :=
          function( A, B )
            return UnderlyingMatrix( A ) * UnderlyingMatrix( B );
          end,
        
        NrRows := C -> NrRows( UnderlyingMatrix( C ) ),
        
        NrColumns := C -> NrColumns( UnderlyingMatrix( C ) ),
        
        IsZeroMatrix := M -> IsZero( UnderlyingMatrix( M ) ),
        
        IsIdentityMatrix := M -> IsOne( UnderlyingMatrix( M ) ),
        
        IsDiagonalMatrix := M -> IsDiagonalMatrix( UnderlyingMatrix( M ) ),
        
        ZeroRows := C -> ZeroRows( UnderlyingMatrix( C ) ),
        
        ZeroColumns := C -> ZeroColumns( UnderlyingMatrix( C ) ),
        
        GetColumnIndependentUnitPositions :=
          function( M, pos_list )
            local pos;
            pos := GetColumnIndependentUnitPositions( UnderlyingMatrix( M ), pos_list );
            if pos <> [ ] then
                SetIsZero( M, false );
            fi;
            return pos;
          end,
        
        GetRowIndependentUnitPositions :=
          function( M, pos_list )
            local pos;
            pos := GetRowIndependentUnitPositions( UnderlyingMatrix( M ), pos_list );
            if pos <> [ ] then
                SetIsZero( M, false );
            fi;
            return pos;
          end,
        
        GetUnitPosition :=
          function( M, pos_list )
            return GetUnitPosition( UnderlyingMatrix( M ), pos_list );
          end,
        
        DivideEntryByUnit :=
          function( M, i, j, u )
            DivideEntryByUnit( UnderlyingMatrix( M ), i, j, UnderlyingNonVirtualRingElement( u ) );
          end,
        
        CopyRowToIdentityMatrix :=
          function( M, i, L, j )
            local l;
            l := List( L, function( a ) if IsHomalgVirtualMatrixRep( a ) then return UnderlyingMatrix( a ); else return a; fi; end );
            CopyRowToIdentityMatrix( UnderlyingMatrix( M ), i, l, j );
          end,
        
        CopyColumnToIdentityMatrix :=
          function( M, j, L, i )
            return CopyColumnToIdentityMatrix( UnderlyingMatrix( M ), j, UnderlyingMatrix( L ), i );
          end,
        
        SetColumnToZero :=
          function( M, i, j )
            return SetColumnToZero( UnderlyingMatrix( M ), i, j );
          end,
        
        GetCleanRowsPositions :=
          function( M, clean_columns )
            return GetCleanRowsPositions(  UnderlyingMatrix( M ), clean_columns );
          end,
        
     )
  );
