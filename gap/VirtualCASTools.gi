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
            return UnderlyingNonVirtualMatrix( A ) = UnderlyingNonVirtualMatrix( B );
          end,
        
        Involution :=
          function( M )
            return Involution( UnderlyingNonVirtualMatrix( M ) );
          end,
        
        CertainRows :=
          function( M, plist )
            return CertainRows( UnderlyingNonVirtualMatrix( M ), plist );
          end,
        
        CertainColumns :=
          function( M, plist )
            return CertainColumns( UnderlyingNonVirtualMatrix( M ), plist );
          end,
        
        UnionOfRows :=
          function( A, B )
            return UnionOfRows( UnderlyingNonVirtualMatrix( A ), UnderlyingNonVirtualMatrix( B ) );
          end,
        
        UnionOfColumns :=
          function( A, B )
            return UnionOfColumns( UnderlyingNonVirtualMatrix( A ), UnderlyingNonVirtualMatrix( B ) );
          end,
        
        DiagMat :=
          function( e )
            return DiagMat( List( e, UnderlyingNonVirtualMatrix ) );
          end,
        
        KroneckerMat :=
          function( A, B )
            return KroneckerMat( UnderlyingNonVirtualMatrix( A ), UnderlyingNonVirtualMatrix( B ) );
          end,
        
        MulMat :=
          function( a, A )
            return UnderlyingNonVirtualRingElement( a ) * UnderlyingNonVirtualMatrix( A );
          end,
        
        AddMat :=
          function( A, B )
            return UnderlyingNonVirtualMatrix( A ) + UnderlyingNonVirtualMatrix( B );
          end,
        
        SubMat :=
          function( A, B )
            return UnderlyingNonVirtualMatrix( A ) - UnderlyingNonVirtualMatrix( B );
          end,
        
        Compose :=
          function( A, B )
            return UnderlyingNonVirtualMatrix( A ) * UnderlyingNonVirtualMatrix( B );
          end,
        
        NrRows := C -> NrRows( UnderlyingNonVirtualMatrix( C ) ),
        
        NrColumns := C -> NrColumns( UnderlyingNonVirtualMatrix( C ) ),
        
        IsZeroMatrix := M -> IsZero( UnderlyingNonVirtualMatrix( M ) ),
        
        IsIdentityMatrix := M -> IsOne( UnderlyingNonVirtualMatrix( M ) ),
        
        IsDiagonalMatrix := M -> IsDiagonalMatrix( UnderlyingNonVirtualMatrix( M ) ),
        
        ZeroRows := C -> ZeroRows( UnderlyingNonVirtualMatrix( C ) ),
        
        ZeroColumns := C -> ZeroColumns( UnderlyingNonVirtualMatrix( C ) ),
        
        GetColumnIndependentUnitPositions :=
          function( M, pos_list )
            local pos;
            pos := GetColumnIndependentUnitPositions( UnderlyingNonVirtualMatrix( M ), pos_list );
            if pos <> [ ] then
                SetIsZero( M, false );
            fi;
            return pos;
          end,
        
        GetRowIndependentUnitPositions :=
          function( M, pos_list )
            local pos;
            pos := GetRowIndependentUnitPositions( UnderlyingNonVirtualMatrix( M ), pos_list );
            if pos <> [ ] then
                SetIsZero( M, false );
            fi;
            return pos;
          end,
        
        GetUnitPosition :=
          function( M, pos_list )
            return GetUnitPosition( UnderlyingNonVirtualMatrix( M ), pos_list );
          end,
        
        DivideEntryByUnit :=
          function( M, i, j, u )
            DivideEntryByUnit( UnderlyingNonVirtualMatrix( M ), i, j, UnderlyingNonVirtualRingElement( u ) );
          end,
        
        CopyRowToIdentityMatrix :=
          function( M, i, L, j )
            local l;
            l := List( L, function( a ) if IsHomalgVirtualMatrixRep( a ) then return UnderlyingNonVirtualMatrix( a ); else return a; fi; end );
            CopyRowToIdentityMatrix( UnderlyingNonVirtualMatrix( M ), i, l, j );
          end,
        
        CopyColumnToIdentityMatrix :=
          function( M, j, L, i )
            return CopyColumnToIdentityMatrix( UnderlyingNonVirtualMatrix( M ), j, UnderlyingNonVirtualMatrix( L ), i );
          end,
        
        SetColumnToZero :=
          function( M, i, j )
            return SetColumnToZero( UnderlyingNonVirtualMatrix( M ), i, j );
          end,
        
        GetCleanRowsPositions :=
          function( M, clean_columns )
            return GetCleanRowsPositions(  UnderlyingNonVirtualMatrix( M ), clean_columns );
          end,
        
     )
  );
