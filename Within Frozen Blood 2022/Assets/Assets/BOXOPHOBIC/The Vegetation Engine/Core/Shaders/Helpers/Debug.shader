// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Debug"
{
	Properties
	{
		[StyledBanner(Debug)]_Banner("Banner", Float) = 0
		_IsSimpleShader("IsSimpleShader", Float) = 0
		[HideInInspector]_IsTVEShader("_IsTVEShader", Float) = 0
		[HideInInspector]_IsTVEAIShader("_IsTVEAIShader", Float) = 0
		_IsStandardShader("IsStandardShader", Float) = 0
		_IsSubsurfaceShader("IsSubsurfaceShader", Float) = 0
		_IsPropShader("IsPropShader", Float) = 0
		_IsBarkShader("IsBarkShader", Float) = 0
		_IsGrassShader("IsGrassShader", Float) = 0
		_IsLeafShader("IsLeafShader", Float) = 0
		_IsCrossShader("IsCrossShader", Float) = 0
		[NoScaleOffset]_MainNormalTex("_MainNormalTex", 2D) = "black" {}
		[NoScaleOffset]_EmissiveTex("_EmissiveTex", 2D) = "black" {}
		[NoScaleOffset]_SecondMaskTex("_SecondMaskTex", 2D) = "black" {}
		[NoScaleOffset]_SecondNormalTex("_SecondNormalTex", 2D) = "black" {}
		[NoScaleOffset]_SecondAlbedoTex("_SecondAlbedoTex", 2D) = "black" {}
		[NoScaleOffset]_MainAlbedoTex("_MainAlbedoTex", 2D) = "black" {}
		[NoScaleOffset]_MainMaskTex("_MainMaskTex", 2D) = "black" {}
		_IsElementShader("_IsElementShader", Float) = 0
		_IsHelperShader("_IsHelperShader", Float) = 0
		_RenderClip("_RenderClip", Float) = 0
		_Cutoff("_Cutoff", Float) = 0
		_DetailMode("_DetailMode", Float) = 0
		[StyledEnum(Default _Layer 1 _Layer 2 _Layer 3 _Layer 4 _Layer 5 _Layer 6 _Layer 7 _Layer 8)]_LayerMotionValue("Layer Motion", Float) = 0
		_EmissiveCat("_EmissiveCat", Float) = 0
		[HDR]_EmissiveColor("_EmissiveColor", Color) = (0,0,0,0)
		[HideInInspector]_vertex_pivot_mode("_vertex_pivot_mode", Float) = 0
		[HideInInspector][Enum(Single Pivot,0,Baked Pivots,1)]_VertexPivotMode("_VertexPivotMode", Float) = 0
		[ASEEnd][StyledMessage(Info, Use this shader to debug the original mesh or the converted mesh attributes., 0,0)]_Message("Message", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25
		//[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		//[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}
	
	SubShader
	{
		
		Tags { "RenderType"="Opaque" "Queue"="Geometry" "DisableBatching"="True" }
	LOD 0

		Cull Off
		AlphaToMask Off
		ZWrite On
		ZTest LEqual
		ColorMask RGBA
		
		Blend Off
		

		CGINCLUDE
		#pragma target 4.0

		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}
		
		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		ENDCG

		
		Pass
		{
			
			Name "ForwardBase"
			Tags { "LightMode"="ForwardBase" }
			
			Blend One Zero

			CGPROGRAM
			#define ASE_NO_AMBIENT 1

			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			#ifndef UNITY_PASS_FORWARDBASE
				#define UNITY_PASS_FORWARDBASE
			#endif
			#include "HLSLSupport.cginc"
			#ifndef UNITY_INSTANCED_LOD_FADE
				#define UNITY_INSTANCED_LOD_FADE
			#endif
			#ifndef UNITY_INSTANCED_SH
				#define UNITY_INSTANCED_SH
			#endif
			#ifndef UNITY_INSTANCED_LIGHTMAPSTS
				#define UNITY_INSTANCED_LIGHTMAPSTS
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			#include "AutoLight.cginc"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
			#define SAMPLE_TEXTURE2D_ARRAY(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
			#else//ASE Sampling Macros
			#define SAMPLE_TEXTURE2D_ARRAY(tex,samplertex,coord) tex2DArray(tex,coord)
			#endif//ASE Sampling Macros
			

			struct appdata {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_color : COLOR;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f {
				#if UNITY_VERSION >= 201810
					UNITY_POSITION(pos);
				#else
					float4 pos : SV_POSITION;
				#endif
				#if defined(LIGHTMAP_ON) || (!defined(LIGHTMAP_ON) && SHADER_TARGET >= 30)
					float4 lmap : TEXCOORD0;
				#endif
				#if !defined(LIGHTMAP_ON) && UNITY_SHOULD_SAMPLE_SH
					half3 sh : TEXCOORD1;
				#endif
				#if defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS) && UNITY_VERSION >= 201810 && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					UNITY_LIGHTING_COORDS(2,3)
				#elif defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if UNITY_VERSION >= 201710
						UNITY_SHADOW_COORDS(2)
					#else
						SHADOW_COORDS(2)
					#endif
				#endif
				#ifdef ASE_FOG
					UNITY_FOG_COORDS(4)
				#endif
				float4 tSpace0 : TEXCOORD5;
				float4 tSpace1 : TEXCOORD6;
				float4 tSpace2 : TEXCOORD7;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 screenPos : TEXCOORD8;
				#endif
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			uniform half _Message;
			uniform half _Banner;
			uniform half _IsTVEShader;
			uniform float _IsSimpleShader;
			uniform half _IsTVEAIShader;
			uniform half TVE_DEBUG_Type;
			uniform float _IsBarkShader;
			uniform float _IsCrossShader;
			uniform float _IsGrassShader;
			uniform float _IsLeafShader;
			uniform float _IsPropShader;
			uniform float _IsStandardShader;
			uniform float _IsSubsurfaceShader;
			uniform half TVE_DEBUG_Index;
			uniform sampler2D _MainAlbedoTex;
			uniform float4 _MainAlbedoTex_ST;
			uniform sampler2D _MainNormalTex;
			uniform float4 _MainNormalTex_ST;
			uniform sampler2D _MainMaskTex;
			uniform float4 _MainMaskTex_ST;
			uniform sampler2D _SecondAlbedoTex;
			uniform float4 _SecondAlbedoTex_ST;
			uniform sampler2D _SecondNormalTex;
			uniform float4 _SecondNormalTex_ST;
			uniform sampler2D _SecondMaskTex;
			uniform float4 _SecondMaskTex_ST;
			uniform float _DetailMode;
			uniform sampler2D _EmissiveTex;
			uniform float4 _EmissiveTex_ST;
			uniform float4 _EmissiveColor;
			uniform float _EmissiveCat;
			uniform half TVE_DEBUG_Min;
			uniform half TVE_DEBUG_Max;
			float4 _MainAlbedoTex_TexelSize;
			float4 _MainNormalTex_TexelSize;
			float4 _MainMaskTex_TexelSize;
			float4 _SecondAlbedoTex_TexelSize;
			float4 _SecondMaskTex_TexelSize;
			float4 _EmissiveTex_TexelSize;
			uniform sampler2D TVE_NoiseTex;
			uniform half4 TVE_NoiseParams;
			uniform half4 TVE_MotionParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_MotionTex);
			uniform half4 TVE_MotionCoord;
			uniform half _vertex_pivot_mode;
			uniform half _VertexPivotMode;
			uniform half _LayerMotionValue;
			SamplerState samplerTVE_MotionTex;
			uniform float TVE_MotionUsage[9];
			uniform half4 TVE_ColorsParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ColorsTex);
			uniform half4 TVE_ColorsCoord;
			uniform half TVE_DEBUG_Layer;
			SamplerState samplerTVE_ColorsTex;
			uniform float TVE_ColorsUsage[9];
			uniform half4 TVE_ExtrasParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ExtrasTex);
			uniform half4 TVE_ExtrasCoord;
			SamplerState samplerTVE_ExtrasTex;
			uniform float TVE_ExtrasUsage[9];
			uniform half4 TVE_ReactParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ReactTex);
			uniform half4 TVE_ReactCoord;
			SamplerState samplerTVE_ReactTex;
			uniform float TVE_ReactUsage[9];
			uniform half TVE_DEBUG_Filter;
			uniform half TVE_DEBUG_Clip;
			uniform float _RenderClip;
			uniform float _Cutoff;
			uniform float _IsElementShader;
			uniform float _IsHelperShader;

	
			float3 HSVToRGB( float3 c )
			{
				float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
				float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
				return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
			}
			

			v2f VertexFunction (appdata v  ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 customSurfaceDepth676_g56456 = v.vertex.xyz;
				float customEye676_g56456 = -UnityObjectToViewPos( customSurfaceDepth676_g56456 ).z;
				o.ase_texcoord9.x = customEye676_g56456;
				float Debug_Index464_g56456 = TVE_DEBUG_Index;
				float3 ifLocalVar40_g56514 = 0;
				if( Debug_Index464_g56456 == 0.0 )
				ifLocalVar40_g56514 = saturate( v.vertex.xyz );
				float3 ifLocalVar40_g56519 = 0;
				if( Debug_Index464_g56456 == 1.0 )
				ifLocalVar40_g56519 = v.normal;
				float3 ifLocalVar40_g56518 = 0;
				if( Debug_Index464_g56456 == 2.0 )
				ifLocalVar40_g56518 = v.tangent.xyz;
				float ifLocalVar40_g56515 = 0;
				if( Debug_Index464_g56456 == 3.0 )
				ifLocalVar40_g56515 = saturate( v.tangent.w );
				float3 temp_cast_0 = (v.ase_color.r).xxx;
				float3 hsvTorgb260_g56456 = HSVToRGB( float3(v.ase_color.r,1.0,1.0) );
				float3 gammaToLinear266_g56456 = GammaToLinearSpace( hsvTorgb260_g56456 );
				float _IsBarkShader347_g56456 = _IsBarkShader;
				float _IsLeafShader360_g56456 = _IsLeafShader;
				float _IsCrossShader342_g56456 = _IsCrossShader;
				float _IsGrassShader341_g56456 = _IsGrassShader;
				float _IsVegetationShader362_g56456 = saturate( ( _IsBarkShader347_g56456 + _IsLeafShader360_g56456 + _IsCrossShader342_g56456 + _IsGrassShader341_g56456 ) );
				float3 lerpResult290_g56456 = lerp( temp_cast_0 , gammaToLinear266_g56456 , _IsVegetationShader362_g56456);
				float3 ifLocalVar40_g56497 = 0;
				if( Debug_Index464_g56456 == 4.0 )
				ifLocalVar40_g56497 = lerpResult290_g56456;
				float ifLocalVar40_g56500 = 0;
				if( Debug_Index464_g56456 == 5.0 )
				ifLocalVar40_g56500 = v.ase_color.g;
				float ifLocalVar40_g56507 = 0;
				if( Debug_Index464_g56456 == 6.0 )
				ifLocalVar40_g56507 = v.ase_color.b;
				float ifLocalVar40_g56494 = 0;
				if( Debug_Index464_g56456 == 7.0 )
				ifLocalVar40_g56494 = v.ase_color.a;
				float ifLocalVar40_g56476 = 0;
				if( Debug_Index464_g56456 == 8.0 )
				ifLocalVar40_g56476 = v.ase_texcoord3.x;
				float ifLocalVar40_g56513 = 0;
				if( Debug_Index464_g56456 == 9.0 )
				ifLocalVar40_g56513 = v.ase_texcoord3.y;
				float ifLocalVar40_g56503 = 0;
				if( Debug_Index464_g56456 == 10.0 )
				ifLocalVar40_g56503 = v.ase_texcoord3.z;
				float3 vertexToFrag328_g56456 = ( ( ifLocalVar40_g56514 + ifLocalVar40_g56519 + ifLocalVar40_g56518 + ifLocalVar40_g56515 ) + ( ifLocalVar40_g56497 + ifLocalVar40_g56500 + ifLocalVar40_g56507 + ifLocalVar40_g56494 ) + ( ifLocalVar40_g56476 + ifLocalVar40_g56513 + ifLocalVar40_g56503 ) );
				o.ase_texcoord9.yzw = vertexToFrag328_g56456;
				
				o.ase_texcoord10 = v.ase_texcoord;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.vertex.w = 1;
				v.normal = v.normal;
				v.tangent = v.tangent;

				o.pos = UnityObjectToClipPos(v.vertex);
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
				fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
				o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
				o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
				o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);

				#ifdef DYNAMICLIGHTMAP_ON
				o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif
				#ifdef LIGHTMAP_ON
				o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				#ifndef LIGHTMAP_ON
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						o.sh = 0;
						#ifdef VERTEXLIGHT_ON
						o.sh += Shade4PointLights (
							unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
							unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
							unity_4LightAtten0, worldPos, worldNormal);
						#endif
						o.sh = ShadeSHPerVertex (worldNormal, o.sh);
					#endif
				#endif

				#if UNITY_VERSION >= 201810 && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					UNITY_TRANSFER_LIGHTING(o, v.texcoord1.xy);
				#elif defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if UNITY_VERSION >= 201710
						UNITY_TRANSFER_SHADOW(o, v.texcoord1.xy);
					#else
						TRANSFER_SHADOW(o);
					#endif
				#endif

				#ifdef ASE_FOG
					UNITY_TRANSFER_FOG(o,o.pos);
				#endif
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
					o.screenPos = ComputeScreenPos(o.pos);
				#endif
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_color : COLOR;
				float4 ase_texcoord3 : TEXCOORD3;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( appdata v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.tangent = v.tangent;
				o.normal = v.normal;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_color = v.ase_color;
				o.ase_texcoord3 = v.ase_texcoord3;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				appdata o = (appdata) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.tangent = patch[0].tangent * bary.x + patch[1].tangent * bary.y + patch[2].tangent * bary.z;
				o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			v2f vert ( appdata v )
			{
				return VertexFunction( v );
			}
			#endif
			
			fixed4 frag (v2f IN 
				#ifdef _DEPTHOFFSET_ON
				, out float outputDepth : SV_Depth
				#endif
				) : SV_Target 
			{
				UNITY_SETUP_INSTANCE_ID(IN);

				#ifdef LOD_FADE_CROSSFADE
					UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
				#endif

				#if defined(_SPECULAR_SETUP)
					SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
				#else
					SurfaceOutputStandard o = (SurfaceOutputStandard)0;
				#endif
				float3 WorldTangent = float3(IN.tSpace0.x,IN.tSpace1.x,IN.tSpace2.x);
				float3 WorldBiTangent = float3(IN.tSpace0.y,IN.tSpace1.y,IN.tSpace2.y);
				float3 WorldNormal = float3(IN.tSpace0.z,IN.tSpace1.z,IN.tSpace2.z);
				float3 worldPos = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
				#else
					half atten = 1;
				#endif
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 ScreenPos = IN.screenPos;
				#endif

				float Debug_Type367_g56456 = TVE_DEBUG_Type;
				float4 color646_g56456 = IsGammaSpace() ? float4(0.9245283,0.7969696,0.4142933,1) : float4(0.8368256,0.5987038,0.1431069,1);
				float customEye676_g56456 = IN.ase_texcoord9.x;
				float saferPower688_g56456 = max( (0.0 + (customEye676_g56456 - 300.0) * (1.0 - 0.0) / (0.0 - 300.0)) , 0.0001 );
				float clampResult702_g56456 = clamp( pow( saferPower688_g56456 , 1.25 ) , 0.75 , 1.0 );
				float Shading655_g56456 = clampResult702_g56456;
				float4 Output_Converted717_g56456 = ( color646_g56456 * Shading655_g56456 );
				float4 ifLocalVar40_g56488 = 0;
				if( Debug_Type367_g56456 == 0.0 )
				ifLocalVar40_g56488 = Output_Converted717_g56456;
				float4 color466_g56456 = IsGammaSpace() ? float4(0.8113208,0.4952317,0.264062,0) : float4(0.6231937,0.2096542,0.05668841,0);
				float _IsBarkShader347_g56456 = _IsBarkShader;
				float4 color469_g56456 = IsGammaSpace() ? float4(0.6566009,0.3404236,0.8490566,0) : float4(0.3886527,0.09487338,0.6903409,0);
				float _IsCrossShader342_g56456 = _IsCrossShader;
				float4 color472_g56456 = IsGammaSpace() ? float4(0.7100264,0.8018868,0.2231666,0) : float4(0.4623997,0.6070304,0.0407874,0);
				float _IsGrassShader341_g56456 = _IsGrassShader;
				float4 color475_g56456 = IsGammaSpace() ? float4(0.3267961,0.7264151,0.3118103,0) : float4(0.08721471,0.4865309,0.07922345,0);
				float _IsLeafShader360_g56456 = _IsLeafShader;
				float4 color478_g56456 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsPropShader346_g56456 = _IsPropShader;
				float4 Output_Shader445_g56456 = ( ( ( color466_g56456 * _IsBarkShader347_g56456 ) + ( color469_g56456 * _IsCrossShader342_g56456 ) + ( color472_g56456 * _IsGrassShader341_g56456 ) + ( color475_g56456 * _IsLeafShader360_g56456 ) + ( color478_g56456 * _IsPropShader346_g56456 ) ) * Shading655_g56456 );
				float4 ifLocalVar40_g56477 = 0;
				if( Debug_Type367_g56456 == 1.0 )
				ifLocalVar40_g56477 = Output_Shader445_g56456;
				float4 color544_g56456 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsSimpleShader359_g56456 = _IsSimpleShader;
				float4 color521_g56456 = IsGammaSpace() ? float4(0.6566009,0.3404236,0.8490566,0) : float4(0.3886527,0.09487338,0.6903409,0);
				float _IsStandardShader344_g56456 = _IsStandardShader;
				float4 color529_g56456 = IsGammaSpace() ? float4(0.3267961,0.7264151,0.3118103,0) : float4(0.08721471,0.4865309,0.07922345,0);
				float _IsSubsurfaceShader548_g56456 = _IsSubsurfaceShader;
				float4 Output_Lighting525_g56456 = ( ( ( color544_g56456 * _IsSimpleShader359_g56456 ) + ( color521_g56456 * _IsStandardShader344_g56456 ) + ( color529_g56456 * _IsSubsurfaceShader548_g56456 ) ) * Shading655_g56456 );
				float4 ifLocalVar40_g56533 = 0;
				if( Debug_Type367_g56456 == 2.0 )
				ifLocalVar40_g56533 = Output_Lighting525_g56456;
				float Debug_Index464_g56456 = TVE_DEBUG_Index;
				float2 uv_MainAlbedoTex = IN.ase_texcoord10.xy * _MainAlbedoTex_ST.xy + _MainAlbedoTex_ST.zw;
				float4 tex2DNode586_g56456 = tex2D( _MainAlbedoTex, uv_MainAlbedoTex );
				float3 appendResult637_g56456 = (float3(tex2DNode586_g56456.r , tex2DNode586_g56456.g , tex2DNode586_g56456.b));
				float3 ifLocalVar40_g56469 = 0;
				if( Debug_Index464_g56456 == 0.0 )
				ifLocalVar40_g56469 = appendResult637_g56456;
				float ifLocalVar40_g56467 = 0;
				if( Debug_Index464_g56456 == 1.0 )
				ifLocalVar40_g56467 = tex2D( _MainAlbedoTex, uv_MainAlbedoTex ).a;
				float2 uv_MainNormalTex = IN.ase_texcoord10.xy * _MainNormalTex_ST.xy + _MainNormalTex_ST.zw;
				float4 tex2DNode604_g56456 = tex2D( _MainNormalTex, uv_MainNormalTex );
				float3 appendResult876_g56456 = (float3(tex2DNode604_g56456.a , tex2DNode604_g56456.g , 1.0));
				float3 gammaToLinear878_g56456 = GammaToLinearSpace( appendResult876_g56456 );
				float3 ifLocalVar40_g56504 = 0;
				if( Debug_Index464_g56456 == 2.0 )
				ifLocalVar40_g56504 = gammaToLinear878_g56456;
				float2 uv_MainMaskTex = IN.ase_texcoord10.xy * _MainMaskTex_ST.xy + _MainMaskTex_ST.zw;
				float ifLocalVar40_g56479 = 0;
				if( Debug_Index464_g56456 == 3.0 )
				ifLocalVar40_g56479 = tex2D( _MainMaskTex, uv_MainMaskTex ).r;
				float ifLocalVar40_g56463 = 0;
				if( Debug_Index464_g56456 == 4.0 )
				ifLocalVar40_g56463 = tex2D( _MainMaskTex, uv_MainMaskTex ).g;
				float ifLocalVar40_g56470 = 0;
				if( Debug_Index464_g56456 == 5.0 )
				ifLocalVar40_g56470 = tex2D( _MainMaskTex, uv_MainMaskTex ).b;
				float ifLocalVar40_g56487 = 0;
				if( Debug_Index464_g56456 == 6.0 )
				ifLocalVar40_g56487 = tex2D( _MainMaskTex, uv_MainMaskTex ).a;
				float2 uv_SecondAlbedoTex = IN.ase_texcoord10.xy * _SecondAlbedoTex_ST.xy + _SecondAlbedoTex_ST.zw;
				float4 tex2DNode854_g56456 = tex2D( _SecondAlbedoTex, uv_SecondAlbedoTex );
				float3 appendResult839_g56456 = (float3(tex2DNode854_g56456.r , tex2DNode854_g56456.g , tex2DNode854_g56456.b));
				float3 ifLocalVar40_g56502 = 0;
				if( Debug_Index464_g56456 == 7.0 )
				ifLocalVar40_g56502 = appendResult839_g56456;
				float ifLocalVar40_g56493 = 0;
				if( Debug_Index464_g56456 == 8.0 )
				ifLocalVar40_g56493 = tex2D( _SecondAlbedoTex, uv_SecondAlbedoTex ).a;
				float2 uv_SecondNormalTex = IN.ase_texcoord10.xy * _SecondNormalTex_ST.xy + _SecondNormalTex_ST.zw;
				float4 tex2DNode841_g56456 = tex2D( _SecondNormalTex, uv_SecondNormalTex );
				float3 appendResult880_g56456 = (float3(tex2DNode841_g56456.a , tex2DNode841_g56456.g , 1.0));
				float3 gammaToLinear879_g56456 = GammaToLinearSpace( appendResult880_g56456 );
				float3 ifLocalVar40_g56505 = 0;
				if( Debug_Index464_g56456 == 8.0 )
				ifLocalVar40_g56505 = gammaToLinear879_g56456;
				float2 uv_SecondMaskTex = IN.ase_texcoord10.xy * _SecondMaskTex_ST.xy + _SecondMaskTex_ST.zw;
				float ifLocalVar40_g56506 = 0;
				if( Debug_Index464_g56456 == 10.0 )
				ifLocalVar40_g56506 = tex2D( _SecondMaskTex, uv_SecondMaskTex ).r;
				float ifLocalVar40_g56485 = 0;
				if( Debug_Index464_g56456 == 11.0 )
				ifLocalVar40_g56485 = tex2D( _SecondMaskTex, uv_SecondMaskTex ).g;
				float ifLocalVar40_g56490 = 0;
				if( Debug_Index464_g56456 == 12.0 )
				ifLocalVar40_g56490 = tex2D( _SecondMaskTex, uv_SecondMaskTex ).b;
				float ifLocalVar40_g56511 = 0;
				if( Debug_Index464_g56456 == 13.0 )
				ifLocalVar40_g56511 = tex2D( _SecondMaskTex, uv_SecondMaskTex ).a;
				float2 uv_EmissiveTex = IN.ase_texcoord10.xy * _EmissiveTex_ST.xy + _EmissiveTex_ST.zw;
				float4 tex2DNode858_g56456 = tex2D( _EmissiveTex, uv_EmissiveTex );
				float3 appendResult867_g56456 = (float3(tex2DNode858_g56456.r , tex2DNode858_g56456.g , tex2DNode858_g56456.b));
				float3 ifLocalVar40_g56478 = 0;
				if( Debug_Index464_g56456 == 14.0 )
				ifLocalVar40_g56478 = appendResult867_g56456;
				float Debug_Min721_g56456 = TVE_DEBUG_Min;
				float temp_output_7_0_g56464 = Debug_Min721_g56456;
				float4 temp_cast_3 = (temp_output_7_0_g56464).xxxx;
				float Debug_Max723_g56456 = TVE_DEBUG_Max;
				float4 Output_Maps561_g56456 = ( ( ( float4( ( ( ifLocalVar40_g56469 + ifLocalVar40_g56467 + ifLocalVar40_g56504 ) + ( ifLocalVar40_g56479 + ifLocalVar40_g56463 + ifLocalVar40_g56470 + ifLocalVar40_g56487 ) ) , 0.0 ) + float4( ( ( ( ifLocalVar40_g56502 + ifLocalVar40_g56493 + ifLocalVar40_g56505 ) + ( ifLocalVar40_g56506 + ifLocalVar40_g56485 + ifLocalVar40_g56490 + ifLocalVar40_g56511 ) ) * _DetailMode ) , 0.0 ) + ( ( float4( ifLocalVar40_g56478 , 0.0 ) * _EmissiveColor ) * _EmissiveCat ) ) - temp_cast_3 ) / ( Debug_Max723_g56456 - temp_output_7_0_g56464 ) );
				float4 ifLocalVar40_g56495 = 0;
				if( Debug_Type367_g56456 == 3.0 )
				ifLocalVar40_g56495 = Output_Maps561_g56456;
				float Resolution44_g56499 = max( _MainAlbedoTex_TexelSize.z , _MainAlbedoTex_TexelSize.w );
				float4 color62_g56499 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g56499 = 0;
				if( Resolution44_g56499 <= 256.0 )
				ifLocalVar61_g56499 = color62_g56499;
				float4 color55_g56499 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g56499 = 0;
				if( Resolution44_g56499 == 512.0 )
				ifLocalVar56_g56499 = color55_g56499;
				float4 color42_g56499 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g56499 = 0;
				if( Resolution44_g56499 == 1024.0 )
				ifLocalVar40_g56499 = color42_g56499;
				float4 color48_g56499 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g56499 = 0;
				if( Resolution44_g56499 == 2048.0 )
				ifLocalVar47_g56499 = color48_g56499;
				float4 color51_g56499 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g56499 = 0;
				if( Resolution44_g56499 >= 4096.0 )
				ifLocalVar52_g56499 = color51_g56499;
				float4 ifLocalVar40_g56509 = 0;
				if( Debug_Index464_g56456 == 0.0 )
				ifLocalVar40_g56509 = ( ifLocalVar61_g56499 + ifLocalVar56_g56499 + ifLocalVar40_g56499 + ifLocalVar47_g56499 + ifLocalVar52_g56499 );
				float Resolution44_g56510 = max( _MainNormalTex_TexelSize.z , _MainNormalTex_TexelSize.w );
				float4 color62_g56510 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g56510 = 0;
				if( Resolution44_g56510 <= 256.0 )
				ifLocalVar61_g56510 = color62_g56510;
				float4 color55_g56510 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g56510 = 0;
				if( Resolution44_g56510 == 512.0 )
				ifLocalVar56_g56510 = color55_g56510;
				float4 color42_g56510 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g56510 = 0;
				if( Resolution44_g56510 == 1024.0 )
				ifLocalVar40_g56510 = color42_g56510;
				float4 color48_g56510 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g56510 = 0;
				if( Resolution44_g56510 == 2048.0 )
				ifLocalVar47_g56510 = color48_g56510;
				float4 color51_g56510 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g56510 = 0;
				if( Resolution44_g56510 >= 4096.0 )
				ifLocalVar52_g56510 = color51_g56510;
				float4 ifLocalVar40_g56483 = 0;
				if( Debug_Index464_g56456 == 1.0 )
				ifLocalVar40_g56483 = ( ifLocalVar61_g56510 + ifLocalVar56_g56510 + ifLocalVar40_g56510 + ifLocalVar47_g56510 + ifLocalVar52_g56510 );
				float Resolution44_g56480 = max( _MainMaskTex_TexelSize.z , _MainMaskTex_TexelSize.w );
				float4 color62_g56480 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g56480 = 0;
				if( Resolution44_g56480 <= 256.0 )
				ifLocalVar61_g56480 = color62_g56480;
				float4 color55_g56480 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g56480 = 0;
				if( Resolution44_g56480 == 512.0 )
				ifLocalVar56_g56480 = color55_g56480;
				float4 color42_g56480 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g56480 = 0;
				if( Resolution44_g56480 == 1024.0 )
				ifLocalVar40_g56480 = color42_g56480;
				float4 color48_g56480 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g56480 = 0;
				if( Resolution44_g56480 == 2048.0 )
				ifLocalVar47_g56480 = color48_g56480;
				float4 color51_g56480 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g56480 = 0;
				if( Resolution44_g56480 >= 4096.0 )
				ifLocalVar52_g56480 = color51_g56480;
				float4 ifLocalVar40_g56461 = 0;
				if( Debug_Index464_g56456 == 2.0 )
				ifLocalVar40_g56461 = ( ifLocalVar61_g56480 + ifLocalVar56_g56480 + ifLocalVar40_g56480 + ifLocalVar47_g56480 + ifLocalVar52_g56480 );
				float Resolution44_g56482 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g56482 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g56482 = 0;
				if( Resolution44_g56482 <= 256.0 )
				ifLocalVar61_g56482 = color62_g56482;
				float4 color55_g56482 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g56482 = 0;
				if( Resolution44_g56482 == 512.0 )
				ifLocalVar56_g56482 = color55_g56482;
				float4 color42_g56482 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g56482 = 0;
				if( Resolution44_g56482 == 1024.0 )
				ifLocalVar40_g56482 = color42_g56482;
				float4 color48_g56482 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g56482 = 0;
				if( Resolution44_g56482 == 2048.0 )
				ifLocalVar47_g56482 = color48_g56482;
				float4 color51_g56482 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g56482 = 0;
				if( Resolution44_g56482 >= 4096.0 )
				ifLocalVar52_g56482 = color51_g56482;
				float4 ifLocalVar40_g56501 = 0;
				if( Debug_Index464_g56456 == 3.0 )
				ifLocalVar40_g56501 = ( ifLocalVar61_g56482 + ifLocalVar56_g56482 + ifLocalVar40_g56482 + ifLocalVar47_g56482 + ifLocalVar52_g56482 );
				float Resolution44_g56462 = max( _SecondMaskTex_TexelSize.z , _SecondMaskTex_TexelSize.w );
				float4 color62_g56462 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g56462 = 0;
				if( Resolution44_g56462 <= 256.0 )
				ifLocalVar61_g56462 = color62_g56462;
				float4 color55_g56462 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g56462 = 0;
				if( Resolution44_g56462 == 512.0 )
				ifLocalVar56_g56462 = color55_g56462;
				float4 color42_g56462 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g56462 = 0;
				if( Resolution44_g56462 == 1024.0 )
				ifLocalVar40_g56462 = color42_g56462;
				float4 color48_g56462 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g56462 = 0;
				if( Resolution44_g56462 == 2048.0 )
				ifLocalVar47_g56462 = color48_g56462;
				float4 color51_g56462 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g56462 = 0;
				if( Resolution44_g56462 >= 4096.0 )
				ifLocalVar52_g56462 = color51_g56462;
				float4 ifLocalVar40_g56468 = 0;
				if( Debug_Index464_g56456 == 4.0 )
				ifLocalVar40_g56468 = ( ifLocalVar61_g56462 + ifLocalVar56_g56462 + ifLocalVar40_g56462 + ifLocalVar47_g56462 + ifLocalVar52_g56462 );
				float Resolution44_g56484 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g56484 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g56484 = 0;
				if( Resolution44_g56484 <= 256.0 )
				ifLocalVar61_g56484 = color62_g56484;
				float4 color55_g56484 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g56484 = 0;
				if( Resolution44_g56484 == 512.0 )
				ifLocalVar56_g56484 = color55_g56484;
				float4 color42_g56484 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g56484 = 0;
				if( Resolution44_g56484 == 1024.0 )
				ifLocalVar40_g56484 = color42_g56484;
				float4 color48_g56484 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g56484 = 0;
				if( Resolution44_g56484 == 2048.0 )
				ifLocalVar47_g56484 = color48_g56484;
				float4 color51_g56484 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g56484 = 0;
				if( Resolution44_g56484 >= 4096.0 )
				ifLocalVar52_g56484 = color51_g56484;
				float4 ifLocalVar40_g56481 = 0;
				if( Debug_Index464_g56456 == 5.0 )
				ifLocalVar40_g56481 = ( ifLocalVar61_g56484 + ifLocalVar56_g56484 + ifLocalVar40_g56484 + ifLocalVar47_g56484 + ifLocalVar52_g56484 );
				float Resolution44_g56486 = max( _EmissiveTex_TexelSize.z , _EmissiveTex_TexelSize.w );
				float4 color62_g56486 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g56486 = 0;
				if( Resolution44_g56486 <= 256.0 )
				ifLocalVar61_g56486 = color62_g56486;
				float4 color55_g56486 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g56486 = 0;
				if( Resolution44_g56486 == 512.0 )
				ifLocalVar56_g56486 = color55_g56486;
				float4 color42_g56486 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g56486 = 0;
				if( Resolution44_g56486 == 1024.0 )
				ifLocalVar40_g56486 = color42_g56486;
				float4 color48_g56486 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g56486 = 0;
				if( Resolution44_g56486 == 2048.0 )
				ifLocalVar47_g56486 = color48_g56486;
				float4 color51_g56486 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g56486 = 0;
				if( Resolution44_g56486 >= 4096.0 )
				ifLocalVar52_g56486 = color51_g56486;
				float4 ifLocalVar40_g56491 = 0;
				if( Debug_Index464_g56456 == 6.0 )
				ifLocalVar40_g56491 = ( ifLocalVar61_g56486 + ifLocalVar56_g56486 + ifLocalVar40_g56486 + ifLocalVar47_g56486 + ifLocalVar52_g56486 );
				float4 Output_Resolution737_g56456 = ( ( ifLocalVar40_g56509 + ifLocalVar40_g56483 + ifLocalVar40_g56461 ) + ( ifLocalVar40_g56501 + ifLocalVar40_g56468 + ifLocalVar40_g56481 ) + ifLocalVar40_g56491 );
				float4 ifLocalVar40_g56496 = 0;
				if( Debug_Type367_g56456 == 4.0 )
				ifLocalVar40_g56496 = Output_Resolution737_g56456;
				float3 vertexToFrag328_g56456 = IN.ase_texcoord9.yzw;
				float temp_output_7_0_g56498 = Debug_Min721_g56456;
				float3 temp_cast_4 = (temp_output_7_0_g56498).xxx;
				float3 Output_Mesh316_g56456 = saturate( ( ( vertexToFrag328_g56456 - temp_cast_4 ) / ( Debug_Max723_g56456 - temp_output_7_0_g56498 ) ) );
				float3 ifLocalVar40_g56489 = 0;
				if( Debug_Type367_g56456 == 9.0 )
				ifLocalVar40_g56489 = Output_Mesh316_g56456;
				float3 WorldPosition893_g56456 = worldPos;
				float2 panner73_g56459 = ( _Time.y * (TVE_NoiseParams).xy + ( (WorldPosition893_g56456).xz * TVE_NoiseParams.z ));
				float4 tex2DNode75_g56459 = tex2D( TVE_NoiseTex, panner73_g56459 );
				float4 saferPower77_g56459 = max( abs( tex2DNode75_g56459 ) , 0.0001 );
				float4x4 break19_g56471 = unity_ObjectToWorld;
				float3 appendResult20_g56471 = (float3(break19_g56471[ 0 ][ 3 ] , break19_g56471[ 1 ][ 3 ] , break19_g56471[ 2 ][ 3 ]));
				float3 appendResult60_g56473 = (float3(IN.ase_texcoord10.z , 0.0 , IN.ase_texcoord10.w));
				float3 temp_output_91_0_g56471 = ( appendResult60_g56473 * _vertex_pivot_mode );
				float3 PivotsOnly105_g56471 = (mul( unity_ObjectToWorld, float4( temp_output_91_0_g56471 , 0.0 ) ).xyz).xyz;
				half3 ObjectData20_g56472 = ( appendResult20_g56471 + PivotsOnly105_g56471 );
				half3 WorldData19_g56472 = worldPos;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g56472 = WorldData19_g56472;
				#else
				float3 staticSwitch14_g56472 = ObjectData20_g56472;
				#endif
				float3 temp_output_114_0_g56471 = staticSwitch14_g56472;
				half3 ObjectData20_g56475 = ( temp_output_114_0_g56471 * _VertexPivotMode );
				half3 WorldData19_g56475 = worldPos;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g56475 = WorldData19_g56475;
				#else
				float3 staticSwitch14_g56475 = ObjectData20_g56475;
				#endif
				float3 ObjectPosition890_g56456 = staticSwitch14_g56475;
				float3 Position83_g56474 = ObjectPosition890_g56456;
				float temp_output_84_0_g56474 = _LayerMotionValue;
				float4 lerpResult87_g56474 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY( TVE_MotionTex, samplerTVE_MotionTex, float3(( (TVE_MotionCoord).zw + ( (TVE_MotionCoord).xy * (Position83_g56474).xz ) ),temp_output_84_0_g56474) ) , TVE_MotionUsage[(int)temp_output_84_0_g56474]);
				float4 break322_g56465 = lerpResult87_g56474;
				half Wind_Power369_g56465 = break322_g56465.z;
				half Wind_Power911_g56456 = Wind_Power369_g56465;
				float temp_output_167_0_g56459 = Wind_Power911_g56456;
				float lerpResult168_g56459 = lerp( 1.4 , 0.2 , temp_output_167_0_g56459);
				float4 temp_cast_11 = (lerpResult168_g56459).xxxx;
				float4 break174_g56459 = pow( saferPower77_g56459 , temp_cast_11 );
				float ifLocalVar40_g56523 = 0;
				if( Debug_Index464_g56456 == 0.0 )
				ifLocalVar40_g56523 = break174_g56459.r;
				float2 panner73_g56458 = ( _Time.y * (TVE_NoiseParams).xy + ( (WorldPosition893_g56456).xz * TVE_NoiseParams.z ));
				float4 tex2DNode75_g56458 = tex2D( TVE_NoiseTex, panner73_g56458 );
				float temp_output_167_0_g56458 = Wind_Power911_g56456;
				float lerpResult169_g56458 = lerp( 4.0 , 2.0 , temp_output_167_0_g56458);
				float ifLocalVar40_g56522 = 0;
				if( Debug_Index464_g56456 == 1.0 )
				ifLocalVar40_g56522 = pow( abs( tex2DNode75_g56458.a ) , lerpResult169_g56458 );
				float3 Position58_g56460 = WorldPosition893_g56456;
				float Debug_Layer885_g56456 = TVE_DEBUG_Layer;
				float temp_output_82_0_g56460 = Debug_Layer885_g56456;
				float4 lerpResult88_g56460 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ColorsTex, samplerTVE_ColorsTex, float3(( (TVE_ColorsCoord).zw + ( (TVE_ColorsCoord).xy * (Position58_g56460).xz ) ),temp_output_82_0_g56460) ) , TVE_ColorsUsage[(int)temp_output_82_0_g56460]);
				float3 ifLocalVar40_g56521 = 0;
				if( Debug_Index464_g56456 == 2.0 )
				ifLocalVar40_g56521 = (lerpResult88_g56460).rgb;
				float3 Position58_g56457 = WorldPosition893_g56456;
				float temp_output_82_0_g56457 = Debug_Layer885_g56456;
				float4 lerpResult88_g56457 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ColorsTex, samplerTVE_ColorsTex, float3(( (TVE_ColorsCoord).zw + ( (TVE_ColorsCoord).xy * (Position58_g56457).xz ) ),temp_output_82_0_g56457) ) , TVE_ColorsUsage[(int)temp_output_82_0_g56457]);
				float ifLocalVar40_g56524 = 0;
				if( Debug_Index464_g56456 == 3.0 )
				ifLocalVar40_g56524 = (lerpResult88_g56457).a;
				float3 Position82_g56517 = WorldPosition893_g56456;
				float temp_output_84_0_g56517 = Debug_Layer885_g56456;
				float4 lerpResult88_g56517 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, float3(( (TVE_ExtrasCoord).zw + ( (TVE_ExtrasCoord).xy * (Position82_g56517).xz ) ),temp_output_84_0_g56517) ) , TVE_ExtrasUsage[(int)temp_output_84_0_g56517]);
				float4 break89_g56517 = lerpResult88_g56517;
				float ifLocalVar40_g56530 = 0;
				if( Debug_Index464_g56456 == 4.0 )
				ifLocalVar40_g56530 = break89_g56517.r;
				float3 Position82_g56516 = WorldPosition893_g56456;
				float temp_output_84_0_g56516 = Debug_Layer885_g56456;
				float4 lerpResult88_g56516 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, float3(( (TVE_ExtrasCoord).zw + ( (TVE_ExtrasCoord).xy * (Position82_g56516).xz ) ),temp_output_84_0_g56516) ) , TVE_ExtrasUsage[(int)temp_output_84_0_g56516]);
				float4 break89_g56516 = lerpResult88_g56516;
				float ifLocalVar40_g56525 = 0;
				if( Debug_Index464_g56456 == 5.0 )
				ifLocalVar40_g56525 = break89_g56516.g;
				float3 Position82_g56512 = WorldPosition893_g56456;
				float temp_output_84_0_g56512 = Debug_Layer885_g56456;
				float4 lerpResult88_g56512 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, float3(( (TVE_ExtrasCoord).zw + ( (TVE_ExtrasCoord).xy * (Position82_g56512).xz ) ),temp_output_84_0_g56512) ) , TVE_ExtrasUsage[(int)temp_output_84_0_g56512]);
				float4 break89_g56512 = lerpResult88_g56512;
				float ifLocalVar40_g56520 = 0;
				if( Debug_Index464_g56456 == 6.0 )
				ifLocalVar40_g56520 = break89_g56512.b;
				float3 Position82_g56526 = WorldPosition893_g56456;
				float temp_output_84_0_g56526 = Debug_Layer885_g56456;
				float4 lerpResult88_g56526 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, float3(( (TVE_ExtrasCoord).zw + ( (TVE_ExtrasCoord).xy * (Position82_g56526).xz ) ),temp_output_84_0_g56526) ) , TVE_ExtrasUsage[(int)temp_output_84_0_g56526]);
				float4 break89_g56526 = lerpResult88_g56526;
				float ifLocalVar40_g56528 = 0;
				if( Debug_Index464_g56456 == 7.0 )
				ifLocalVar40_g56528 = break89_g56526.a;
				float3 Position83_g56529 = WorldPosition893_g56456;
				float temp_output_84_0_g56529 = Debug_Layer885_g56456;
				float4 lerpResult87_g56529 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY( TVE_MotionTex, samplerTVE_MotionTex, float3(( (TVE_MotionCoord).zw + ( (TVE_MotionCoord).xy * (Position83_g56529).xz ) ),temp_output_84_0_g56529) ) , TVE_MotionUsage[(int)temp_output_84_0_g56529]);
				float3 appendResult1012_g56456 = (float3((lerpResult87_g56529).rg , 0.0));
				float3 ifLocalVar40_g56508 = 0;
				if( Debug_Index464_g56456 == 8.0 )
				ifLocalVar40_g56508 = appendResult1012_g56456;
				float3 Position83_g56531 = WorldPosition893_g56456;
				float temp_output_84_0_g56531 = Debug_Layer885_g56456;
				float4 lerpResult87_g56531 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY( TVE_MotionTex, samplerTVE_MotionTex, float3(( (TVE_MotionCoord).zw + ( (TVE_MotionCoord).xy * (Position83_g56531).xz ) ),temp_output_84_0_g56531) ) , TVE_MotionUsage[(int)temp_output_84_0_g56531]);
				float ifLocalVar40_g56527 = 0;
				if( Debug_Index464_g56456 == 9.0 )
				ifLocalVar40_g56527 = (lerpResult87_g56531).b;
				float3 Position83_g56534 = WorldPosition893_g56456;
				float temp_output_84_0_g56534 = Debug_Layer885_g56456;
				float4 lerpResult87_g56534 = lerp( TVE_ReactParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ReactTex, samplerTVE_ReactTex, float3(( (TVE_ReactCoord).zw + ( (TVE_ReactCoord).xy * (Position83_g56534).xz ) ),temp_output_84_0_g56534) ) , TVE_ReactUsage[(int)temp_output_84_0_g56534]);
				float3 appendResult1013_g56456 = (float3((lerpResult87_g56534).rg , 0.0));
				float3 ifLocalVar40_g56532 = 0;
				if( Debug_Index464_g56456 == 10.0 )
				ifLocalVar40_g56532 = appendResult1013_g56456;
				float3 Position83_g56535 = WorldPosition893_g56456;
				float temp_output_84_0_g56535 = Debug_Layer885_g56456;
				float4 lerpResult87_g56535 = lerp( TVE_ReactParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ReactTex, samplerTVE_ReactTex, float3(( (TVE_ReactCoord).zw + ( (TVE_ReactCoord).xy * (Position83_g56535).xz ) ),temp_output_84_0_g56535) ) , TVE_ReactUsage[(int)temp_output_84_0_g56535]);
				float ifLocalVar40_g56536 = 0;
				if( Debug_Index464_g56456 == 11.0 )
				ifLocalVar40_g56536 = (lerpResult87_g56535).b;
				float3 Position83_g56537 = WorldPosition893_g56456;
				float temp_output_84_0_g56537 = Debug_Layer885_g56456;
				float4 lerpResult87_g56537 = lerp( TVE_ReactParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ReactTex, samplerTVE_ReactTex, float3(( (TVE_ReactCoord).zw + ( (TVE_ReactCoord).xy * (Position83_g56537).xz ) ),temp_output_84_0_g56537) ) , TVE_ReactUsage[(int)temp_output_84_0_g56537]);
				float ifLocalVar40_g56538 = 0;
				if( Debug_Index464_g56456 == 12.0 )
				ifLocalVar40_g56538 = (lerpResult87_g56537).a;
				float3 Output_Globals888_g56456 = ( ( ifLocalVar40_g56523 + ifLocalVar40_g56522 ) + ( ifLocalVar40_g56521 + ifLocalVar40_g56524 ) + ( ifLocalVar40_g56530 + ifLocalVar40_g56525 + ifLocalVar40_g56520 + ifLocalVar40_g56528 ) + ( ifLocalVar40_g56508 + ifLocalVar40_g56527 ) + ( ifLocalVar40_g56532 + ifLocalVar40_g56536 + ifLocalVar40_g56538 ) );
				float3 ifLocalVar40_g56492 = 0;
				if( Debug_Type367_g56456 == 8.0 )
				ifLocalVar40_g56492 = Output_Globals888_g56456;
				float4 temp_output_459_0_g56456 = ( ifLocalVar40_g56488 + ifLocalVar40_g56477 + ifLocalVar40_g56533 + ifLocalVar40_g56495 + ifLocalVar40_g56496 + float4( ifLocalVar40_g56489 , 0.0 ) + float4( ifLocalVar40_g56492 , 0.0 ) );
				float4 color690_g56456 = IsGammaSpace() ? float4(0.1226415,0.1226415,0.1226415,0) : float4(0.01390275,0.01390275,0.01390275,0);
				float _IsTVEShader259_g56456 = _IsTVEShader;
				float _IsTVEAIShader645_g56456 = _IsTVEAIShader;
				float _IsAnyTVEShader647_g56456 = saturate( ( _IsTVEShader259_g56456 + _IsTVEAIShader645_g56456 ) );
				float4 lerpResult689_g56456 = lerp( color690_g56456 , temp_output_459_0_g56456 , _IsAnyTVEShader647_g56456);
				float Debug_Filter322_g56456 = TVE_DEBUG_Filter;
				float4 lerpResult326_g56456 = lerp( temp_output_459_0_g56456 , lerpResult689_g56456 , Debug_Filter322_g56456);
				float Debug_Clip623_g56456 = TVE_DEBUG_Clip;
				float lerpResult622_g56456 = lerp( 1.0 , tex2D( _MainAlbedoTex, uv_MainAlbedoTex ).a , ( Debug_Clip623_g56456 * _RenderClip ));
				clip( lerpResult622_g56456 - _Cutoff);
				clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
				
				o.Albedo = fixed3( 0.5, 0.5, 0.5 );
				o.Normal = fixed3( 0, 0, 1 );
				o.Emission = lerpResult326_g56456.rgb;
				#if defined(_SPECULAR_SETUP)
					o.Specular = fixed3( 0, 0, 0 );
				#else
					o.Metallic = 0;
				#endif
				o.Smoothness = 0;
				o.Occlusion = 1;
				o.Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;				

				#ifdef _ALPHATEST_ON
					clip( o.Alpha - AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
					outputDepth = IN.pos.z;
				#endif

				#ifndef USING_DIRECTIONAL_LIGHT
					fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
				#else
					fixed3 lightDir = _WorldSpaceLightPos0.xyz;
				#endif

				fixed4 c = 0;
				float3 worldN;
				worldN.x = dot(IN.tSpace0.xyz, o.Normal);
				worldN.y = dot(IN.tSpace1.xyz, o.Normal);
				worldN.z = dot(IN.tSpace2.xyz, o.Normal);
				worldN = normalize(worldN);
				o.Normal = worldN;

				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
				gi.indirect.diffuse = 0;
				gi.indirect.specular = 0;
				gi.light.color = _LightColor0.rgb;
				gi.light.dir = lightDir;

				UnityGIInput giInput;
				UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
				giInput.light = gi.light;
				giInput.worldPos = worldPos;
				giInput.worldViewDir = worldViewDir;
				giInput.atten = atten;
				#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
					giInput.lightmapUV = IN.lmap;
				#else
					giInput.lightmapUV = 0.0;
				#endif
				#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
					giInput.ambient = IN.sh;
				#else
					giInput.ambient.rgb = 0.0;
				#endif
				giInput.probeHDR[0] = unity_SpecCube0_HDR;
				giInput.probeHDR[1] = unity_SpecCube1_HDR;
				#if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
					giInput.boxMin[0] = unity_SpecCube0_BoxMin;
				#endif
				#ifdef UNITY_SPECCUBE_BOX_PROJECTION
					giInput.boxMax[0] = unity_SpecCube0_BoxMax;
					giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
					giInput.boxMax[1] = unity_SpecCube1_BoxMax;
					giInput.boxMin[1] = unity_SpecCube1_BoxMin;
					giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
				#endif
				
				#if defined(_SPECULAR_SETUP)
					LightingStandardSpecular_GI(o, giInput, gi);
				#else
					LightingStandard_GI( o, giInput, gi );
				#endif

				#ifdef ASE_BAKEDGI
					gi.indirect.diffuse = BakedGI;
				#endif

				#if UNITY_SHOULD_SAMPLE_SH && !defined(LIGHTMAP_ON) && defined(ASE_NO_AMBIENT)
					gi.indirect.diffuse = 0;
				#endif

				#if defined(_SPECULAR_SETUP)
					c += LightingStandardSpecular (o, worldViewDir, gi);
				#else
					c += LightingStandard( o, worldViewDir, gi );
				#endif
				
				#ifdef _TRANSMISSION_ASE
				{
					float shadow = _TransmissionShadow;
					#ifdef DIRECTIONAL
						float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, shadow );
					#else
						float3 lightAtten = gi.light.color;
					#endif
					half3 transmission = max(0 , -dot(o.Normal, gi.light.dir)) * lightAtten * Transmission;
					c.rgb += o.Albedo * transmission;
				}
				#endif

				#ifdef _TRANSLUCENCY_ASE
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;

					#ifdef DIRECTIONAL
						float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, shadow );
					#else
						float3 lightAtten = gi.light.color;
					#endif
					half3 lightDir = gi.light.dir + o.Normal * normal;
					half transVdotL = pow( saturate( dot( worldViewDir, -lightDir ) ), scattering );
					half3 translucency = lightAtten * (transVdotL * direct + gi.indirect.diffuse * ambient) * Translucency;
					c.rgb += o.Albedo * translucency * strength;
				}
				#endif

				//#ifdef _REFRACTION_ASE
				//	float4 projScreenPos = ScreenPos / ScreenPos.w;
				//	float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, WorldNormal ).xyz * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
				//	projScreenPos.xy += refractionOffset.xy;
				//	float3 refraction = UNITY_SAMPLE_SCREENSPACE_TEXTURE( _GrabTexture, projScreenPos ) * RefractionColor;
				//	color.rgb = lerp( refraction, color.rgb, color.a );
				//	color.a = 1;
				//#endif

				c.rgb += o.Emission;

				#ifdef ASE_FOG
					UNITY_APPLY_FOG(IN.fogCoord, c);
				#endif
				return c;
			}
			ENDCG
		}

		
		Pass
		{
			
			Name "Deferred"
			Tags { "LightMode"="Deferred" }

			AlphaToMask Off

			CGPROGRAM
			#define ASE_NO_AMBIENT 1

			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma exclude_renderers nomrt
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#pragma multi_compile_prepassfinal
			#ifndef UNITY_PASS_DEFERRED
				#define UNITY_PASS_DEFERRED
			#endif
			#include "HLSLSupport.cginc"
			#if !defined( UNITY_INSTANCED_LOD_FADE )
				#define UNITY_INSTANCED_LOD_FADE
			#endif
			#if !defined( UNITY_INSTANCED_SH )
				#define UNITY_INSTANCED_SH
			#endif
			#if !defined( UNITY_INSTANCED_LIGHTMAPSTS )
				#define UNITY_INSTANCED_LIGHTMAPSTS
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
			#define SAMPLE_TEXTURE2D_ARRAY(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
			#else//ASE Sampling Macros
			#define SAMPLE_TEXTURE2D_ARRAY(tex,samplertex,coord) tex2DArray(tex,coord)
			#endif//ASE Sampling Macros
			

			struct appdata {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_color : COLOR;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f {
				#if UNITY_VERSION >= 201810
					UNITY_POSITION(pos);
				#else
					float4 pos : SV_POSITION;
				#endif
				float4 lmap : TEXCOORD2;
				#ifndef LIGHTMAP_ON
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						half3 sh : TEXCOORD3;
					#endif
				#else
					#ifdef DIRLIGHTMAP_OFF
						float4 lmapFadePos : TEXCOORD4;
					#endif
				#endif
				float4 tSpace0 : TEXCOORD5;
				float4 tSpace1 : TEXCOORD6;
				float4 tSpace2 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			#ifdef LIGHTMAP_ON
			float4 unity_LightmapFade;
			#endif
			fixed4 unity_Ambient;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			uniform half _Message;
			uniform half _Banner;
			uniform half _IsTVEShader;
			uniform float _IsSimpleShader;
			uniform half _IsTVEAIShader;
			uniform half TVE_DEBUG_Type;
			uniform float _IsBarkShader;
			uniform float _IsCrossShader;
			uniform float _IsGrassShader;
			uniform float _IsLeafShader;
			uniform float _IsPropShader;
			uniform float _IsStandardShader;
			uniform float _IsSubsurfaceShader;
			uniform half TVE_DEBUG_Index;
			uniform sampler2D _MainAlbedoTex;
			uniform float4 _MainAlbedoTex_ST;
			uniform sampler2D _MainNormalTex;
			uniform float4 _MainNormalTex_ST;
			uniform sampler2D _MainMaskTex;
			uniform float4 _MainMaskTex_ST;
			uniform sampler2D _SecondAlbedoTex;
			uniform float4 _SecondAlbedoTex_ST;
			uniform sampler2D _SecondNormalTex;
			uniform float4 _SecondNormalTex_ST;
			uniform sampler2D _SecondMaskTex;
			uniform float4 _SecondMaskTex_ST;
			uniform float _DetailMode;
			uniform sampler2D _EmissiveTex;
			uniform float4 _EmissiveTex_ST;
			uniform float4 _EmissiveColor;
			uniform float _EmissiveCat;
			uniform half TVE_DEBUG_Min;
			uniform half TVE_DEBUG_Max;
			float4 _MainAlbedoTex_TexelSize;
			float4 _MainNormalTex_TexelSize;
			float4 _MainMaskTex_TexelSize;
			float4 _SecondAlbedoTex_TexelSize;
			float4 _SecondMaskTex_TexelSize;
			float4 _EmissiveTex_TexelSize;
			uniform sampler2D TVE_NoiseTex;
			uniform half4 TVE_NoiseParams;
			uniform half4 TVE_MotionParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_MotionTex);
			uniform half4 TVE_MotionCoord;
			uniform half _vertex_pivot_mode;
			uniform half _VertexPivotMode;
			uniform half _LayerMotionValue;
			SamplerState samplerTVE_MotionTex;
			uniform float TVE_MotionUsage[9];
			uniform half4 TVE_ColorsParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ColorsTex);
			uniform half4 TVE_ColorsCoord;
			uniform half TVE_DEBUG_Layer;
			SamplerState samplerTVE_ColorsTex;
			uniform float TVE_ColorsUsage[9];
			uniform half4 TVE_ExtrasParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ExtrasTex);
			uniform half4 TVE_ExtrasCoord;
			SamplerState samplerTVE_ExtrasTex;
			uniform float TVE_ExtrasUsage[9];
			uniform half4 TVE_ReactParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ReactTex);
			uniform half4 TVE_ReactCoord;
			SamplerState samplerTVE_ReactTex;
			uniform float TVE_ReactUsage[9];
			uniform half TVE_DEBUG_Filter;
			uniform half TVE_DEBUG_Clip;
			uniform float _RenderClip;
			uniform float _Cutoff;
			uniform float _IsElementShader;
			uniform float _IsHelperShader;

	
			float3 HSVToRGB( float3 c )
			{
				float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
				float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
				return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
			}
			

			v2f VertexFunction (appdata v  ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 customSurfaceDepth676_g56456 = v.vertex.xyz;
				float customEye676_g56456 = -UnityObjectToViewPos( customSurfaceDepth676_g56456 ).z;
				o.ase_texcoord8.x = customEye676_g56456;
				float Debug_Index464_g56456 = TVE_DEBUG_Index;
				float3 ifLocalVar40_g56514 = 0;
				if( Debug_Index464_g56456 == 0.0 )
				ifLocalVar40_g56514 = saturate( v.vertex.xyz );
				float3 ifLocalVar40_g56519 = 0;
				if( Debug_Index464_g56456 == 1.0 )
				ifLocalVar40_g56519 = v.normal;
				float3 ifLocalVar40_g56518 = 0;
				if( Debug_Index464_g56456 == 2.0 )
				ifLocalVar40_g56518 = v.tangent.xyz;
				float ifLocalVar40_g56515 = 0;
				if( Debug_Index464_g56456 == 3.0 )
				ifLocalVar40_g56515 = saturate( v.tangent.w );
				float3 temp_cast_0 = (v.ase_color.r).xxx;
				float3 hsvTorgb260_g56456 = HSVToRGB( float3(v.ase_color.r,1.0,1.0) );
				float3 gammaToLinear266_g56456 = GammaToLinearSpace( hsvTorgb260_g56456 );
				float _IsBarkShader347_g56456 = _IsBarkShader;
				float _IsLeafShader360_g56456 = _IsLeafShader;
				float _IsCrossShader342_g56456 = _IsCrossShader;
				float _IsGrassShader341_g56456 = _IsGrassShader;
				float _IsVegetationShader362_g56456 = saturate( ( _IsBarkShader347_g56456 + _IsLeafShader360_g56456 + _IsCrossShader342_g56456 + _IsGrassShader341_g56456 ) );
				float3 lerpResult290_g56456 = lerp( temp_cast_0 , gammaToLinear266_g56456 , _IsVegetationShader362_g56456);
				float3 ifLocalVar40_g56497 = 0;
				if( Debug_Index464_g56456 == 4.0 )
				ifLocalVar40_g56497 = lerpResult290_g56456;
				float ifLocalVar40_g56500 = 0;
				if( Debug_Index464_g56456 == 5.0 )
				ifLocalVar40_g56500 = v.ase_color.g;
				float ifLocalVar40_g56507 = 0;
				if( Debug_Index464_g56456 == 6.0 )
				ifLocalVar40_g56507 = v.ase_color.b;
				float ifLocalVar40_g56494 = 0;
				if( Debug_Index464_g56456 == 7.0 )
				ifLocalVar40_g56494 = v.ase_color.a;
				float ifLocalVar40_g56476 = 0;
				if( Debug_Index464_g56456 == 8.0 )
				ifLocalVar40_g56476 = v.ase_texcoord3.x;
				float ifLocalVar40_g56513 = 0;
				if( Debug_Index464_g56456 == 9.0 )
				ifLocalVar40_g56513 = v.ase_texcoord3.y;
				float ifLocalVar40_g56503 = 0;
				if( Debug_Index464_g56456 == 10.0 )
				ifLocalVar40_g56503 = v.ase_texcoord3.z;
				float3 vertexToFrag328_g56456 = ( ( ifLocalVar40_g56514 + ifLocalVar40_g56519 + ifLocalVar40_g56518 + ifLocalVar40_g56515 ) + ( ifLocalVar40_g56497 + ifLocalVar40_g56500 + ifLocalVar40_g56507 + ifLocalVar40_g56494 ) + ( ifLocalVar40_g56476 + ifLocalVar40_g56513 + ifLocalVar40_g56503 ) );
				o.ase_texcoord8.yzw = vertexToFrag328_g56456;
				
				o.ase_texcoord9 = v.ase_texcoord;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.vertex.w = 1;
				v.normal = v.normal;
				v.tangent = v.tangent;

				o.pos = UnityObjectToClipPos(v.vertex);
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
				fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
				o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
				o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
				o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);

				#ifdef DYNAMICLIGHTMAP_ON
					o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#else
					o.lmap.zw = 0;
				#endif
				#ifdef LIGHTMAP_ON
					o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#ifdef DIRLIGHTMAP_OFF
						o.lmapFadePos.xyz = (mul(unity_ObjectToWorld, v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w;
						o.lmapFadePos.w = (-UnityObjectToViewPos(v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w);
					#endif
				#else
					o.lmap.xy = 0;
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						o.sh = 0;
						o.sh = ShadeSHPerVertex (worldNormal, o.sh);
					#endif
				#endif
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_color : COLOR;
				float4 ase_texcoord3 : TEXCOORD3;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( appdata v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.tangent = v.tangent;
				o.normal = v.normal;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_color = v.ase_color;
				o.ase_texcoord3 = v.ase_texcoord3;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				appdata o = (appdata) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.tangent = patch[0].tangent * bary.x + patch[1].tangent * bary.y + patch[2].tangent * bary.z;
				o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			v2f vert ( appdata v )
			{
				return VertexFunction( v );
			}
			#endif

			void frag (v2f IN 
				, out half4 outGBuffer0 : SV_Target0
				, out half4 outGBuffer1 : SV_Target1
				, out half4 outGBuffer2 : SV_Target2
				, out half4 outEmission : SV_Target3
				#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
				, out half4 outShadowMask : SV_Target4
				#endif
				#ifdef _DEPTHOFFSET_ON
				, out float outputDepth : SV_Depth
				#endif
			) 
			{
				UNITY_SETUP_INSTANCE_ID(IN);

				#ifdef LOD_FADE_CROSSFADE
					UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
				#endif

				#if defined(_SPECULAR_SETUP)
					SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
				#else
					SurfaceOutputStandard o = (SurfaceOutputStandard)0;
				#endif
				float3 WorldTangent = float3(IN.tSpace0.x,IN.tSpace1.x,IN.tSpace2.x);
				float3 WorldBiTangent = float3(IN.tSpace0.y,IN.tSpace1.y,IN.tSpace2.y);
				float3 WorldNormal = float3(IN.tSpace0.z,IN.tSpace1.z,IN.tSpace2.z);
				float3 worldPos = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
				half atten = 1;

				float Debug_Type367_g56456 = TVE_DEBUG_Type;
				float4 color646_g56456 = IsGammaSpace() ? float4(0.9245283,0.7969696,0.4142933,1) : float4(0.8368256,0.5987038,0.1431069,1);
				float customEye676_g56456 = IN.ase_texcoord8.x;
				float saferPower688_g56456 = max( (0.0 + (customEye676_g56456 - 300.0) * (1.0 - 0.0) / (0.0 - 300.0)) , 0.0001 );
				float clampResult702_g56456 = clamp( pow( saferPower688_g56456 , 1.25 ) , 0.75 , 1.0 );
				float Shading655_g56456 = clampResult702_g56456;
				float4 Output_Converted717_g56456 = ( color646_g56456 * Shading655_g56456 );
				float4 ifLocalVar40_g56488 = 0;
				if( Debug_Type367_g56456 == 0.0 )
				ifLocalVar40_g56488 = Output_Converted717_g56456;
				float4 color466_g56456 = IsGammaSpace() ? float4(0.8113208,0.4952317,0.264062,0) : float4(0.6231937,0.2096542,0.05668841,0);
				float _IsBarkShader347_g56456 = _IsBarkShader;
				float4 color469_g56456 = IsGammaSpace() ? float4(0.6566009,0.3404236,0.8490566,0) : float4(0.3886527,0.09487338,0.6903409,0);
				float _IsCrossShader342_g56456 = _IsCrossShader;
				float4 color472_g56456 = IsGammaSpace() ? float4(0.7100264,0.8018868,0.2231666,0) : float4(0.4623997,0.6070304,0.0407874,0);
				float _IsGrassShader341_g56456 = _IsGrassShader;
				float4 color475_g56456 = IsGammaSpace() ? float4(0.3267961,0.7264151,0.3118103,0) : float4(0.08721471,0.4865309,0.07922345,0);
				float _IsLeafShader360_g56456 = _IsLeafShader;
				float4 color478_g56456 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsPropShader346_g56456 = _IsPropShader;
				float4 Output_Shader445_g56456 = ( ( ( color466_g56456 * _IsBarkShader347_g56456 ) + ( color469_g56456 * _IsCrossShader342_g56456 ) + ( color472_g56456 * _IsGrassShader341_g56456 ) + ( color475_g56456 * _IsLeafShader360_g56456 ) + ( color478_g56456 * _IsPropShader346_g56456 ) ) * Shading655_g56456 );
				float4 ifLocalVar40_g56477 = 0;
				if( Debug_Type367_g56456 == 1.0 )
				ifLocalVar40_g56477 = Output_Shader445_g56456;
				float4 color544_g56456 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsSimpleShader359_g56456 = _IsSimpleShader;
				float4 color521_g56456 = IsGammaSpace() ? float4(0.6566009,0.3404236,0.8490566,0) : float4(0.3886527,0.09487338,0.6903409,0);
				float _IsStandardShader344_g56456 = _IsStandardShader;
				float4 color529_g56456 = IsGammaSpace() ? float4(0.3267961,0.7264151,0.3118103,0) : float4(0.08721471,0.4865309,0.07922345,0);
				float _IsSubsurfaceShader548_g56456 = _IsSubsurfaceShader;
				float4 Output_Lighting525_g56456 = ( ( ( color544_g56456 * _IsSimpleShader359_g56456 ) + ( color521_g56456 * _IsStandardShader344_g56456 ) + ( color529_g56456 * _IsSubsurfaceShader548_g56456 ) ) * Shading655_g56456 );
				float4 ifLocalVar40_g56533 = 0;
				if( Debug_Type367_g56456 == 2.0 )
				ifLocalVar40_g56533 = Output_Lighting525_g56456;
				float Debug_Index464_g56456 = TVE_DEBUG_Index;
				float2 uv_MainAlbedoTex = IN.ase_texcoord9.xy * _MainAlbedoTex_ST.xy + _MainAlbedoTex_ST.zw;
				float4 tex2DNode586_g56456 = tex2D( _MainAlbedoTex, uv_MainAlbedoTex );
				float3 appendResult637_g56456 = (float3(tex2DNode586_g56456.r , tex2DNode586_g56456.g , tex2DNode586_g56456.b));
				float3 ifLocalVar40_g56469 = 0;
				if( Debug_Index464_g56456 == 0.0 )
				ifLocalVar40_g56469 = appendResult637_g56456;
				float ifLocalVar40_g56467 = 0;
				if( Debug_Index464_g56456 == 1.0 )
				ifLocalVar40_g56467 = tex2D( _MainAlbedoTex, uv_MainAlbedoTex ).a;
				float2 uv_MainNormalTex = IN.ase_texcoord9.xy * _MainNormalTex_ST.xy + _MainNormalTex_ST.zw;
				float4 tex2DNode604_g56456 = tex2D( _MainNormalTex, uv_MainNormalTex );
				float3 appendResult876_g56456 = (float3(tex2DNode604_g56456.a , tex2DNode604_g56456.g , 1.0));
				float3 gammaToLinear878_g56456 = GammaToLinearSpace( appendResult876_g56456 );
				float3 ifLocalVar40_g56504 = 0;
				if( Debug_Index464_g56456 == 2.0 )
				ifLocalVar40_g56504 = gammaToLinear878_g56456;
				float2 uv_MainMaskTex = IN.ase_texcoord9.xy * _MainMaskTex_ST.xy + _MainMaskTex_ST.zw;
				float ifLocalVar40_g56479 = 0;
				if( Debug_Index464_g56456 == 3.0 )
				ifLocalVar40_g56479 = tex2D( _MainMaskTex, uv_MainMaskTex ).r;
				float ifLocalVar40_g56463 = 0;
				if( Debug_Index464_g56456 == 4.0 )
				ifLocalVar40_g56463 = tex2D( _MainMaskTex, uv_MainMaskTex ).g;
				float ifLocalVar40_g56470 = 0;
				if( Debug_Index464_g56456 == 5.0 )
				ifLocalVar40_g56470 = tex2D( _MainMaskTex, uv_MainMaskTex ).b;
				float ifLocalVar40_g56487 = 0;
				if( Debug_Index464_g56456 == 6.0 )
				ifLocalVar40_g56487 = tex2D( _MainMaskTex, uv_MainMaskTex ).a;
				float2 uv_SecondAlbedoTex = IN.ase_texcoord9.xy * _SecondAlbedoTex_ST.xy + _SecondAlbedoTex_ST.zw;
				float4 tex2DNode854_g56456 = tex2D( _SecondAlbedoTex, uv_SecondAlbedoTex );
				float3 appendResult839_g56456 = (float3(tex2DNode854_g56456.r , tex2DNode854_g56456.g , tex2DNode854_g56456.b));
				float3 ifLocalVar40_g56502 = 0;
				if( Debug_Index464_g56456 == 7.0 )
				ifLocalVar40_g56502 = appendResult839_g56456;
				float ifLocalVar40_g56493 = 0;
				if( Debug_Index464_g56456 == 8.0 )
				ifLocalVar40_g56493 = tex2D( _SecondAlbedoTex, uv_SecondAlbedoTex ).a;
				float2 uv_SecondNormalTex = IN.ase_texcoord9.xy * _SecondNormalTex_ST.xy + _SecondNormalTex_ST.zw;
				float4 tex2DNode841_g56456 = tex2D( _SecondNormalTex, uv_SecondNormalTex );
				float3 appendResult880_g56456 = (float3(tex2DNode841_g56456.a , tex2DNode841_g56456.g , 1.0));
				float3 gammaToLinear879_g56456 = GammaToLinearSpace( appendResult880_g56456 );
				float3 ifLocalVar40_g56505 = 0;
				if( Debug_Index464_g56456 == 8.0 )
				ifLocalVar40_g56505 = gammaToLinear879_g56456;
				float2 uv_SecondMaskTex = IN.ase_texcoord9.xy * _SecondMaskTex_ST.xy + _SecondMaskTex_ST.zw;
				float ifLocalVar40_g56506 = 0;
				if( Debug_Index464_g56456 == 10.0 )
				ifLocalVar40_g56506 = tex2D( _SecondMaskTex, uv_SecondMaskTex ).r;
				float ifLocalVar40_g56485 = 0;
				if( Debug_Index464_g56456 == 11.0 )
				ifLocalVar40_g56485 = tex2D( _SecondMaskTex, uv_SecondMaskTex ).g;
				float ifLocalVar40_g56490 = 0;
				if( Debug_Index464_g56456 == 12.0 )
				ifLocalVar40_g56490 = tex2D( _SecondMaskTex, uv_SecondMaskTex ).b;
				float ifLocalVar40_g56511 = 0;
				if( Debug_Index464_g56456 == 13.0 )
				ifLocalVar40_g56511 = tex2D( _SecondMaskTex, uv_SecondMaskTex ).a;
				float2 uv_EmissiveTex = IN.ase_texcoord9.xy * _EmissiveTex_ST.xy + _EmissiveTex_ST.zw;
				float4 tex2DNode858_g56456 = tex2D( _EmissiveTex, uv_EmissiveTex );
				float3 appendResult867_g56456 = (float3(tex2DNode858_g56456.r , tex2DNode858_g56456.g , tex2DNode858_g56456.b));
				float3 ifLocalVar40_g56478 = 0;
				if( Debug_Index464_g56456 == 14.0 )
				ifLocalVar40_g56478 = appendResult867_g56456;
				float Debug_Min721_g56456 = TVE_DEBUG_Min;
				float temp_output_7_0_g56464 = Debug_Min721_g56456;
				float4 temp_cast_3 = (temp_output_7_0_g56464).xxxx;
				float Debug_Max723_g56456 = TVE_DEBUG_Max;
				float4 Output_Maps561_g56456 = ( ( ( float4( ( ( ifLocalVar40_g56469 + ifLocalVar40_g56467 + ifLocalVar40_g56504 ) + ( ifLocalVar40_g56479 + ifLocalVar40_g56463 + ifLocalVar40_g56470 + ifLocalVar40_g56487 ) ) , 0.0 ) + float4( ( ( ( ifLocalVar40_g56502 + ifLocalVar40_g56493 + ifLocalVar40_g56505 ) + ( ifLocalVar40_g56506 + ifLocalVar40_g56485 + ifLocalVar40_g56490 + ifLocalVar40_g56511 ) ) * _DetailMode ) , 0.0 ) + ( ( float4( ifLocalVar40_g56478 , 0.0 ) * _EmissiveColor ) * _EmissiveCat ) ) - temp_cast_3 ) / ( Debug_Max723_g56456 - temp_output_7_0_g56464 ) );
				float4 ifLocalVar40_g56495 = 0;
				if( Debug_Type367_g56456 == 3.0 )
				ifLocalVar40_g56495 = Output_Maps561_g56456;
				float Resolution44_g56499 = max( _MainAlbedoTex_TexelSize.z , _MainAlbedoTex_TexelSize.w );
				float4 color62_g56499 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g56499 = 0;
				if( Resolution44_g56499 <= 256.0 )
				ifLocalVar61_g56499 = color62_g56499;
				float4 color55_g56499 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g56499 = 0;
				if( Resolution44_g56499 == 512.0 )
				ifLocalVar56_g56499 = color55_g56499;
				float4 color42_g56499 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g56499 = 0;
				if( Resolution44_g56499 == 1024.0 )
				ifLocalVar40_g56499 = color42_g56499;
				float4 color48_g56499 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g56499 = 0;
				if( Resolution44_g56499 == 2048.0 )
				ifLocalVar47_g56499 = color48_g56499;
				float4 color51_g56499 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g56499 = 0;
				if( Resolution44_g56499 >= 4096.0 )
				ifLocalVar52_g56499 = color51_g56499;
				float4 ifLocalVar40_g56509 = 0;
				if( Debug_Index464_g56456 == 0.0 )
				ifLocalVar40_g56509 = ( ifLocalVar61_g56499 + ifLocalVar56_g56499 + ifLocalVar40_g56499 + ifLocalVar47_g56499 + ifLocalVar52_g56499 );
				float Resolution44_g56510 = max( _MainNormalTex_TexelSize.z , _MainNormalTex_TexelSize.w );
				float4 color62_g56510 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g56510 = 0;
				if( Resolution44_g56510 <= 256.0 )
				ifLocalVar61_g56510 = color62_g56510;
				float4 color55_g56510 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g56510 = 0;
				if( Resolution44_g56510 == 512.0 )
				ifLocalVar56_g56510 = color55_g56510;
				float4 color42_g56510 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g56510 = 0;
				if( Resolution44_g56510 == 1024.0 )
				ifLocalVar40_g56510 = color42_g56510;
				float4 color48_g56510 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g56510 = 0;
				if( Resolution44_g56510 == 2048.0 )
				ifLocalVar47_g56510 = color48_g56510;
				float4 color51_g56510 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g56510 = 0;
				if( Resolution44_g56510 >= 4096.0 )
				ifLocalVar52_g56510 = color51_g56510;
				float4 ifLocalVar40_g56483 = 0;
				if( Debug_Index464_g56456 == 1.0 )
				ifLocalVar40_g56483 = ( ifLocalVar61_g56510 + ifLocalVar56_g56510 + ifLocalVar40_g56510 + ifLocalVar47_g56510 + ifLocalVar52_g56510 );
				float Resolution44_g56480 = max( _MainMaskTex_TexelSize.z , _MainMaskTex_TexelSize.w );
				float4 color62_g56480 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g56480 = 0;
				if( Resolution44_g56480 <= 256.0 )
				ifLocalVar61_g56480 = color62_g56480;
				float4 color55_g56480 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g56480 = 0;
				if( Resolution44_g56480 == 512.0 )
				ifLocalVar56_g56480 = color55_g56480;
				float4 color42_g56480 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g56480 = 0;
				if( Resolution44_g56480 == 1024.0 )
				ifLocalVar40_g56480 = color42_g56480;
				float4 color48_g56480 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g56480 = 0;
				if( Resolution44_g56480 == 2048.0 )
				ifLocalVar47_g56480 = color48_g56480;
				float4 color51_g56480 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g56480 = 0;
				if( Resolution44_g56480 >= 4096.0 )
				ifLocalVar52_g56480 = color51_g56480;
				float4 ifLocalVar40_g56461 = 0;
				if( Debug_Index464_g56456 == 2.0 )
				ifLocalVar40_g56461 = ( ifLocalVar61_g56480 + ifLocalVar56_g56480 + ifLocalVar40_g56480 + ifLocalVar47_g56480 + ifLocalVar52_g56480 );
				float Resolution44_g56482 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g56482 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g56482 = 0;
				if( Resolution44_g56482 <= 256.0 )
				ifLocalVar61_g56482 = color62_g56482;
				float4 color55_g56482 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g56482 = 0;
				if( Resolution44_g56482 == 512.0 )
				ifLocalVar56_g56482 = color55_g56482;
				float4 color42_g56482 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g56482 = 0;
				if( Resolution44_g56482 == 1024.0 )
				ifLocalVar40_g56482 = color42_g56482;
				float4 color48_g56482 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g56482 = 0;
				if( Resolution44_g56482 == 2048.0 )
				ifLocalVar47_g56482 = color48_g56482;
				float4 color51_g56482 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g56482 = 0;
				if( Resolution44_g56482 >= 4096.0 )
				ifLocalVar52_g56482 = color51_g56482;
				float4 ifLocalVar40_g56501 = 0;
				if( Debug_Index464_g56456 == 3.0 )
				ifLocalVar40_g56501 = ( ifLocalVar61_g56482 + ifLocalVar56_g56482 + ifLocalVar40_g56482 + ifLocalVar47_g56482 + ifLocalVar52_g56482 );
				float Resolution44_g56462 = max( _SecondMaskTex_TexelSize.z , _SecondMaskTex_TexelSize.w );
				float4 color62_g56462 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g56462 = 0;
				if( Resolution44_g56462 <= 256.0 )
				ifLocalVar61_g56462 = color62_g56462;
				float4 color55_g56462 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g56462 = 0;
				if( Resolution44_g56462 == 512.0 )
				ifLocalVar56_g56462 = color55_g56462;
				float4 color42_g56462 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g56462 = 0;
				if( Resolution44_g56462 == 1024.0 )
				ifLocalVar40_g56462 = color42_g56462;
				float4 color48_g56462 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g56462 = 0;
				if( Resolution44_g56462 == 2048.0 )
				ifLocalVar47_g56462 = color48_g56462;
				float4 color51_g56462 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g56462 = 0;
				if( Resolution44_g56462 >= 4096.0 )
				ifLocalVar52_g56462 = color51_g56462;
				float4 ifLocalVar40_g56468 = 0;
				if( Debug_Index464_g56456 == 4.0 )
				ifLocalVar40_g56468 = ( ifLocalVar61_g56462 + ifLocalVar56_g56462 + ifLocalVar40_g56462 + ifLocalVar47_g56462 + ifLocalVar52_g56462 );
				float Resolution44_g56484 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g56484 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g56484 = 0;
				if( Resolution44_g56484 <= 256.0 )
				ifLocalVar61_g56484 = color62_g56484;
				float4 color55_g56484 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g56484 = 0;
				if( Resolution44_g56484 == 512.0 )
				ifLocalVar56_g56484 = color55_g56484;
				float4 color42_g56484 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g56484 = 0;
				if( Resolution44_g56484 == 1024.0 )
				ifLocalVar40_g56484 = color42_g56484;
				float4 color48_g56484 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g56484 = 0;
				if( Resolution44_g56484 == 2048.0 )
				ifLocalVar47_g56484 = color48_g56484;
				float4 color51_g56484 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g56484 = 0;
				if( Resolution44_g56484 >= 4096.0 )
				ifLocalVar52_g56484 = color51_g56484;
				float4 ifLocalVar40_g56481 = 0;
				if( Debug_Index464_g56456 == 5.0 )
				ifLocalVar40_g56481 = ( ifLocalVar61_g56484 + ifLocalVar56_g56484 + ifLocalVar40_g56484 + ifLocalVar47_g56484 + ifLocalVar52_g56484 );
				float Resolution44_g56486 = max( _EmissiveTex_TexelSize.z , _EmissiveTex_TexelSize.w );
				float4 color62_g56486 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g56486 = 0;
				if( Resolution44_g56486 <= 256.0 )
				ifLocalVar61_g56486 = color62_g56486;
				float4 color55_g56486 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g56486 = 0;
				if( Resolution44_g56486 == 512.0 )
				ifLocalVar56_g56486 = color55_g56486;
				float4 color42_g56486 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g56486 = 0;
				if( Resolution44_g56486 == 1024.0 )
				ifLocalVar40_g56486 = color42_g56486;
				float4 color48_g56486 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g56486 = 0;
				if( Resolution44_g56486 == 2048.0 )
				ifLocalVar47_g56486 = color48_g56486;
				float4 color51_g56486 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g56486 = 0;
				if( Resolution44_g56486 >= 4096.0 )
				ifLocalVar52_g56486 = color51_g56486;
				float4 ifLocalVar40_g56491 = 0;
				if( Debug_Index464_g56456 == 6.0 )
				ifLocalVar40_g56491 = ( ifLocalVar61_g56486 + ifLocalVar56_g56486 + ifLocalVar40_g56486 + ifLocalVar47_g56486 + ifLocalVar52_g56486 );
				float4 Output_Resolution737_g56456 = ( ( ifLocalVar40_g56509 + ifLocalVar40_g56483 + ifLocalVar40_g56461 ) + ( ifLocalVar40_g56501 + ifLocalVar40_g56468 + ifLocalVar40_g56481 ) + ifLocalVar40_g56491 );
				float4 ifLocalVar40_g56496 = 0;
				if( Debug_Type367_g56456 == 4.0 )
				ifLocalVar40_g56496 = Output_Resolution737_g56456;
				float3 vertexToFrag328_g56456 = IN.ase_texcoord8.yzw;
				float temp_output_7_0_g56498 = Debug_Min721_g56456;
				float3 temp_cast_4 = (temp_output_7_0_g56498).xxx;
				float3 Output_Mesh316_g56456 = saturate( ( ( vertexToFrag328_g56456 - temp_cast_4 ) / ( Debug_Max723_g56456 - temp_output_7_0_g56498 ) ) );
				float3 ifLocalVar40_g56489 = 0;
				if( Debug_Type367_g56456 == 9.0 )
				ifLocalVar40_g56489 = Output_Mesh316_g56456;
				float3 WorldPosition893_g56456 = worldPos;
				float2 panner73_g56459 = ( _Time.y * (TVE_NoiseParams).xy + ( (WorldPosition893_g56456).xz * TVE_NoiseParams.z ));
				float4 tex2DNode75_g56459 = tex2D( TVE_NoiseTex, panner73_g56459 );
				float4 saferPower77_g56459 = max( abs( tex2DNode75_g56459 ) , 0.0001 );
				float4x4 break19_g56471 = unity_ObjectToWorld;
				float3 appendResult20_g56471 = (float3(break19_g56471[ 0 ][ 3 ] , break19_g56471[ 1 ][ 3 ] , break19_g56471[ 2 ][ 3 ]));
				float3 appendResult60_g56473 = (float3(IN.ase_texcoord9.z , 0.0 , IN.ase_texcoord9.w));
				float3 temp_output_91_0_g56471 = ( appendResult60_g56473 * _vertex_pivot_mode );
				float3 PivotsOnly105_g56471 = (mul( unity_ObjectToWorld, float4( temp_output_91_0_g56471 , 0.0 ) ).xyz).xyz;
				half3 ObjectData20_g56472 = ( appendResult20_g56471 + PivotsOnly105_g56471 );
				half3 WorldData19_g56472 = worldPos;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g56472 = WorldData19_g56472;
				#else
				float3 staticSwitch14_g56472 = ObjectData20_g56472;
				#endif
				float3 temp_output_114_0_g56471 = staticSwitch14_g56472;
				half3 ObjectData20_g56475 = ( temp_output_114_0_g56471 * _VertexPivotMode );
				half3 WorldData19_g56475 = worldPos;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g56475 = WorldData19_g56475;
				#else
				float3 staticSwitch14_g56475 = ObjectData20_g56475;
				#endif
				float3 ObjectPosition890_g56456 = staticSwitch14_g56475;
				float3 Position83_g56474 = ObjectPosition890_g56456;
				float temp_output_84_0_g56474 = _LayerMotionValue;
				float4 lerpResult87_g56474 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY( TVE_MotionTex, samplerTVE_MotionTex, float3(( (TVE_MotionCoord).zw + ( (TVE_MotionCoord).xy * (Position83_g56474).xz ) ),temp_output_84_0_g56474) ) , TVE_MotionUsage[(int)temp_output_84_0_g56474]);
				float4 break322_g56465 = lerpResult87_g56474;
				half Wind_Power369_g56465 = break322_g56465.z;
				half Wind_Power911_g56456 = Wind_Power369_g56465;
				float temp_output_167_0_g56459 = Wind_Power911_g56456;
				float lerpResult168_g56459 = lerp( 1.4 , 0.2 , temp_output_167_0_g56459);
				float4 temp_cast_11 = (lerpResult168_g56459).xxxx;
				float4 break174_g56459 = pow( saferPower77_g56459 , temp_cast_11 );
				float ifLocalVar40_g56523 = 0;
				if( Debug_Index464_g56456 == 0.0 )
				ifLocalVar40_g56523 = break174_g56459.r;
				float2 panner73_g56458 = ( _Time.y * (TVE_NoiseParams).xy + ( (WorldPosition893_g56456).xz * TVE_NoiseParams.z ));
				float4 tex2DNode75_g56458 = tex2D( TVE_NoiseTex, panner73_g56458 );
				float temp_output_167_0_g56458 = Wind_Power911_g56456;
				float lerpResult169_g56458 = lerp( 4.0 , 2.0 , temp_output_167_0_g56458);
				float ifLocalVar40_g56522 = 0;
				if( Debug_Index464_g56456 == 1.0 )
				ifLocalVar40_g56522 = pow( abs( tex2DNode75_g56458.a ) , lerpResult169_g56458 );
				float3 Position58_g56460 = WorldPosition893_g56456;
				float Debug_Layer885_g56456 = TVE_DEBUG_Layer;
				float temp_output_82_0_g56460 = Debug_Layer885_g56456;
				float4 lerpResult88_g56460 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ColorsTex, samplerTVE_ColorsTex, float3(( (TVE_ColorsCoord).zw + ( (TVE_ColorsCoord).xy * (Position58_g56460).xz ) ),temp_output_82_0_g56460) ) , TVE_ColorsUsage[(int)temp_output_82_0_g56460]);
				float3 ifLocalVar40_g56521 = 0;
				if( Debug_Index464_g56456 == 2.0 )
				ifLocalVar40_g56521 = (lerpResult88_g56460).rgb;
				float3 Position58_g56457 = WorldPosition893_g56456;
				float temp_output_82_0_g56457 = Debug_Layer885_g56456;
				float4 lerpResult88_g56457 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ColorsTex, samplerTVE_ColorsTex, float3(( (TVE_ColorsCoord).zw + ( (TVE_ColorsCoord).xy * (Position58_g56457).xz ) ),temp_output_82_0_g56457) ) , TVE_ColorsUsage[(int)temp_output_82_0_g56457]);
				float ifLocalVar40_g56524 = 0;
				if( Debug_Index464_g56456 == 3.0 )
				ifLocalVar40_g56524 = (lerpResult88_g56457).a;
				float3 Position82_g56517 = WorldPosition893_g56456;
				float temp_output_84_0_g56517 = Debug_Layer885_g56456;
				float4 lerpResult88_g56517 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, float3(( (TVE_ExtrasCoord).zw + ( (TVE_ExtrasCoord).xy * (Position82_g56517).xz ) ),temp_output_84_0_g56517) ) , TVE_ExtrasUsage[(int)temp_output_84_0_g56517]);
				float4 break89_g56517 = lerpResult88_g56517;
				float ifLocalVar40_g56530 = 0;
				if( Debug_Index464_g56456 == 4.0 )
				ifLocalVar40_g56530 = break89_g56517.r;
				float3 Position82_g56516 = WorldPosition893_g56456;
				float temp_output_84_0_g56516 = Debug_Layer885_g56456;
				float4 lerpResult88_g56516 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, float3(( (TVE_ExtrasCoord).zw + ( (TVE_ExtrasCoord).xy * (Position82_g56516).xz ) ),temp_output_84_0_g56516) ) , TVE_ExtrasUsage[(int)temp_output_84_0_g56516]);
				float4 break89_g56516 = lerpResult88_g56516;
				float ifLocalVar40_g56525 = 0;
				if( Debug_Index464_g56456 == 5.0 )
				ifLocalVar40_g56525 = break89_g56516.g;
				float3 Position82_g56512 = WorldPosition893_g56456;
				float temp_output_84_0_g56512 = Debug_Layer885_g56456;
				float4 lerpResult88_g56512 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, float3(( (TVE_ExtrasCoord).zw + ( (TVE_ExtrasCoord).xy * (Position82_g56512).xz ) ),temp_output_84_0_g56512) ) , TVE_ExtrasUsage[(int)temp_output_84_0_g56512]);
				float4 break89_g56512 = lerpResult88_g56512;
				float ifLocalVar40_g56520 = 0;
				if( Debug_Index464_g56456 == 6.0 )
				ifLocalVar40_g56520 = break89_g56512.b;
				float3 Position82_g56526 = WorldPosition893_g56456;
				float temp_output_84_0_g56526 = Debug_Layer885_g56456;
				float4 lerpResult88_g56526 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, float3(( (TVE_ExtrasCoord).zw + ( (TVE_ExtrasCoord).xy * (Position82_g56526).xz ) ),temp_output_84_0_g56526) ) , TVE_ExtrasUsage[(int)temp_output_84_0_g56526]);
				float4 break89_g56526 = lerpResult88_g56526;
				float ifLocalVar40_g56528 = 0;
				if( Debug_Index464_g56456 == 7.0 )
				ifLocalVar40_g56528 = break89_g56526.a;
				float3 Position83_g56529 = WorldPosition893_g56456;
				float temp_output_84_0_g56529 = Debug_Layer885_g56456;
				float4 lerpResult87_g56529 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY( TVE_MotionTex, samplerTVE_MotionTex, float3(( (TVE_MotionCoord).zw + ( (TVE_MotionCoord).xy * (Position83_g56529).xz ) ),temp_output_84_0_g56529) ) , TVE_MotionUsage[(int)temp_output_84_0_g56529]);
				float3 appendResult1012_g56456 = (float3((lerpResult87_g56529).rg , 0.0));
				float3 ifLocalVar40_g56508 = 0;
				if( Debug_Index464_g56456 == 8.0 )
				ifLocalVar40_g56508 = appendResult1012_g56456;
				float3 Position83_g56531 = WorldPosition893_g56456;
				float temp_output_84_0_g56531 = Debug_Layer885_g56456;
				float4 lerpResult87_g56531 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY( TVE_MotionTex, samplerTVE_MotionTex, float3(( (TVE_MotionCoord).zw + ( (TVE_MotionCoord).xy * (Position83_g56531).xz ) ),temp_output_84_0_g56531) ) , TVE_MotionUsage[(int)temp_output_84_0_g56531]);
				float ifLocalVar40_g56527 = 0;
				if( Debug_Index464_g56456 == 9.0 )
				ifLocalVar40_g56527 = (lerpResult87_g56531).b;
				float3 Position83_g56534 = WorldPosition893_g56456;
				float temp_output_84_0_g56534 = Debug_Layer885_g56456;
				float4 lerpResult87_g56534 = lerp( TVE_ReactParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ReactTex, samplerTVE_ReactTex, float3(( (TVE_ReactCoord).zw + ( (TVE_ReactCoord).xy * (Position83_g56534).xz ) ),temp_output_84_0_g56534) ) , TVE_ReactUsage[(int)temp_output_84_0_g56534]);
				float3 appendResult1013_g56456 = (float3((lerpResult87_g56534).rg , 0.0));
				float3 ifLocalVar40_g56532 = 0;
				if( Debug_Index464_g56456 == 10.0 )
				ifLocalVar40_g56532 = appendResult1013_g56456;
				float3 Position83_g56535 = WorldPosition893_g56456;
				float temp_output_84_0_g56535 = Debug_Layer885_g56456;
				float4 lerpResult87_g56535 = lerp( TVE_ReactParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ReactTex, samplerTVE_ReactTex, float3(( (TVE_ReactCoord).zw + ( (TVE_ReactCoord).xy * (Position83_g56535).xz ) ),temp_output_84_0_g56535) ) , TVE_ReactUsage[(int)temp_output_84_0_g56535]);
				float ifLocalVar40_g56536 = 0;
				if( Debug_Index464_g56456 == 11.0 )
				ifLocalVar40_g56536 = (lerpResult87_g56535).b;
				float3 Position83_g56537 = WorldPosition893_g56456;
				float temp_output_84_0_g56537 = Debug_Layer885_g56456;
				float4 lerpResult87_g56537 = lerp( TVE_ReactParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ReactTex, samplerTVE_ReactTex, float3(( (TVE_ReactCoord).zw + ( (TVE_ReactCoord).xy * (Position83_g56537).xz ) ),temp_output_84_0_g56537) ) , TVE_ReactUsage[(int)temp_output_84_0_g56537]);
				float ifLocalVar40_g56538 = 0;
				if( Debug_Index464_g56456 == 12.0 )
				ifLocalVar40_g56538 = (lerpResult87_g56537).a;
				float3 Output_Globals888_g56456 = ( ( ifLocalVar40_g56523 + ifLocalVar40_g56522 ) + ( ifLocalVar40_g56521 + ifLocalVar40_g56524 ) + ( ifLocalVar40_g56530 + ifLocalVar40_g56525 + ifLocalVar40_g56520 + ifLocalVar40_g56528 ) + ( ifLocalVar40_g56508 + ifLocalVar40_g56527 ) + ( ifLocalVar40_g56532 + ifLocalVar40_g56536 + ifLocalVar40_g56538 ) );
				float3 ifLocalVar40_g56492 = 0;
				if( Debug_Type367_g56456 == 8.0 )
				ifLocalVar40_g56492 = Output_Globals888_g56456;
				float4 temp_output_459_0_g56456 = ( ifLocalVar40_g56488 + ifLocalVar40_g56477 + ifLocalVar40_g56533 + ifLocalVar40_g56495 + ifLocalVar40_g56496 + float4( ifLocalVar40_g56489 , 0.0 ) + float4( ifLocalVar40_g56492 , 0.0 ) );
				float4 color690_g56456 = IsGammaSpace() ? float4(0.1226415,0.1226415,0.1226415,0) : float4(0.01390275,0.01390275,0.01390275,0);
				float _IsTVEShader259_g56456 = _IsTVEShader;
				float _IsTVEAIShader645_g56456 = _IsTVEAIShader;
				float _IsAnyTVEShader647_g56456 = saturate( ( _IsTVEShader259_g56456 + _IsTVEAIShader645_g56456 ) );
				float4 lerpResult689_g56456 = lerp( color690_g56456 , temp_output_459_0_g56456 , _IsAnyTVEShader647_g56456);
				float Debug_Filter322_g56456 = TVE_DEBUG_Filter;
				float4 lerpResult326_g56456 = lerp( temp_output_459_0_g56456 , lerpResult689_g56456 , Debug_Filter322_g56456);
				float Debug_Clip623_g56456 = TVE_DEBUG_Clip;
				float lerpResult622_g56456 = lerp( 1.0 , tex2D( _MainAlbedoTex, uv_MainAlbedoTex ).a , ( Debug_Clip623_g56456 * _RenderClip ));
				clip( lerpResult622_g56456 - _Cutoff);
				clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
				
				o.Albedo = fixed3( 0.5, 0.5, 0.5 );
				o.Normal = fixed3( 0, 0, 1 );
				o.Emission = lerpResult326_g56456.rgb;
				#if defined(_SPECULAR_SETUP)
					o.Specular = fixed3( 0, 0, 0 );
				#else
					o.Metallic = 0;
				#endif
				o.Smoothness = 0;
				o.Occlusion = 1;
				o.Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float3 BakedGI = 0;

				#ifdef _ALPHATEST_ON
					clip( o.Alpha - AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
					outputDepth = IN.pos.z;
				#endif

				#ifndef USING_DIRECTIONAL_LIGHT
					fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
				#else
					fixed3 lightDir = _WorldSpaceLightPos0.xyz;
				#endif

				float3 worldN;
				worldN.x = dot(IN.tSpace0.xyz, o.Normal);
				worldN.y = dot(IN.tSpace1.xyz, o.Normal);
				worldN.z = dot(IN.tSpace2.xyz, o.Normal);
				worldN = normalize(worldN);
				o.Normal = worldN;

				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
				gi.indirect.diffuse = 0;
				gi.indirect.specular = 0;
				gi.light.color = 0;
				gi.light.dir = half3(0,1,0);

				UnityGIInput giInput;
				UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
				giInput.light = gi.light;
				giInput.worldPos = worldPos;
				giInput.worldViewDir = worldViewDir;
				giInput.atten = atten;
				#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
					giInput.lightmapUV = IN.lmap;
				#else
					giInput.lightmapUV = 0.0;
				#endif
				#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
					giInput.ambient = IN.sh;
				#else
					giInput.ambient.rgb = 0.0;
				#endif
				giInput.probeHDR[0] = unity_SpecCube0_HDR;
				giInput.probeHDR[1] = unity_SpecCube1_HDR;
				#if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
					giInput.boxMin[0] = unity_SpecCube0_BoxMin;
				#endif
				#ifdef UNITY_SPECCUBE_BOX_PROJECTION
					giInput.boxMax[0] = unity_SpecCube0_BoxMax;
					giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
					giInput.boxMax[1] = unity_SpecCube1_BoxMax;
					giInput.boxMin[1] = unity_SpecCube1_BoxMin;
					giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
				#endif

				#if defined(_SPECULAR_SETUP)
					LightingStandardSpecular_GI( o, giInput, gi );
				#else
					LightingStandard_GI( o, giInput, gi );
				#endif

				#ifdef ASE_BAKEDGI
					gi.indirect.diffuse = BakedGI;
				#endif

				#if UNITY_SHOULD_SAMPLE_SH && !defined(LIGHTMAP_ON) && defined(ASE_NO_AMBIENT)
					gi.indirect.diffuse = 0;
				#endif

				#if defined(_SPECULAR_SETUP)
					outEmission = LightingStandardSpecular_Deferred( o, worldViewDir, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
				#else
					outEmission = LightingStandard_Deferred( o, worldViewDir, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
				#endif

				#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
					outShadowMask = UnityGetRawBakedOcclusions (IN.lmap.xy, float3(0, 0, 0));
				#endif
				#ifndef UNITY_HDR_ON
					outEmission.rgb = exp2(-outEmission.rgb);
				#endif
			}
			ENDCG
		}

	
	}
	
	
	Dependency "LightMode"="ForwardBase"

	
}
/*ASEBEGIN
Version=18909
1920;0;1920;1029;2345.156;5637.594;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;2069;-1792,-4992;Half;False;Global;TVE_DEBUG_Min;TVE_DEBUG_Min;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2155;-1792,-5248;Half;False;Global;TVE_DEBUG_Layer;TVE_DEBUG_Layer;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2013;-1792,-5312;Half;False;Global;TVE_DEBUG_Index;TVE_DEBUG_Index;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;0;False;0;12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1908;-1792,-5376;Half;False;Global;TVE_DEBUG_Type;TVE_DEBUG_Type;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1953;-1792,-5120;Half;False;Global;TVE_DEBUG_Filter;TVE_DEBUG_Filter;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2032;-1792,-5056;Half;False;Global;TVE_DEBUG_Clip;TVE_DEBUG_Clip;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2070;-1792,-4928;Half;False;Global;TVE_DEBUG_Max;TVE_DEBUG_Max;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1804;-1792,2944;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1803;-1344,2944;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1772;-1088,3072;Float;False;Constant;_Float3;Float 3;31;0;Create;True;0;0;0;False;0;False;24;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1881;-1600,-5632;Half;False;Property;_Message;Message;61;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use this shader to debug the original mesh or the converted mesh attributes., 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1771;-1088,2944;Inherit;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;1800;-1472,2944;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;1774;-880,2944;Inherit;False;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1931;-1408,-5632;Half;False;Property;_DebugCategory;[ Debug Category ];60;0;Create;True;0;0;0;False;1;StyledCategory(Debug Settings, 5, 10);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1878;-1792,-5632;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;0;True;1;StyledBanner(Debug);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1843;-1632,2944;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2169;-1408,-5376;Inherit;False;Tool Debug;1;;56456;d48cde928c5068141abea1713047719b;0;7;336;FLOAT;0;False;465;FLOAT;0;False;884;FLOAT;0;False;337;FLOAT;0;False;624;FLOAT;0;False;720;FLOAT;0;False;722;FLOAT;0;False;1;COLOR;338
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2108;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;9;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;0;False;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;True;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=ForwardBase;False;0;-1;59;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;LightMode=ForwardBase;=;=;=;=;=;=;=;=;=;=;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2109;-896,-5376;Float;False;True;-1;2;;0;9;Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Debug;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;18;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;2;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;True;1;False;-1;True;3;False;-1;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True=DisableBatching;True;4;0;False;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;1;LightMode=ForwardBase;0;Standard;40;Workflow,InvertActionOnDeselection;1;Surface;0;  Blend;0;  Refraction Model;0;  Dither Shadows;1;Two Sided;0;Deferred Pass;1;Transmission;0;  Transmission Shadow;0.5,False,-1;Translucency;0;  Translucency Strength;1,False,-1;  Normal Distortion;0.5,False,-1;  Scattering;2,False,-1;  Direct;0.9,False,-1;  Ambient;0.1,False,-1;  Shadow;0.5,False,-1;Cast Shadows;0;  Use Shadow Threshold;0;Receive Shadows;0;GPU Instancing;0;LOD CrossFade;0;Built-in Fog;0;Ambient Light;0;Meta Pass;0;Add Pass;0;Override Baked GI;0;Extra Pre Pass;0;Tessellation;0;  Phong;0;  Strength;0.5,False,-1;  Type;0;  Tess;16,False,-1;  Min;10,False,-1;  Max;25,False,-1;  Edge Length;16,False,-1;  Max Displacement;25,False,-1;Fwd Specular Highlights Toggle;0;Fwd Reflections Toggle;0;Disable Batching;1;Vertex Position,InvertActionOnDeselection;1;0;6;False;True;False;True;False;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2112;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;9;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;True;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2113;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;9;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;False;True;False;False;False;False;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;True;1;=;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2110;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;9;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;0;False;True;4;1;False;-1;1;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;True;1;LightMode=ForwardAdd;False;0;True;1;LightMode=ForwardAdd;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2111;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;9;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;True;2;0;False;0;0;Standard;0;False;0
WireConnection;1803;0;1800;0
WireConnection;1800;0;1843;0
WireConnection;1774;0;1771;0
WireConnection;1774;1;1772;0
WireConnection;1774;3;1803;0
WireConnection;1843;0;1804;0
WireConnection;2169;336;1908;0
WireConnection;2169;465;2013;0
WireConnection;2169;884;2155;0
WireConnection;2169;337;1953;0
WireConnection;2169;624;2032;0
WireConnection;2169;720;2069;0
WireConnection;2169;722;2070;0
WireConnection;2109;2;2169;338
ASEEND*/
//CHKSM=485165B3C2941C195C043EFDE40767C63EC2572F