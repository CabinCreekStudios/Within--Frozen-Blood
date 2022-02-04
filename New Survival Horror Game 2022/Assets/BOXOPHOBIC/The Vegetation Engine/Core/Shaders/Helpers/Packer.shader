// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Packer"
{
	Properties
	{
		[HideInInspector]_MainTex("Dummy Texture", 2D) = "white" {}
		[NoScaleOffset]_Packer_TexR("Packer_TexR", 2D) = "white" {}
		[NoScaleOffset]_Packer_TexG("Packer_TexG", 2D) = "white" {}
		[NoScaleOffset]_Packer_TexB("Packer_TexB", 2D) = "white" {}
		[NoScaleOffset]_Packer_TexA("Packer_TexA", 2D) = "white" {}
		[Space(10)]_Packer_FloatR("Packer_FloatR", Range( 0 , 1)) = 0
		_Packer_FloatG("Packer_FloatG", Range( 0 , 1)) = 0
		_Packer_FloatB("Packer_FloatB", Range( 0 , 1)) = 0
		_Packer_FloatA("Packer_FloatA", Range( 0 , 1)) = 0
		[Space(10)]_Packer_Action0B("Packer_Action0B", Float) = 0
		[Space(10)]_Packer_Action1B("Packer_Action1B", Float) = 0
		[Space(10)]_Packer_Action0G("Packer_Action0G", Float) = 0
		[Space(10)]_Packer_Action2B("Packer_Action2B", Float) = 0
		[Space(10)]_Packer_Action2R("Packer_Action2R", Float) = 0
		[Space(10)]_Packer_Action1R("Packer_Action1R", Float) = 0
		[Space(10)]_Packer_Action0A("Packer_Action0A", Float) = 0
		[Space(10)]_Packer_Action2G("Packer_Action2G", Float) = 0
		[Space(10)]_Packer_Action1G("Packer_Action1G", Float) = 0
		[Space(10)]_Packer_Action2A("Packer_Action2A", Float) = 0
		[Space(10)]_Packer_Action0R("Packer_Action0R", Float) = 0
		[Space(10)]_Packer_Action1A("Packer_Action1A", Float) = 0
		[IntRange][Space(10)]_Packer_ChannelR("Packer_ChannelR", Range( 0 , 4)) = 0
		[IntRange]_Packer_ChannelG("Packer_ChannelG", Range( 0 , 4)) = 0
		[IntRange]_Packer_ChannelB("Packer_ChannelB", Range( 0 , 4)) = 0
		[IntRange]_Packer_ChannelA("Packer_ChannelA", Range( 0 , 4)) = 0
		[Space(10)]_Packer_TexR_Storage("Packer_TexR_Storage", Float) = 0
		_Packer_TexG_Storage("Packer_TexG_Storage", Float) = 0
		_Packer_TexB_Storage("Packer_TexB_Storage", Float) = 0
		[ASEEnd]_Packer_TexA_Storage("Packer_TexA_Storage", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" "PreviewType"="Plane" }
	LOD 0

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"

			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform sampler2D _MainTex;
			uniform float _Packer_TexR_Storage;
			uniform float _Packer_Action2R;
			uniform float _Packer_Action1R;
			uniform float _Packer_Action0R;
			uniform float _Packer_ChannelR;
			uniform float _Packer_FloatR;
			uniform sampler2D _Packer_TexR;
			uniform float _Packer_TexG_Storage;
			uniform float _Packer_Action2G;
			uniform float _Packer_Action1G;
			uniform float _Packer_Action0G;
			uniform float _Packer_ChannelG;
			uniform float _Packer_FloatG;
			uniform sampler2D _Packer_TexG;
			uniform float _Packer_TexB_Storage;
			uniform float _Packer_Action2B;
			uniform float _Packer_Action1B;
			uniform float _Packer_Action0B;
			uniform float _Packer_ChannelB;
			uniform float _Packer_FloatB;
			uniform sampler2D _Packer_TexB;
			uniform float _Packer_TexA_Storage;
			uniform float _Packer_Action2A;
			uniform float _Packer_Action1A;
			uniform float _Packer_Action0A;
			uniform float _Packer_ChannelA;
			uniform float _Packer_FloatA;
			uniform sampler2D _Packer_TexA;
			inline float GammaToLinearFloat100_g43( float value )
			{
				return GammaToLinearSpaceExact(value);
			}
			
			inline float LinearToGammaFloat102_g43( float value )
			{
				return LinearToGammaSpaceExact(value);
			}
			
			inline float GammaToLinearFloat100_g40( float value )
			{
				return GammaToLinearSpaceExact(value);
			}
			
			inline float LinearToGammaFloat102_g40( float value )
			{
				return LinearToGammaSpaceExact(value);
			}
			
			inline float GammaToLinearFloat100_g42( float value )
			{
				return GammaToLinearSpaceExact(value);
			}
			
			inline float LinearToGammaFloat102_g42( float value )
			{
				return LinearToGammaSpaceExact(value);
			}
			
			inline float GammaToLinearFloat100_g41( float value )
			{
				return GammaToLinearSpaceExact(value);
			}
			
			inline float LinearToGammaFloat102_g41( float value )
			{
				return LinearToGammaSpaceExact(value);
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				int Storage114_g43 = (int)_Packer_TexR_Storage;
				int Action2189_g43 = (int)_Packer_Action2R;
				int Action1187_g43 = (int)_Packer_Action1R;
				int Action0173_g43 = (int)_Packer_Action0R;
				int Channel31_g43 = (int)_Packer_ChannelR;
				float ifLocalVar24_g43 = 0;
				if( Channel31_g43 == 0 )
				ifLocalVar24_g43 = _Packer_FloatR;
				float2 uv_Packer_TexR26 = i.ase_texcoord1.xy;
				float4 break23_g43 = tex2Dlod( _Packer_TexR, float4( uv_Packer_TexR26, 0, 0.0) );
				float R39_g43 = break23_g43.r;
				float ifLocalVar13_g43 = 0;
				if( Channel31_g43 == 1 )
				ifLocalVar13_g43 = R39_g43;
				float G40_g43 = break23_g43.g;
				float ifLocalVar12_g43 = 0;
				if( Channel31_g43 == 2 )
				ifLocalVar12_g43 = G40_g43;
				float B41_g43 = break23_g43.b;
				float ifLocalVar11_g43 = 0;
				if( Channel31_g43 == 3 )
				ifLocalVar11_g43 = B41_g43;
				float A42_g43 = break23_g43.a;
				float ifLocalVar17_g43 = 0;
				if( Channel31_g43 == 4 )
				ifLocalVar17_g43 = A42_g43;
				float GRAY135_g43 = ( ( R39_g43 * 0.3 ) + ( G40_g43 * 0.59 ) + ( B41_g43 * 0.11 ) );
				float ifLocalVar62_g43 = 0;
				if( Channel31_g43 == 555 )
				ifLocalVar62_g43 = GRAY135_g43;
				float ifLocalVar154_g43 = 0;
				if( Channel31_g43 == 14 )
				ifLocalVar154_g43 = ( R39_g43 * A42_g43 );
				float ifLocalVar159_g43 = 0;
				if( Channel31_g43 == 24 )
				ifLocalVar159_g43 = ( G40_g43 * A42_g43 );
				float ifLocalVar165_g43 = 0;
				if( Channel31_g43 == 34 )
				ifLocalVar165_g43 = ( B41_g43 * A42_g43 );
				float ifLocalVar147_g43 = 0;
				if( Channel31_g43 == 5554 )
				ifLocalVar147_g43 = ( GRAY135_g43 * A42_g43 );
				float Packed_Raw182_g43 = ( ifLocalVar24_g43 + ifLocalVar13_g43 + ifLocalVar12_g43 + ifLocalVar11_g43 + ifLocalVar17_g43 + ifLocalVar62_g43 + ifLocalVar154_g43 + ifLocalVar159_g43 + ifLocalVar165_g43 + ifLocalVar147_g43 );
				float ifLocalVar180_g43 = 0;
				if( Action0173_g43 == 0 )
				ifLocalVar180_g43 = Packed_Raw182_g43;
				float ifLocalVar171_g43 = 0;
				if( Action0173_g43 == 1 )
				ifLocalVar171_g43 = ( 1.0 - Packed_Raw182_g43 );
				float Packed_Action0185_g43 = saturate( ( ifLocalVar180_g43 + ifLocalVar171_g43 ) );
				float ifLocalVar193_g43 = 0;
				if( Action1187_g43 == 0 )
				ifLocalVar193_g43 = Packed_Action0185_g43;
				float ifLocalVar197_g43 = 0;
				if( Action1187_g43 == 1 )
				ifLocalVar197_g43 = ( Packed_Action0185_g43 * 0.0 );
				float ifLocalVar207_g43 = 0;
				if( Action1187_g43 == 2 )
				ifLocalVar207_g43 = ( Packed_Action0185_g43 * 2.0 );
				float ifLocalVar248_g43 = 0;
				if( Action1187_g43 == 3 )
				ifLocalVar248_g43 = ( Packed_Action0185_g43 * 3.0 );
				float ifLocalVar211_g43 = 0;
				if( Action1187_g43 == 5 )
				ifLocalVar211_g43 = ( Packed_Action0185_g43 * 5.0 );
				float Packed_Action1202_g43 = saturate( ( ifLocalVar193_g43 + ifLocalVar197_g43 + ifLocalVar207_g43 + ifLocalVar248_g43 + ifLocalVar211_g43 ) );
				float ifLocalVar220_g43 = 0;
				if( Action2189_g43 == 0 )
				ifLocalVar220_g43 = Packed_Action1202_g43;
				float ifLocalVar254_g43 = 0;
				if( Action2189_g43 == 1 )
				ifLocalVar254_g43 = pow( Packed_Action1202_g43 , 0.0 );
				float ifLocalVar225_g43 = 0;
				if( Action2189_g43 == 2 )
				ifLocalVar225_g43 = pow( Packed_Action1202_g43 , 2.0 );
				float ifLocalVar229_g43 = 0;
				if( Action2189_g43 == 3 )
				ifLocalVar229_g43 = pow( Packed_Action1202_g43 , 3.0 );
				float ifLocalVar234_g43 = 0;
				if( Action2189_g43 == 4 )
				ifLocalVar234_g43 = pow( Packed_Action1202_g43 , 4.0 );
				float Packed_Action2237_g43 = saturate( ( ifLocalVar220_g43 + ifLocalVar254_g43 + ifLocalVar225_g43 + ifLocalVar229_g43 + ifLocalVar234_g43 ) );
				float Packed_Final112_g43 = Packed_Action2237_g43;
				float ifLocalVar105_g43 = 0;
				if( Storage114_g43 == 0.0 )
				ifLocalVar105_g43 = Packed_Final112_g43;
				float value100_g43 = Packed_Final112_g43;
				float localGammaToLinearFloat100_g43 = GammaToLinearFloat100_g43( value100_g43 );
				float ifLocalVar93_g43 = 0;
				if( Storage114_g43 == 1.0 )
				ifLocalVar93_g43 = localGammaToLinearFloat100_g43;
				float value102_g43 = Packed_Final112_g43;
				float localLinearToGammaFloat102_g43 = LinearToGammaFloat102_g43( value102_g43 );
				float ifLocalVar107_g43 = 0;
				if( Storage114_g43 == 2.0 )
				ifLocalVar107_g43 = localLinearToGammaFloat102_g43;
				float R74 = ( ifLocalVar105_g43 + ifLocalVar93_g43 + ifLocalVar107_g43 );
				int Storage114_g40 = (int)_Packer_TexG_Storage;
				int Action2189_g40 = (int)_Packer_Action2G;
				int Action1187_g40 = (int)_Packer_Action1G;
				int Action0173_g40 = (int)_Packer_Action0G;
				int Channel31_g40 = (int)_Packer_ChannelG;
				float ifLocalVar24_g40 = 0;
				if( Channel31_g40 == 0 )
				ifLocalVar24_g40 = _Packer_FloatG;
				float2 uv_Packer_TexG51 = i.ase_texcoord1.xy;
				float4 break23_g40 = tex2Dlod( _Packer_TexG, float4( uv_Packer_TexG51, 0, 0.0) );
				float R39_g40 = break23_g40.r;
				float ifLocalVar13_g40 = 0;
				if( Channel31_g40 == 1 )
				ifLocalVar13_g40 = R39_g40;
				float G40_g40 = break23_g40.g;
				float ifLocalVar12_g40 = 0;
				if( Channel31_g40 == 2 )
				ifLocalVar12_g40 = G40_g40;
				float B41_g40 = break23_g40.b;
				float ifLocalVar11_g40 = 0;
				if( Channel31_g40 == 3 )
				ifLocalVar11_g40 = B41_g40;
				float A42_g40 = break23_g40.a;
				float ifLocalVar17_g40 = 0;
				if( Channel31_g40 == 4 )
				ifLocalVar17_g40 = A42_g40;
				float GRAY135_g40 = ( ( R39_g40 * 0.3 ) + ( G40_g40 * 0.59 ) + ( B41_g40 * 0.11 ) );
				float ifLocalVar62_g40 = 0;
				if( Channel31_g40 == 555 )
				ifLocalVar62_g40 = GRAY135_g40;
				float ifLocalVar154_g40 = 0;
				if( Channel31_g40 == 14 )
				ifLocalVar154_g40 = ( R39_g40 * A42_g40 );
				float ifLocalVar159_g40 = 0;
				if( Channel31_g40 == 24 )
				ifLocalVar159_g40 = ( G40_g40 * A42_g40 );
				float ifLocalVar165_g40 = 0;
				if( Channel31_g40 == 34 )
				ifLocalVar165_g40 = ( B41_g40 * A42_g40 );
				float ifLocalVar147_g40 = 0;
				if( Channel31_g40 == 5554 )
				ifLocalVar147_g40 = ( GRAY135_g40 * A42_g40 );
				float Packed_Raw182_g40 = ( ifLocalVar24_g40 + ifLocalVar13_g40 + ifLocalVar12_g40 + ifLocalVar11_g40 + ifLocalVar17_g40 + ifLocalVar62_g40 + ifLocalVar154_g40 + ifLocalVar159_g40 + ifLocalVar165_g40 + ifLocalVar147_g40 );
				float ifLocalVar180_g40 = 0;
				if( Action0173_g40 == 0 )
				ifLocalVar180_g40 = Packed_Raw182_g40;
				float ifLocalVar171_g40 = 0;
				if( Action0173_g40 == 1 )
				ifLocalVar171_g40 = ( 1.0 - Packed_Raw182_g40 );
				float Packed_Action0185_g40 = saturate( ( ifLocalVar180_g40 + ifLocalVar171_g40 ) );
				float ifLocalVar193_g40 = 0;
				if( Action1187_g40 == 0 )
				ifLocalVar193_g40 = Packed_Action0185_g40;
				float ifLocalVar197_g40 = 0;
				if( Action1187_g40 == 1 )
				ifLocalVar197_g40 = ( Packed_Action0185_g40 * 0.0 );
				float ifLocalVar207_g40 = 0;
				if( Action1187_g40 == 2 )
				ifLocalVar207_g40 = ( Packed_Action0185_g40 * 2.0 );
				float ifLocalVar248_g40 = 0;
				if( Action1187_g40 == 3 )
				ifLocalVar248_g40 = ( Packed_Action0185_g40 * 3.0 );
				float ifLocalVar211_g40 = 0;
				if( Action1187_g40 == 5 )
				ifLocalVar211_g40 = ( Packed_Action0185_g40 * 5.0 );
				float Packed_Action1202_g40 = saturate( ( ifLocalVar193_g40 + ifLocalVar197_g40 + ifLocalVar207_g40 + ifLocalVar248_g40 + ifLocalVar211_g40 ) );
				float ifLocalVar220_g40 = 0;
				if( Action2189_g40 == 0 )
				ifLocalVar220_g40 = Packed_Action1202_g40;
				float ifLocalVar254_g40 = 0;
				if( Action2189_g40 == 1 )
				ifLocalVar254_g40 = pow( Packed_Action1202_g40 , 0.0 );
				float ifLocalVar225_g40 = 0;
				if( Action2189_g40 == 2 )
				ifLocalVar225_g40 = pow( Packed_Action1202_g40 , 2.0 );
				float ifLocalVar229_g40 = 0;
				if( Action2189_g40 == 3 )
				ifLocalVar229_g40 = pow( Packed_Action1202_g40 , 3.0 );
				float ifLocalVar234_g40 = 0;
				if( Action2189_g40 == 4 )
				ifLocalVar234_g40 = pow( Packed_Action1202_g40 , 4.0 );
				float Packed_Action2237_g40 = saturate( ( ifLocalVar220_g40 + ifLocalVar254_g40 + ifLocalVar225_g40 + ifLocalVar229_g40 + ifLocalVar234_g40 ) );
				float Packed_Final112_g40 = Packed_Action2237_g40;
				float ifLocalVar105_g40 = 0;
				if( Storage114_g40 == 0.0 )
				ifLocalVar105_g40 = Packed_Final112_g40;
				float value100_g40 = Packed_Final112_g40;
				float localGammaToLinearFloat100_g40 = GammaToLinearFloat100_g40( value100_g40 );
				float ifLocalVar93_g40 = 0;
				if( Storage114_g40 == 1.0 )
				ifLocalVar93_g40 = localGammaToLinearFloat100_g40;
				float value102_g40 = Packed_Final112_g40;
				float localLinearToGammaFloat102_g40 = LinearToGammaFloat102_g40( value102_g40 );
				float ifLocalVar107_g40 = 0;
				if( Storage114_g40 == 2.0 )
				ifLocalVar107_g40 = localLinearToGammaFloat102_g40;
				float G78 = ( ifLocalVar105_g40 + ifLocalVar93_g40 + ifLocalVar107_g40 );
				int Storage114_g42 = (int)_Packer_TexB_Storage;
				int Action2189_g42 = (int)_Packer_Action2B;
				int Action1187_g42 = (int)_Packer_Action1B;
				int Action0173_g42 = (int)_Packer_Action0B;
				int Channel31_g42 = (int)_Packer_ChannelB;
				float ifLocalVar24_g42 = 0;
				if( Channel31_g42 == 0 )
				ifLocalVar24_g42 = _Packer_FloatB;
				float2 uv_Packer_TexB57 = i.ase_texcoord1.xy;
				float4 break23_g42 = tex2Dlod( _Packer_TexB, float4( uv_Packer_TexB57, 0, 0.0) );
				float R39_g42 = break23_g42.r;
				float ifLocalVar13_g42 = 0;
				if( Channel31_g42 == 1 )
				ifLocalVar13_g42 = R39_g42;
				float G40_g42 = break23_g42.g;
				float ifLocalVar12_g42 = 0;
				if( Channel31_g42 == 2 )
				ifLocalVar12_g42 = G40_g42;
				float B41_g42 = break23_g42.b;
				float ifLocalVar11_g42 = 0;
				if( Channel31_g42 == 3 )
				ifLocalVar11_g42 = B41_g42;
				float A42_g42 = break23_g42.a;
				float ifLocalVar17_g42 = 0;
				if( Channel31_g42 == 4 )
				ifLocalVar17_g42 = A42_g42;
				float GRAY135_g42 = ( ( R39_g42 * 0.3 ) + ( G40_g42 * 0.59 ) + ( B41_g42 * 0.11 ) );
				float ifLocalVar62_g42 = 0;
				if( Channel31_g42 == 555 )
				ifLocalVar62_g42 = GRAY135_g42;
				float ifLocalVar154_g42 = 0;
				if( Channel31_g42 == 14 )
				ifLocalVar154_g42 = ( R39_g42 * A42_g42 );
				float ifLocalVar159_g42 = 0;
				if( Channel31_g42 == 24 )
				ifLocalVar159_g42 = ( G40_g42 * A42_g42 );
				float ifLocalVar165_g42 = 0;
				if( Channel31_g42 == 34 )
				ifLocalVar165_g42 = ( B41_g42 * A42_g42 );
				float ifLocalVar147_g42 = 0;
				if( Channel31_g42 == 5554 )
				ifLocalVar147_g42 = ( GRAY135_g42 * A42_g42 );
				float Packed_Raw182_g42 = ( ifLocalVar24_g42 + ifLocalVar13_g42 + ifLocalVar12_g42 + ifLocalVar11_g42 + ifLocalVar17_g42 + ifLocalVar62_g42 + ifLocalVar154_g42 + ifLocalVar159_g42 + ifLocalVar165_g42 + ifLocalVar147_g42 );
				float ifLocalVar180_g42 = 0;
				if( Action0173_g42 == 0 )
				ifLocalVar180_g42 = Packed_Raw182_g42;
				float ifLocalVar171_g42 = 0;
				if( Action0173_g42 == 1 )
				ifLocalVar171_g42 = ( 1.0 - Packed_Raw182_g42 );
				float Packed_Action0185_g42 = saturate( ( ifLocalVar180_g42 + ifLocalVar171_g42 ) );
				float ifLocalVar193_g42 = 0;
				if( Action1187_g42 == 0 )
				ifLocalVar193_g42 = Packed_Action0185_g42;
				float ifLocalVar197_g42 = 0;
				if( Action1187_g42 == 1 )
				ifLocalVar197_g42 = ( Packed_Action0185_g42 * 0.0 );
				float ifLocalVar207_g42 = 0;
				if( Action1187_g42 == 2 )
				ifLocalVar207_g42 = ( Packed_Action0185_g42 * 2.0 );
				float ifLocalVar248_g42 = 0;
				if( Action1187_g42 == 3 )
				ifLocalVar248_g42 = ( Packed_Action0185_g42 * 3.0 );
				float ifLocalVar211_g42 = 0;
				if( Action1187_g42 == 5 )
				ifLocalVar211_g42 = ( Packed_Action0185_g42 * 5.0 );
				float Packed_Action1202_g42 = saturate( ( ifLocalVar193_g42 + ifLocalVar197_g42 + ifLocalVar207_g42 + ifLocalVar248_g42 + ifLocalVar211_g42 ) );
				float ifLocalVar220_g42 = 0;
				if( Action2189_g42 == 0 )
				ifLocalVar220_g42 = Packed_Action1202_g42;
				float ifLocalVar254_g42 = 0;
				if( Action2189_g42 == 1 )
				ifLocalVar254_g42 = pow( Packed_Action1202_g42 , 0.0 );
				float ifLocalVar225_g42 = 0;
				if( Action2189_g42 == 2 )
				ifLocalVar225_g42 = pow( Packed_Action1202_g42 , 2.0 );
				float ifLocalVar229_g42 = 0;
				if( Action2189_g42 == 3 )
				ifLocalVar229_g42 = pow( Packed_Action1202_g42 , 3.0 );
				float ifLocalVar234_g42 = 0;
				if( Action2189_g42 == 4 )
				ifLocalVar234_g42 = pow( Packed_Action1202_g42 , 4.0 );
				float Packed_Action2237_g42 = saturate( ( ifLocalVar220_g42 + ifLocalVar254_g42 + ifLocalVar225_g42 + ifLocalVar229_g42 + ifLocalVar234_g42 ) );
				float Packed_Final112_g42 = Packed_Action2237_g42;
				float ifLocalVar105_g42 = 0;
				if( Storage114_g42 == 0.0 )
				ifLocalVar105_g42 = Packed_Final112_g42;
				float value100_g42 = Packed_Final112_g42;
				float localGammaToLinearFloat100_g42 = GammaToLinearFloat100_g42( value100_g42 );
				float ifLocalVar93_g42 = 0;
				if( Storage114_g42 == 1.0 )
				ifLocalVar93_g42 = localGammaToLinearFloat100_g42;
				float value102_g42 = Packed_Final112_g42;
				float localLinearToGammaFloat102_g42 = LinearToGammaFloat102_g42( value102_g42 );
				float ifLocalVar107_g42 = 0;
				if( Storage114_g42 == 2.0 )
				ifLocalVar107_g42 = localLinearToGammaFloat102_g42;
				float B79 = ( ifLocalVar105_g42 + ifLocalVar93_g42 + ifLocalVar107_g42 );
				int Storage114_g41 = (int)_Packer_TexA_Storage;
				int Action2189_g41 = (int)_Packer_Action2A;
				int Action1187_g41 = (int)_Packer_Action1A;
				int Action0173_g41 = (int)_Packer_Action0A;
				int Channel31_g41 = (int)_Packer_ChannelA;
				float ifLocalVar24_g41 = 0;
				if( Channel31_g41 == 0 )
				ifLocalVar24_g41 = _Packer_FloatA;
				float2 uv_Packer_TexA60 = i.ase_texcoord1.xy;
				float4 break23_g41 = tex2Dlod( _Packer_TexA, float4( uv_Packer_TexA60, 0, 0.0) );
				float R39_g41 = break23_g41.r;
				float ifLocalVar13_g41 = 0;
				if( Channel31_g41 == 1 )
				ifLocalVar13_g41 = R39_g41;
				float G40_g41 = break23_g41.g;
				float ifLocalVar12_g41 = 0;
				if( Channel31_g41 == 2 )
				ifLocalVar12_g41 = G40_g41;
				float B41_g41 = break23_g41.b;
				float ifLocalVar11_g41 = 0;
				if( Channel31_g41 == 3 )
				ifLocalVar11_g41 = B41_g41;
				float A42_g41 = break23_g41.a;
				float ifLocalVar17_g41 = 0;
				if( Channel31_g41 == 4 )
				ifLocalVar17_g41 = A42_g41;
				float GRAY135_g41 = ( ( R39_g41 * 0.3 ) + ( G40_g41 * 0.59 ) + ( B41_g41 * 0.11 ) );
				float ifLocalVar62_g41 = 0;
				if( Channel31_g41 == 555 )
				ifLocalVar62_g41 = GRAY135_g41;
				float ifLocalVar154_g41 = 0;
				if( Channel31_g41 == 14 )
				ifLocalVar154_g41 = ( R39_g41 * A42_g41 );
				float ifLocalVar159_g41 = 0;
				if( Channel31_g41 == 24 )
				ifLocalVar159_g41 = ( G40_g41 * A42_g41 );
				float ifLocalVar165_g41 = 0;
				if( Channel31_g41 == 34 )
				ifLocalVar165_g41 = ( B41_g41 * A42_g41 );
				float ifLocalVar147_g41 = 0;
				if( Channel31_g41 == 5554 )
				ifLocalVar147_g41 = ( GRAY135_g41 * A42_g41 );
				float Packed_Raw182_g41 = ( ifLocalVar24_g41 + ifLocalVar13_g41 + ifLocalVar12_g41 + ifLocalVar11_g41 + ifLocalVar17_g41 + ifLocalVar62_g41 + ifLocalVar154_g41 + ifLocalVar159_g41 + ifLocalVar165_g41 + ifLocalVar147_g41 );
				float ifLocalVar180_g41 = 0;
				if( Action0173_g41 == 0 )
				ifLocalVar180_g41 = Packed_Raw182_g41;
				float ifLocalVar171_g41 = 0;
				if( Action0173_g41 == 1 )
				ifLocalVar171_g41 = ( 1.0 - Packed_Raw182_g41 );
				float Packed_Action0185_g41 = saturate( ( ifLocalVar180_g41 + ifLocalVar171_g41 ) );
				float ifLocalVar193_g41 = 0;
				if( Action1187_g41 == 0 )
				ifLocalVar193_g41 = Packed_Action0185_g41;
				float ifLocalVar197_g41 = 0;
				if( Action1187_g41 == 1 )
				ifLocalVar197_g41 = ( Packed_Action0185_g41 * 0.0 );
				float ifLocalVar207_g41 = 0;
				if( Action1187_g41 == 2 )
				ifLocalVar207_g41 = ( Packed_Action0185_g41 * 2.0 );
				float ifLocalVar248_g41 = 0;
				if( Action1187_g41 == 3 )
				ifLocalVar248_g41 = ( Packed_Action0185_g41 * 3.0 );
				float ifLocalVar211_g41 = 0;
				if( Action1187_g41 == 5 )
				ifLocalVar211_g41 = ( Packed_Action0185_g41 * 5.0 );
				float Packed_Action1202_g41 = saturate( ( ifLocalVar193_g41 + ifLocalVar197_g41 + ifLocalVar207_g41 + ifLocalVar248_g41 + ifLocalVar211_g41 ) );
				float ifLocalVar220_g41 = 0;
				if( Action2189_g41 == 0 )
				ifLocalVar220_g41 = Packed_Action1202_g41;
				float ifLocalVar254_g41 = 0;
				if( Action2189_g41 == 1 )
				ifLocalVar254_g41 = pow( Packed_Action1202_g41 , 0.0 );
				float ifLocalVar225_g41 = 0;
				if( Action2189_g41 == 2 )
				ifLocalVar225_g41 = pow( Packed_Action1202_g41 , 2.0 );
				float ifLocalVar229_g41 = 0;
				if( Action2189_g41 == 3 )
				ifLocalVar229_g41 = pow( Packed_Action1202_g41 , 3.0 );
				float ifLocalVar234_g41 = 0;
				if( Action2189_g41 == 4 )
				ifLocalVar234_g41 = pow( Packed_Action1202_g41 , 4.0 );
				float Packed_Action2237_g41 = saturate( ( ifLocalVar220_g41 + ifLocalVar254_g41 + ifLocalVar225_g41 + ifLocalVar229_g41 + ifLocalVar234_g41 ) );
				float Packed_Final112_g41 = Packed_Action2237_g41;
				float ifLocalVar105_g41 = 0;
				if( Storage114_g41 == 0.0 )
				ifLocalVar105_g41 = Packed_Final112_g41;
				float value100_g41 = Packed_Final112_g41;
				float localGammaToLinearFloat100_g41 = GammaToLinearFloat100_g41( value100_g41 );
				float ifLocalVar93_g41 = 0;
				if( Storage114_g41 == 1.0 )
				ifLocalVar93_g41 = localGammaToLinearFloat100_g41;
				float value102_g41 = Packed_Final112_g41;
				float localLinearToGammaFloat102_g41 = LinearToGammaFloat102_g41( value102_g41 );
				float ifLocalVar107_g41 = 0;
				if( Storage114_g41 == 2.0 )
				ifLocalVar107_g41 = localLinearToGammaFloat102_g41;
				float A80 = ( ifLocalVar105_g41 + ifLocalVar93_g41 + ifLocalVar107_g41 );
				float4 appendResult48 = (float4(R74 , G78 , B79 , A80));
				
				
				finalColor = appendResult48;
				return finalColor;
			}
			ENDCG
		}
	}
	
	
	
}
/*ASEBEGIN
Version=18909
1920;0;1920;1029;-272.3829;237.3221;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;59;2176,192;Float;False;Property;_Packer_FloatB;Packer_FloatB;7;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-128,640;Float;False;Property;_Packer_TexR_Storage;Packer_TexR_Storage;25;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;292;3328,512;Float;False;Property;_Packer_Action2A;Packer_Action2A;18;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;3328,272;Float;False;Property;_Packer_ChannelA;Packer_ChannelA;24;1;[IntRange];Create;True;0;0;0;False;0;False;0;4;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;57;2176,0;Inherit;True;Property;_Packer_TexB;Packer_TexB;3;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;64;3328,192;Float;False;Property;_Packer_FloatA;Packer_FloatA;8;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;1024,272;Float;False;Property;_Packer_ChannelG;Packer_ChannelG;22;1;[IntRange];Create;True;0;0;0;False;0;False;0;2;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;26;-128,0;Inherit;True;Property;_Packer_TexR;Packer_TexR;1;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;50;1024,192;Float;False;Property;_Packer_FloatG;Packer_FloatG;6;0;Create;True;0;0;0;False;0;False;0;0.356;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-128,272;Float;False;Property;_Packer_ChannelR;Packer_ChannelR;21;1;[IntRange];Create;True;0;0;0;False;1;Space(10);False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;142;3328,640;Float;False;Property;_Packer_TexA_Storage;Packer_TexA_Storage;28;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;284;1024,384;Float;False;Property;_Packer_Action0G;Packer_Action0G;11;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-128,192;Float;False;Property;_Packer_FloatR;Packer_FloatR;5;0;Create;True;0;0;0;False;1;Space(10);False;0;0.519;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;287;2176,384;Float;False;Property;_Packer_Action0B;Packer_Action0B;9;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;51;1024,0;Inherit;True;Property;_Packer_TexG;Packer_TexG;2;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;286;1024,512;Float;False;Property;_Packer_Action2G;Packer_Action2G;16;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;257;-128,384;Float;False;Property;_Packer_Action0R;Packer_Action0R;19;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;282;-128,448;Float;False;Property;_Packer_Action1R;Packer_Action1R;14;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;283;-128,512;Float;False;Property;_Packer_Action2R;Packer_Action2R;13;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;140;2176,640;Float;False;Property;_Packer_TexB_Storage;Packer_TexB_Storage;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;138;1024,640;Float;False;Property;_Packer_TexG_Storage;Packer_TexG_Storage;26;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;288;2176,448;Float;False;Property;_Packer_Action1B;Packer_Action1B;10;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;289;2176,512;Float;False;Property;_Packer_Action2B;Packer_Action2B;12;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;290;3328,384;Float;False;Property;_Packer_Action0A;Packer_Action0A;15;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;291;3328,448;Float;False;Property;_Packer_Action1A;Packer_Action1A;20;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;285;1024,448;Float;False;Property;_Packer_Action1G;Packer_Action1G;17;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;60;3328,0;Inherit;True;Property;_Packer_TexA;Packer_TexA;4;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;67;2176,272;Float;False;Property;_Packer_ChannelB;Packer_ChannelB;23;1;[IntRange];Create;True;0;0;0;False;0;False;0;3;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;300;384,0;Inherit;False;Tool Packer;-1;;43;e76e01ea35349c34d9155714d95a561c;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;INT;0;False;172;INT;0;False;241;INT;0;False;242;INT;0;False;243;INT;0;False;56;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;299;2688,0;Inherit;False;Tool Packer;-1;;42;e76e01ea35349c34d9155714d95a561c;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;INT;0;False;172;INT;0;False;241;INT;0;False;242;INT;0;False;243;INT;0;False;56;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;297;1536,0;Inherit;False;Tool Packer;-1;;40;e76e01ea35349c34d9155714d95a561c;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;INT;0;False;172;INT;0;False;241;INT;0;False;242;INT;0;False;243;INT;0;False;56;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;298;3840,0;Inherit;False;Tool Packer;-1;;41;e76e01ea35349c34d9155714d95a561c;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;INT;0;False;172;INT;0;False;241;INT;0;False;242;INT;0;False;243;INT;0;False;56;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;80;4160,0;Float;False;A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;78;1856,0;Float;False;G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;79;3008,0;Float;False;B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;74;704,0;Float;False;R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;144;-128,976;Inherit;False;78;G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;143;-128,896;Inherit;False;74;R;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;145;-128,1136;Inherit;False;80;A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;146;-128,1056;Inherit;False;79;B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;155;4480,0;Inherit;True;Property;_MainTex;Dummy Texture;0;1;[HideInInspector];Create;False;0;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;48;128,896;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;320,896;Float;False;True;-1;2;;0;1;Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Packer;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;2;RenderType=Opaque=RenderType;PreviewType=Plane;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;300;19;26;0
WireConnection;300;25;47;0
WireConnection;300;10;65;0
WireConnection;300;172;257;0
WireConnection;300;241;282;0
WireConnection;300;242;283;0
WireConnection;300;56;72;0
WireConnection;299;19;57;0
WireConnection;299;25;59;0
WireConnection;299;10;67;0
WireConnection;299;172;287;0
WireConnection;299;241;288;0
WireConnection;299;242;289;0
WireConnection;299;56;140;0
WireConnection;297;19;51;0
WireConnection;297;25;50;0
WireConnection;297;10;66;0
WireConnection;297;172;284;0
WireConnection;297;241;285;0
WireConnection;297;242;286;0
WireConnection;297;56;138;0
WireConnection;298;19;60;0
WireConnection;298;25;64;0
WireConnection;298;10;68;0
WireConnection;298;172;290;0
WireConnection;298;241;291;0
WireConnection;298;242;292;0
WireConnection;298;56;142;0
WireConnection;80;0;298;0
WireConnection;78;0;297;0
WireConnection;79;0;299;0
WireConnection;74;0;300;0
WireConnection;48;0;143;0
WireConnection;48;1;144;0
WireConnection;48;2;146;0
WireConnection;48;3;145;0
WireConnection;0;0;48;0
ASEEND*/
//CHKSM=F13D091DE60FF7875DB2C0184B3707E992F5BE87