// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Vegetation/Bark Standard Lit"
{
	Properties
	{
		[StyledCategory(Render Settings, 5, 10)]_RenderingCat("[ Rendering Cat ]", Float) = 0
		[Enum(Opaque,0,Transparent,1)]_RenderMode("Render Mode", Float) = 0
		[Enum(Off,0,On,1)]_RenderZWrite("Render ZWrite", Float) = 1
		[Enum(Both,0,Back,1,Front,2)]_RenderCull("Render Faces", Float) = 0
		[Enum(Flip,0,Mirror,1,Same,2)]_RenderNormals("Render Normals", Float) = 0
		[HideInInspector]_RenderQueue("Render Queue", Float) = 0
		[HideInInspector]_RenderPriority("Render Priority", Float) = 0
		[StyledSpace(10)]_ReceiveSpace("# Receive Space", Float) = 0
		[Enum(Off,0,On,1)]_RenderSpecular("Receive Specular", Float) = 1
		[Enum(Off,0,On,1)]_RenderDecals("Receive Decals", Float) = 0
		[Enum(Off,0,On,1)]_RenderSSR("Receive SSR/SSGI", Float) = 0
		[Enum(Off,0,On,1)][Space(10)]_RenderClip("Alpha Clipping", Float) = 1
		_Cutoff("Alpha Treshold", Range( 0 , 1)) = 0.5
		[StyledSpace(10)]_FadeSpace("# Fade Space", Float) = 0
		_FadeCameraValue("Fade by Camera Distance", Range( 0 , 1)) = 1
		[StyledCategory(Global Settings)]_GlobalCat("[ Global Cat ]", Float) = 0
		[StyledEnum(Default _Layer 1 _Layer 2 _Layer 3 _Layer 4 _Layer 5 _Layer 6 _Layer 7 _Layer 8)]_LayerExtrasValue("Layer Extras", Float) = 0
		[StyledEnum(Default _Layer 1 _Layer 2 _Layer 3 _Layer 4 _Layer 5 _Layer 6 _Layer 7 _Layer 8)]_LayerMotionValue("Layer Motion", Float) = 0
		[StyledEnum(Default _Layer 1 _Layer 2 _Layer 3 _Layer 4 _Layer 5 _Layer 6 _Layer 7 _Layer 8)]_LayerReactValue("Layer React", Float) = 0
		[StyledSpace(10)]_LayersSpace("# Layers Space", Float) = 0
		[StyledMessage(Info, Procedural Variation in use. The Variation might not work as expected when switching from one LOD to another., _VertexVariationMode, 1 , 0, 10)]_VariationGlobalsMessage("# Variation Globals Message", Float) = 0
		_GlobalOverlay("Global Overlay", Range( 0 , 1)) = 1
		_GlobalWetness("Global Wetness", Range( 0 , 1)) = 1
		_GlobalEmissive("Global Emissive", Range( 0 , 1)) = 1
		_GlobalSize("Global Size", Range( 0 , 1)) = 1
		[StyledRemapSlider(_ColorsMaskMinValue, _ColorsMaskMaxValue, 0, 1, 10, 0)]_ColorsMaskRemap("Colors Mask", Vector) = (0,0,0,0)
		[StyledRemapSlider(_OverlayMaskMinValue, _OverlayMaskMaxValue, 0, 1, 10, 0)]_OverlayMaskRemap("Overlay Mask", Vector) = (0,0,0,0)
		[HideInInspector]_OverlayMaskMinValue("Overlay Mask Min Value", Range( 0 , 1)) = 0.45
		[HideInInspector]_OverlayMaskMaxValue("Overlay Mask Max Value", Range( 0 , 1)) = 0.55
		_OverlayBottomValue("Overlay Bottom", Range( 0 , 1)) = 0.5
		[StyledCategory(Main Settings)]_MainCat("[ Main Cat ]", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_MainAlbedoTex("Main Albedo", 2D) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainNormalTex("Main Normal", 2D) = "bump" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainMaskTex("Main Mask", 2D) = "white" {}
		[Space(10)][StyledVector(9)]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[HDR]_MainColor("Main Color", Color) = (1,1,1,1)
		_MainNormalValue("Main Normal", Range( -8 , 8)) = 1
		_MainOcclusionValue("Main Occlusion", Range( 0 , 1)) = 1
		_MainSmoothnessValue("Main Smoothness", Range( 0 , 1)) = 1
		[StyledRemapSlider(_LeavesMaskMinValue, _LeavesMaskMaxValue, 0, 1)]_LeavesMaskRemap("Main Leaves Mask", Vector) = (0,0,0,2)
		[StyledCategory(Detail Settings)]_DetailCat("[ Detail Cat ]", Float) = 0
		[Enum(Off,0,On,1)]_DetailMode("Detail Mode", Float) = 0
		[Enum(Overlay,0,Replace,1)]_DetailBlendMode("Detail Blend", Float) = 1
		[Enum(Vertex Blue,0,Projection,1)]_DetailTypeMode("Detail Type", Float) = 0
		[NoScaleOffset][Space(10)][StyledTextureSingleLine]_SecondAlbedoTex("Detail Albedo", 2D) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine]_SecondNormalTex("Detail Normal", 2D) = "bump" {}
		[NoScaleOffset][StyledTextureSingleLine]_SecondMaskTex("Detail Mask", 2D) = "white" {}
		[Space(10)][StyledVector(9)]_SecondUVs("Detail UVs", Vector) = (1,1,0,0)
		[HDR]_SecondColor("Detail Color", Color) = (1,1,1,1)
		_SecondNormalValue("Detail Normal", Range( -8 , 8)) = 1
		_SecondOcclusionValue("Detail Occlusion", Range( 0 , 1)) = 1
		_SecondSmoothnessValue("Detail Smoothness", Range( 0 , 1)) = 1
		[Space(10)]_DetailNormalValue("Detail Use Main Normal", Range( 0 , 1)) = 0.5
		[Enum(Main Mask,0,Detail Mask,1)][Space(10)]_DetailMaskMode("Detail Mask Source", Float) = 0
		[Enum(Off,0,On,1)]_DetailMaskInvertMode("Detail Mask Invert", Float) = 0
		_DetailMeshValue("Detail Mask Offset", Range( -1 , 1)) = 0
		[StyledRemapSlider(_DetailBlendMinValue, _DetailBlendMaxValue,0,1)]_DetailBlendRemap("Detail Blending", Vector) = (0,0,0,0)
		[HideInInspector]_DetailBlendMinValue("Detail Blend Min Value", Range( 0 , 1)) = 0.2
		[HideInInspector]_DetailBlendMaxValue("Detail Blend Max Value", Range( 0 , 1)) = 0.3
		[StyledCategory(Occlusion Settings)]_OcclusionCat("[ Occlusion Cat ]", Float) = 0
		[HDR]_VertexOcclusionColor("Vertex Occlusion Color", Color) = (1,1,1,1)
		[StyledRemapSlider(_VertexOcclusionMinValue, _VertexOcclusionMaxValue, 0, 1)]_VertexOcclusionRemap("Vertex Occlusion Mask", Vector) = (0,0,0,0)
		[HideInInspector]_VertexOcclusionMinValue("Vertex Occlusion Min Value", Range( 0 , 1)) = 0
		[HideInInspector]_VertexOcclusionMaxValue("Vertex Occlusion Max Value", Range( 0 , 1)) = 1
		[StyledCategory(Subsurface Settings)]_SubsurfaceCat("[ Subsurface Cat ]", Float) = 0
		[StyledRemapSlider(_SubsurfaceMaskMinValue, _SubsurfaceMaskMaxValue,0,1)]_SubsurfaceMaskRemap("Subsurface Mask", Vector) = (0,0,0,0)
		[Space(10)][DiffusionProfile]_SubsurfaceDiffusion("Subsurface Diffusion", Float) = 0
		[HideInInspector]_SubsurfaceDiffusion_Asset("Subsurface Diffusion", Vector) = (0,0,0,0)
		[HideInInspector][Space(10)][ASEDiffusionProfile(_SubsurfaceDiffusion)]_SubsurfaceDiffusion_asset("Subsurface Diffusion", Vector) = (0,0,0,0)
		[Space(10)]_TranslucencyIntensityValue("Translucency Intensity", Range( 0 , 50)) = 1
		_TranslucencyNormalValue("Translucency Normal", Range( 0 , 1)) = 0.1
		_TranslucencyScatteringValue("Translucency Scattering", Range( 1 , 50)) = 2
		_TranslucencyDirectValue("Translucency Direct", Range( 0 , 1)) = 1
		_TranslucencyAmbientValue("Translucency Ambient", Range( 0 , 1)) = 0.2
		_TranslucencyShadowValue("Translucency Shadow", Range( 0 , 1)) = 1
		[StyledMessage(Warning,  Translucency is not supported in HDRP. Diffusion Profiles will be used instead., 10, 5)]_TranslucencyHDMessage("# Translucency HD Message", Float) = 0
		[StyledCategory(Gradient Settings)]_GradientCat("[ Gradient Cat ]", Float) = 0
		[StyledRemapSlider(_GradientMinValue, _GradientMaxValue, 0, 1)]_GradientMaskRemap("Gradient Mask", Vector) = (0,0,0,0)
		[StyledCategory(Noise Settings)]_NoiseCat("[ Noise Cat ]", Float) = 0
		[StyledRemapSlider(_NoiseMinValue, _NoiseMaxValue, 0, 1)]_NoiseMaskRemap("Noise Mask", Vector) = (0,0,0,0)
		[StyledCategory(Emissive Settings)]_EmissiveCat("[ Emissive Cat]", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_EmissiveTex("Emissive Texture", 2D) = "white" {}
		[Space(10)][StyledVector(9)]_EmissiveUVs("Emissive UVs", Vector) = (1,1,0,0)
		[Enum(None,0,Any,10,Baked,20,Realtime,30)]_EmissiveFlagMode("Emissive Baking", Float) = 0
		[HDR]_EmissiveColor("Emissive Color", Color) = (0,0,0,0)
		[StyledEmissiveIntensity]_EmissiveIntensityParams("Emissive Intensity", Vector) = (1,1,1,0)
		[StyledCategory(Perspective Settings)]_PerspectiveCat("[ Perspective Cat ]", Float) = 0
		[StyledCategory(Size Fade Settings)]_SizeFadeCat("[ Size Fade Cat ]", Float) = 0
		[StyledMessage(Info, The Size Fade feature is recommended to be used to fade out vegetation at a distance in combination with the LOD Groups or with a 3rd party culling system., _SizeFadeMode, 1, 0, 10)]_SizeFadeMessage("# Size Fade Message", Float) = 0
		[StyledCategory(Motion Settings)]_MotionCat("[ Motion Cat ]", Float) = 0
		[StyledMessage(Info, Procedural variation in use. Use the Scale settings if the Variation is breaking the bending and rolling animation., _VertexVariationMode, 1 , 0, 10)]_VariationMotionMessage("# Variation Motion Message", Float) = 0
		[StyledSpace(10)]_MotionSpace("# Motion Space", Float) = 0
		_MotionAmplitude_10("Primary Bending", Range( 0 , 1)) = 0.05
		[IntRange]_MotionSpeed_10("Primary Speed", Range( 0 , 40)) = 2
		_MotionScale_10("Primary Scale", Range( 0 , 20)) = 0
		_MotionVariation_10("Primary Variation", Range( 0 , 20)) = 0
		[Space(10)]_MotionAmplitude_20("Second Rolling", Range( 0 , 1)) = 0.1
		_MotionAmplitude_21("Second Vertical", Range( 0 , 1)) = 0
		_MotionAmplitude_22("Second Squash", Range( 0 , 1)) = 0
		[IntRange]_MotionSpeed_20("Second Speed", Range( 0 , 40)) = 4
		_MotionScale_20("Second Scale", Range( 0 , 60)) = 0
		_MotionVariation_20("Second Variation", Range( 0 , 60)) = 5
		[Space(10)]_InteractionAmplitude("Interaction Amplitude", Range( 0 , 1)) = 1
		_InteractionMaskValue("Interaction Use Mask", Range( 0 , 1)) = 1
		[HideInInspector]_MaxBoundsInfo("_MaxBoundsInfo", Vector) = (1,1,1,1)
		[HideInInspector]_render_normals_options("_render_normals_options", Vector) = (1,1,1,0)
		[HideInInspector]_Color("_LegacyColor", Color) = (0,0,0,0)
		[HideInInspector]_MainTex("_LegacyMainTex", 2D) = "white" {}
		[HideInInspector]_BumpMap("_LegacyBumpMap", 2D) = "white" {}
		[HideInInspector][StyledToggle]_VertexDataMode("_VertexDataMode", Float) = 0
		[HideInInspector]_VertexRollingMode("_VertexRollingMode", Float) = 1
		[HideInInspector]_VertexVariationMode("_VertexVariationMode", Float) = 0
		[HideInInspector]_VertexMasksMode("_VertexMasksMode", Float) = 0
		[HideInInspector]_IsTVEShader("_IsTVEShader", Float) = 1
		[HideInInspector]_IsVersion("_IsVersion", Float) = 500
		[HideInInspector]_HasEmissive("_HasEmissive", Float) = 0
		[HideInInspector]_HasGradient("_HasGradient", Float) = 0
		[HideInInspector]_HasOcclusion("_HasOcclusion", Float) = 0
		[HideInInspector]_IsBarkShader("_IsBarkShader", Float) = 1
		[HideInInspector]_IsStandardShader("_IsStandardShader", Float) = 1
		[HideInInspector]_render_cull("_render_cull", Float) = 0
		[HideInInspector]_render_src("_render_src", Float) = 1
		[HideInInspector]_render_dst("_render_dst", Float) = 0
		[HideInInspector]_render_zw("_render_zw", Float) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull [_render_cull]
		ZWrite [_render_zw]
		Blend [_render_src] [_render_dst]
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 4.0
		#pragma shader_feature_local TVE_ALPHA_CLIP
		#pragma shader_feature_local TVE_VERTEX_DATA_BATCHED
		#pragma shader_feature_local TVE_DETAIL_MODE_OFF TVE_DETAIL_MODE_ON
		#pragma shader_feature_local TVE_DETAIL_BLEND_OVERLAY TVE_DETAIL_BLEND_REPLACE
		//TVE Pipeline Defines
		#define THE_VEGETATION_ENGINE
		#define TVE_IS_STANDARD_PIPELINE
		//TVE Shader Type Defines
		#define TVE_IS_VEGETATION_SHADER
		//TVE Injection Defines
		//SHADER INJECTION POINT BEGIN
		//SHADER INJECTION POINT END
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D_ARRAY(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D_ARRAY(tex,samplertex,coord) tex2DArray(tex,coord)
		#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
		#endif//ASE Sampling Macros

		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows dithercrossfade vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 vertexToFrag11_g56530;
			float2 vertexToFrag11_g56520;
			float vertexToFrag11_g56563;
			half ASEVFace : VFACE;
			float3 worldNormal;
			INTERNAL_DATA
			float3 vertexToFrag3890_g54857;
			float3 vertexToFrag11_g56558;
			float2 vertexToFrag11_g56542;
			float vertexToFrag11_g56491;
		};

		uniform half _render_cull;
		uniform half _IsStandardShader;
		uniform half _IsBarkShader;
		uniform half _render_src;
		uniform half _render_dst;
		uniform half _render_zw;
		uniform float4 _SubsurfaceDiffusion_Asset;
		uniform half4 _VertexOcclusionRemap;
		uniform half _RenderNormals;
		uniform half4 _ColorsMaskRemap;
		uniform half _HasGradient;
		uniform half _Cutoff;
		uniform half _EmissiveFlagMode;
		uniform half _RenderPriority;
		uniform half _DetailBlendMode;
		uniform half _TranslucencyDirectValue;
		uniform half _DetailMode;
		uniform half _TranslucencyScatteringValue;
		uniform half _DetailCat;
		uniform half _TranslucencyIntensityValue;
		uniform half _TranslucencyHDMessage;
		uniform half _TranslucencyAmbientValue;
		uniform half _IsTVEShader;
		uniform half _TranslucencyShadowValue;
		uniform half _RenderSSR;
		uniform half _HasOcclusion;
		uniform half _RenderingCat;
		uniform half _LayersSpace;
		uniform half _ReceiveSpace;
		uniform half _OcclusionCat;
		uniform half _MotionSpace;
		uniform half _SizeFadeMessage;
		uniform half _VariationMotionMessage;
		uniform half _VariationGlobalsMessage;
		uniform half _IsVersion;
		uniform half _FadeSpace;
		uniform half _DetailTypeMode;
		uniform half _RenderDecals;
		uniform half _TranslucencyNormalValue;
		uniform half4 _LeavesMaskRemap;
		uniform half _MainCat;
		uniform half _GlobalCat;
		uniform half _PerspectiveCat;
		uniform half _EmissiveCat;
		uniform half _MotionCat;
		uniform half _SubsurfaceCat;
		uniform half _GradientCat;
		uniform half _NoiseCat;
		uniform half _SizeFadeCat;
		uniform half _VertexMasksMode;
		uniform half4 _DetailBlendRemap;
		uniform half _VertexVariationMode;
		uniform float4 _SubsurfaceDiffusion_asset;
		uniform half4 _SubsurfaceMaskRemap;
		uniform float4 _GradientMaskRemap;
		uniform sampler2D _MainTex;
		uniform half _RenderMode;
		uniform half4 _OverlayMaskRemap;
		uniform float4 _Color;
		uniform half _RenderZWrite;
		uniform float4 _MaxBoundsInfo;
		uniform half _RenderQueue;
		uniform float _SubsurfaceDiffusion;
		uniform half _RenderCull;
		uniform half _HasEmissive;
		uniform half _RenderClip;
		uniform sampler2D _BumpMap;
		uniform float4 _NoiseMaskRemap;
		uniform half _MotionAmplitude_10;
		uniform float4 TVE_MotionParamsMin;
		uniform float4 TVE_MotionParamsMax;
		uniform half4 TVE_MotionParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_MotionTex);
		uniform half4 TVE_MotionCoord;
		uniform half _LayerMotionValue;
		SamplerState samplerTVE_MotionTex;
		uniform float TVE_MotionUsage[9];
		uniform sampler2D TVE_NoiseTex;
		uniform half4 TVE_NoiseParams;
		uniform float _MotionSpeed_10;
		uniform half _MotionVariation_10;
		uniform float _MotionScale_10;
		uniform half _InteractionAmplitude;
		uniform half4 TVE_ReactParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ReactTex);
		uniform half4 TVE_ReactCoord;
		uniform half _LayerReactValue;
		SamplerState samplerTVE_ReactTex;
		uniform float TVE_ReactUsage[9];
		uniform half _InteractionMaskValue;
		uniform half _MotionAmplitude_20;
		uniform half _VertexRollingMode;
		uniform half _MotionVariation_20;
		uniform half _MotionSpeed_20;
		uniform half _MotionScale_20;
		uniform half _MotionAmplitude_21;
		uniform half _MotionAmplitude_22;
		uniform half _VertexDataMode;
		uniform half _GlobalSize;
		uniform half _DisableSRPBatcher;
		uniform sampler2D _MainNormalTex;
		uniform half4 _MainUVs;
		uniform half _MainNormalValue;
		uniform sampler2D _SecondNormalTex;
		uniform half4 _SecondUVs;
		uniform half _SecondNormalValue;
		uniform half _DetailMeshValue;
		uniform sampler2D _MainMaskTex;
		uniform sampler2D _SecondMaskTex;
		uniform half _DetailMaskMode;
		uniform half _DetailMaskInvertMode;
		uniform half _DetailBlendMinValue;
		uniform half _DetailBlendMaxValue;
		uniform half _DetailNormalValue;
		uniform half3 _render_normals_options;
		uniform half4 _MainColor;
		uniform sampler2D _MainAlbedoTex;
		uniform half4 _SecondColor;
		uniform sampler2D _SecondAlbedoTex;
		uniform half4 TVE_OverlayColor;
		uniform half _OverlayBottomValue;
		uniform half _GlobalOverlay;
		uniform half4 TVE_ExtrasParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ExtrasTex);
		uniform half4 TVE_ExtrasCoord;
		uniform half _LayerExtrasValue;
		SamplerState samplerTVE_ExtrasTex;
		uniform float TVE_ExtrasUsage[9];
		uniform half _OverlayMaskMinValue;
		uniform half _OverlayMaskMaxValue;
		uniform half4 _VertexOcclusionColor;
		uniform half _VertexOcclusionMinValue;
		uniform half _VertexOcclusionMaxValue;
		uniform half4 _EmissiveColor;
		uniform float4 _EmissiveIntensityParams;
		uniform sampler2D _EmissiveTex;
		uniform half4 _EmissiveUVs;
		uniform half _GlobalEmissive;
		uniform half _RenderSpecular;
		uniform half _MainSmoothnessValue;
		uniform half _SecondSmoothnessValue;
		uniform half TVE_OverlaySmoothness;
		uniform half _GlobalWetness;
		uniform half _MainOcclusionValue;
		uniform half _SecondOcclusionValue;
		uniform half TVE_CameraFadeStart;
		uniform half TVE_CameraFadeEnd;
		uniform half _FadeCameraValue;
		uniform sampler3D TVE_ScreenTex3D;
		uniform half TVE_ScreenTexCoord;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VertexPosition3588_g54857 = ase_vertex3Pos;
			half3 Mesh_PivotsOS2291_g54857 = half3(0,0,0);
			float3 temp_output_2283_0_g54857 = ( VertexPosition3588_g54857 - Mesh_PivotsOS2291_g54857 );
			half3 VertexPos40_g56522 = temp_output_2283_0_g54857;
			float3 appendResult74_g56522 = (float3(VertexPos40_g56522.x , 0.0 , 0.0));
			half3 VertexPosRotationAxis50_g56522 = appendResult74_g56522;
			float3 break84_g56522 = VertexPos40_g56522;
			float3 appendResult81_g56522 = (float3(0.0 , break84_g56522.y , break84_g56522.z));
			half3 VertexPosOtherAxis82_g56522 = appendResult81_g56522;
			half ObjectData20_g56561 = 3.14;
			float Bounds_Height374_g54857 = _MaxBoundsInfo.y;
			half WorldData19_g56561 = ( Bounds_Height374_g54857 * 3.14 );
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g56561 = WorldData19_g56561;
			#else
				float staticSwitch14_g56561 = ObjectData20_g56561;
			#endif
			float Motion_Max_Bending1133_g54857 = staticSwitch14_g56561;
			float4x4 break19_g56524 = unity_ObjectToWorld;
			float3 appendResult20_g56524 = (float3(break19_g56524[ 0 ][ 3 ] , break19_g56524[ 1 ][ 3 ] , break19_g56524[ 2 ][ 3 ]));
			half3 ObjectData20_g56525 = appendResult20_g56524;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half3 WorldData19_g56525 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g56525 = WorldData19_g56525;
			#else
				float3 staticSwitch14_g56525 = ObjectData20_g56525;
			#endif
			float3 temp_output_114_0_g56524 = staticSwitch14_g56525;
			float3 vertexToFrag4224_g54857 = temp_output_114_0_g56524;
			half3 ObjectData20_g56538 = vertexToFrag4224_g54857;
			float3 vertexToFrag3890_g54857 = ase_worldPos;
			half3 WorldData19_g56538 = vertexToFrag3890_g54857;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g56538 = WorldData19_g56538;
			#else
				float3 staticSwitch14_g56538 = ObjectData20_g56538;
			#endif
			float3 ObjectPosition4223_g54857 = staticSwitch14_g56538;
			float3 Position83_g56567 = ObjectPosition4223_g54857;
			float temp_output_84_0_g56567 = _LayerMotionValue;
			float4 lerpResult87_g56567 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, samplerTVE_MotionTex, float3(( (TVE_MotionCoord).zw + ( (TVE_MotionCoord).xy * (Position83_g56567).xz ) ),temp_output_84_0_g56567), 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g56567]);
			half4 Global_Motion_Params3909_g54857 = lerpResult87_g56567;
			float4 break322_g56517 = Global_Motion_Params3909_g54857;
			half Wind_Power369_g56517 = break322_g56517.z;
			float lerpResult376_g56517 = lerp( TVE_MotionParamsMin.x , TVE_MotionParamsMax.x , Wind_Power369_g56517);
			half Wind_Power_103106_g54857 = lerpResult376_g56517;
			float2 panner73_g56497 = ( _Time.y * (TVE_NoiseParams).xy + ( (ObjectPosition4223_g54857).xz * TVE_NoiseParams.z ));
			float4 tex2DNode75_g56497 = tex2Dlod( TVE_NoiseTex, float4( panner73_g56497, 0, 0.0) );
			float4 saferPower77_g56497 = max( abs( tex2DNode75_g56497 ) , 0.0001 );
			half Wind_Power2223_g54857 = Wind_Power369_g56517;
			float temp_output_167_0_g56497 = Wind_Power2223_g54857;
			float lerpResult168_g56497 = lerp( 1.4 , 0.2 , temp_output_167_0_g56497);
			float4 temp_cast_3 = (lerpResult168_g56497).xxxx;
			float4 break174_g56497 = pow( saferPower77_g56497 , temp_cast_3 );
			half Global_NoiseTex_R34_g54857 = break174_g56497.r;
			float3 appendResult397_g56517 = (float3(break322_g56517.x , 0.0 , break322_g56517.y));
			float3 temp_output_398_0_g56517 = (appendResult397_g56517*2.0 + -1.0);
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 temp_output_339_0_g56517 = ( mul( unity_WorldToObject, float4( temp_output_398_0_g56517 , 0.0 ) ).xyz * ase_parentObjectScale );
			half2 Wind_DirectionOS39_g54857 = (temp_output_339_0_g56517).xz;
			half Input_Speed62_g56523 = _MotionSpeed_10;
			float mulTime373_g56523 = _Time.y * Input_Speed62_g56523;
			float3 break111_g56546 = ObjectPosition4223_g54857;
			half Variation_Complex102_g56546 = frac( ( v.color.r + ( break111_g56546.x + break111_g56546.z ) ) );
			half ObjectData20_g56547 = Variation_Complex102_g56546;
			half Variation_Simple105_g56546 = v.color.r;
			half WorldData19_g56547 = Variation_Simple105_g56546;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g56547 = WorldData19_g56547;
			#else
				float staticSwitch14_g56547 = ObjectData20_g56547;
			#endif
			half Motion_Variation3073_g54857 = staticSwitch14_g56547;
			half Motion_Variation284_g56523 = ( _MotionVariation_10 * Motion_Variation3073_g54857 );
			float Motion_Scale287_g56523 = ( _MotionScale_10 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
			half Sine_MinusOneToOne281_g56523 = sin( ( mulTime373_g56523 + Motion_Variation284_g56523 + Motion_Scale287_g56523 ) );
			half Wind_Squash4479_g54857 = break322_g56517.w;
			half Input_WindSquash419_g56523 = Wind_Squash4479_g54857;
			half Input_WindPower327_g56523 = Wind_Power_103106_g54857;
			float lerpResult321_g56523 = lerp( Sine_MinusOneToOne281_g56523 , (Sine_MinusOneToOne281_g56523*Input_WindSquash419_g56523 + 1.0) , Input_WindPower327_g56523);
			half Mesh_Motion_1082_g54857 = v.texcoord3.x;
			half2 Motion_10_Bending2258_g54857 = ( ( _MotionAmplitude_10 * Motion_Max_Bending1133_g54857 ) * Wind_Power_103106_g54857 * Global_NoiseTex_R34_g54857 * Wind_DirectionOS39_g54857 * lerpResult321_g56523 * Mesh_Motion_1082_g54857 );
			half Interaction_Amplitude4137_g54857 = _InteractionAmplitude;
			float3 Position83_g56499 = ObjectPosition4223_g54857;
			float temp_output_84_0_g56499 = _LayerReactValue;
			float4 lerpResult87_g56499 = lerp( TVE_ReactParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ReactTex, samplerTVE_ReactTex, float3(( (TVE_ReactCoord).zw + ( (TVE_ReactCoord).xy * (Position83_g56499).xz ) ),temp_output_84_0_g56499), 0.0 ) , TVE_ReactUsage[(int)temp_output_84_0_g56499]);
			half4 Global_React_Params4173_g54857 = lerpResult87_g56499;
			float4 break322_g56492 = Global_React_Params4173_g54857;
			half Interaction_Mask66_g54857 = break322_g56492.z;
			float3 appendResult397_g56492 = (float3(break322_g56492.x , 0.0 , break322_g56492.y));
			float3 temp_output_398_0_g56492 = (appendResult397_g56492*2.0 + -1.0);
			float3 temp_output_339_0_g56492 = ( mul( unity_WorldToObject, float4( temp_output_398_0_g56492 , 0.0 ) ).xyz * ase_parentObjectScale );
			half2 Interaction_DirectionOS4158_g54857 = (temp_output_339_0_g56492).xz;
			float lerpResult4494_g54857 = lerp( 1.0 , Mesh_Motion_1082_g54857 , _InteractionMaskValue);
			half2 Motion_10_Interaction53_g54857 = ( Interaction_Amplitude4137_g54857 * Motion_Max_Bending1133_g54857 * Interaction_Mask66_g54857 * Interaction_Mask66_g54857 * Interaction_DirectionOS4158_g54857 * lerpResult4494_g54857 );
			float2 lerpResult109_g54857 = lerp( Motion_10_Bending2258_g54857 , Motion_10_Interaction53_g54857 , ( Interaction_Mask66_g54857 * saturate( Interaction_Amplitude4137_g54857 ) ));
			float2 break143_g54857 = lerpResult109_g54857;
			half Motion_10_ZAxis190_g54857 = break143_g54857.y;
			half Angle44_g56522 = Motion_10_ZAxis190_g54857;
			half3 VertexPos40_g56534 = ( VertexPosRotationAxis50_g56522 + ( VertexPosOtherAxis82_g56522 * cos( Angle44_g56522 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g56522 ) * sin( Angle44_g56522 ) ) );
			float3 appendResult74_g56534 = (float3(0.0 , 0.0 , VertexPos40_g56534.z));
			half3 VertexPosRotationAxis50_g56534 = appendResult74_g56534;
			float3 break84_g56534 = VertexPos40_g56534;
			float3 appendResult81_g56534 = (float3(break84_g56534.x , break84_g56534.y , 0.0));
			half3 VertexPosOtherAxis82_g56534 = appendResult81_g56534;
			half Motion_10_XAxis216_g54857 = break143_g54857.x;
			half Angle44_g56534 = -Motion_10_XAxis216_g54857;
			half3 VertexPos40_g56557 = ( VertexPosRotationAxis50_g56534 + ( VertexPosOtherAxis82_g56534 * cos( Angle44_g56534 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g56534 ) * sin( Angle44_g56534 ) ) );
			float3 appendResult74_g56557 = (float3(0.0 , VertexPos40_g56557.y , 0.0));
			float3 VertexPosRotationAxis50_g56557 = appendResult74_g56557;
			float3 break84_g56557 = VertexPos40_g56557;
			float3 appendResult81_g56557 = (float3(break84_g56557.x , 0.0 , break84_g56557.z));
			float3 VertexPosOtherAxis82_g56557 = appendResult81_g56557;
			half Motion_20_Mode4258_g54857 = _VertexRollingMode;
			half Mesh_Motion_2060_g54857 = v.texcoord3.y;
			float lerpResult410_g56517 = lerp( TVE_MotionParamsMin.y , TVE_MotionParamsMax.y , Wind_Power369_g56517);
			half Wind_Power_203109_g54857 = lerpResult410_g56517;
			half Motion_20_Variation4255_g54857 = ( _MotionVariation_20 * Motion_Variation3073_g54857 );
			half Variation127_g56498 = ( Motion_20_Variation4255_g54857 * Motion_Variation3073_g54857 );
			float mulTime131_g56498 = _Time.y * 0.5;
			float temp_output_134_0_g56498 = (sin( ( Variation127_g56498 + mulTime131_g56498 ) )*0.5 + 0.5);
			float temp_output_112_0_g56498 = Wind_Power2223_g54857;
			float lerpResult136_g56498 = lerp( ( temp_output_134_0_g56498 * temp_output_134_0_g56498 * temp_output_134_0_g56498 * temp_output_134_0_g56498 ) , 1.0 , ( temp_output_112_0_g56498 * temp_output_112_0_g56498 ));
			float lerpResult126_g56498 = lerp( lerpResult136_g56498 , 1.0 , ( 1.0 - saturate( Variation127_g56498 ) ));
			half Motion_Selective4260_g54857 = lerpResult126_g56498;
			half Motion_20_Commons4381_g54857 = ( Motion_20_Mode4258_g54857 * Mesh_Motion_2060_g54857 * Wind_Power_203109_g54857 * Global_NoiseTex_R34_g54857 * Motion_Selective4260_g54857 );
			half Motion_20_Speed4257_g54857 = _MotionSpeed_20;
			half Input_Speed62_g56500 = Motion_20_Speed4257_g54857;
			float mulTime354_g56500 = _Time.y * Input_Speed62_g56500;
			float Motion_Variation284_g56500 = Motion_20_Variation4255_g54857;
			half Motion_20_Scale4256_g54857 = _MotionScale_20;
			float Motion_Scale287_g56500 = ( Motion_20_Scale4256_g54857 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
			half Motion_20_SineWaveA4382_g54857 = sin( ( mulTime354_g56500 + Motion_Variation284_g56500 + Motion_Scale287_g56500 ) );
			half ObjectData20_g56502 = 3.14;
			float Bounds_Radius121_g54857 = _MaxBoundsInfo.x;
			half WorldData19_g56502 = Bounds_Radius121_g54857;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g56502 = WorldData19_g56502;
			#else
				float staticSwitch14_g56502 = ObjectData20_g56502;
			#endif
			float Motion_Max_Rolling1137_g54857 = staticSwitch14_g56502;
			half Motion_20_Rolling138_g54857 = ( _MotionAmplitude_20 * Motion_20_Commons4381_g54857 * Motion_20_SineWaveA4382_g54857 * Motion_Max_Rolling1137_g54857 );
			half Angle44_g56557 = Motion_20_Rolling138_g54857;
			half Input_Speed62_g56545 = ( Motion_20_Speed4257_g54857 - 1.0 );
			float mulTime354_g56545 = _Time.y * Input_Speed62_g56545;
			float Motion_Variation284_g56545 = Motion_20_Variation4255_g54857;
			float Motion_Scale287_g56545 = ( Motion_20_Scale4256_g54857 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
			half Motion_20_SineWaveB4460_g54857 = sin( ( mulTime354_g56545 + Motion_Variation284_g56545 + Motion_Scale287_g56545 ) );
			float3 appendResult4393_g54857 = (float3(0.0 , ( _MotionAmplitude_21 * Motion_20_Commons4381_g54857 * Motion_20_SineWaveB4460_g54857 * Bounds_Radius121_g54857 ) , 0.0));
			half3 Motion_20_Vertical4280_g54857 = appendResult4393_g54857;
			float2 break4421_g54857 = ( ( _MotionAmplitude_22 * Motion_20_Commons4381_g54857 * ( Bounds_Radius121_g54857 * 2.0 ) * (Motion_20_SineWaveA4382_g54857*Wind_Squash4479_g54857 + 1.0) ) * Wind_DirectionOS39_g54857 );
			float3 appendResult4417_g54857 = (float3(break4421_g54857.x , 0.0 , break4421_g54857.y));
			half3 Motion_20_Squash4418_g54857 = appendResult4417_g54857;
			float3 Vertex_Motion_Object833_g54857 = ( ( VertexPosRotationAxis50_g56557 + ( VertexPosOtherAxis82_g56557 * cos( Angle44_g56557 ) ) + ( cross( float3(0,1,0) , VertexPosOtherAxis82_g56557 ) * sin( Angle44_g56557 ) ) ) + Motion_20_Vertical4280_g54857 + Motion_20_Squash4418_g54857 );
			float3 temp_output_3474_0_g54857 = ( VertexPosition3588_g54857 - Mesh_PivotsOS2291_g54857 );
			float3 appendResult2043_g54857 = (float3(Motion_10_XAxis216_g54857 , 0.0 , Motion_10_ZAxis190_g54857));
			float3 appendResult2047_g54857 = (float3(Motion_20_Rolling138_g54857 , 0.0 , -Motion_20_Rolling138_g54857));
			float3 Vertex_Motion_World1118_g54857 = ( ( temp_output_3474_0_g54857 + appendResult2043_g54857 ) + appendResult2047_g54857 + Motion_20_Vertical4280_g54857 + Motion_20_Squash4418_g54857 );
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch3312_g54857 = Vertex_Motion_World1118_g54857;
			#else
				float3 staticSwitch3312_g54857 = ( Vertex_Motion_Object833_g54857 + ( 0.0 * _VertexDataMode ) );
			#endif
			half Global_Vertex_Size174_g54857 = break322_g56492.w;
			float lerpResult346_g54857 = lerp( 1.0 , Global_Vertex_Size174_g54857 , _GlobalSize);
			float3 appendResult3480_g54857 = (float3(lerpResult346_g54857 , lerpResult346_g54857 , lerpResult346_g54857));
			half3 ObjectData20_g56553 = appendResult3480_g54857;
			half3 _Vector11 = half3(1,1,1);
			half3 WorldData19_g56553 = _Vector11;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g56553 = WorldData19_g56553;
			#else
				float3 staticSwitch14_g56553 = ObjectData20_g56553;
			#endif
			half3 Vertex_Size1741_g54857 = staticSwitch14_g56553;
			half3 _Vector5 = half3(1,1,1);
			float3 Vertex_SizeFade1740_g54857 = _Vector5;
			half3 Grass_Coverage2661_g54857 = half3(0,0,0);
			float3 Final_VertexPosition890_g54857 = ( ( ( staticSwitch3312_g54857 * Vertex_Size1741_g54857 * Vertex_SizeFade1740_g54857 ) + Mesh_PivotsOS2291_g54857 + Grass_Coverage2661_g54857 ) + _DisableSRPBatcher );
			v.vertex.xyz = Final_VertexPosition890_g54857;
			v.vertex.w = 1;
			o.vertexToFrag11_g56530 = ( ( v.texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
			float2 appendResult21_g56551 = (float2(v.texcoord.z , v.texcoord.w));
			float2 Mesh_DetailCoord3_g54857 = appendResult21_g56551;
			o.vertexToFrag11_g56520 = ( ( Mesh_DetailCoord3_g54857 * (_SecondUVs).xy ) + (_SecondUVs).zw );
			half Mesh_DetailMask90_g54857 = v.color.b;
			o.vertexToFrag11_g56563 = ( ( Mesh_DetailMask90_g54857 - 0.5 ) + _DetailMeshValue );
			o.vertexToFrag3890_g54857 = ase_worldPos;
			float3 temp_cast_11 = (1.0).xxx;
			float Mesh_Occlusion318_g54857 = v.color.g;
			float temp_output_7_0_g56537 = _VertexOcclusionMinValue;
			float3 lerpResult2945_g54857 = lerp( (_VertexOcclusionColor).rgb , temp_cast_11 , saturate( ( ( Mesh_Occlusion318_g54857 - temp_output_7_0_g56537 ) / ( _VertexOcclusionMaxValue - temp_output_7_0_g56537 ) ) ));
			o.vertexToFrag11_g56558 = lerpResult2945_g54857;
			o.vertexToFrag11_g56542 = ( ( v.texcoord.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
			float temp_output_7_0_g56536 = TVE_CameraFadeStart;
			float saferPower3976_g54857 = max( saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g56536 ) / ( TVE_CameraFadeEnd - temp_output_7_0_g56536 ) ) ) , 0.0001 );
			float temp_output_3976_0_g54857 = pow( saferPower3976_g54857 , _FadeCameraValue );
			o.vertexToFrag11_g56491 = temp_output_3976_0_g54857;
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			half2 Main_UVs15_g54857 = i.vertexToFrag11_g56530;
			half3 Main_Normal137_g54857 = UnpackScaleNormal( tex2D( _MainNormalTex, Main_UVs15_g54857 ), _MainNormalValue );
			half2 Second_UVs17_g54857 = i.vertexToFrag11_g56520;
			half3 Second_Normal179_g54857 = UnpackScaleNormal( tex2D( _SecondNormalTex, Second_UVs17_g54857 ), _SecondNormalValue );
			float temp_output_3919_0_g54857 = i.vertexToFrag11_g56563;
			half Blend_Source1540_g54857 = temp_output_3919_0_g54857;
			float4 tex2DNode35_g54857 = tex2D( _MainMaskTex, Main_UVs15_g54857 );
			half Main_Mask57_g54857 = tex2DNode35_g54857.b;
			float4 tex2DNode33_g54857 = tex2D( _SecondMaskTex, Second_UVs17_g54857 );
			half Second_Mask81_g54857 = tex2DNode33_g54857.b;
			float lerpResult1327_g54857 = lerp( Main_Mask57_g54857 , Second_Mask81_g54857 , _DetailMaskMode);
			float lerpResult4058_g54857 = lerp( lerpResult1327_g54857 , ( 1.0 - lerpResult1327_g54857 ) , _DetailMaskInvertMode);
			float temp_output_7_0_g56541 = _DetailBlendMinValue;
			half Mask_Detail147_g54857 = saturate( ( ( saturate( ( Blend_Source1540_g54857 + ( Blend_Source1540_g54857 * lerpResult4058_g54857 ) ) ) - temp_output_7_0_g56541 ) / ( _DetailBlendMaxValue - temp_output_7_0_g56541 ) ) );
			float3 lerpResult230_g54857 = lerp( float3( 0,0,1 ) , Second_Normal179_g54857 , Mask_Detail147_g54857);
			float3 lerpResult3372_g54857 = lerp( float3( 0,0,1 ) , Main_Normal137_g54857 , _DetailNormalValue);
			float3 lerpResult3376_g54857 = lerp( Main_Normal137_g54857 , BlendNormals( lerpResult3372_g54857 , Second_Normal179_g54857 ) , Mask_Detail147_g54857);
			#if defined(TVE_DETAIL_BLEND_OVERLAY)
				float3 staticSwitch4063_g54857 = BlendNormals( Main_Normal137_g54857 , lerpResult230_g54857 );
			#elif defined(TVE_DETAIL_BLEND_REPLACE)
				float3 staticSwitch4063_g54857 = lerpResult3376_g54857;
			#else
				float3 staticSwitch4063_g54857 = BlendNormals( Main_Normal137_g54857 , lerpResult230_g54857 );
			#endif
			#if defined(TVE_DETAIL_MODE_OFF)
				float3 staticSwitch267_g54857 = Main_Normal137_g54857;
			#elif defined(TVE_DETAIL_MODE_ON)
				float3 staticSwitch267_g54857 = staticSwitch4063_g54857;
			#else
				float3 staticSwitch267_g54857 = Main_Normal137_g54857;
			#endif
			float3 temp_output_13_0_g56521 = staticSwitch267_g54857;
			float3 switchResult12_g56521 = (((i.ASEVFace>0)?(temp_output_13_0_g56521):(( temp_output_13_0_g56521 * _render_normals_options ))));
			half3 Blend_Normal312_g54857 = switchResult12_g56521;
			half3 Final_Normal366_g54857 = Blend_Normal312_g54857;
			o.Normal = Final_Normal366_g54857;
			half Leaves_Mask4511_g54857 = 1.0;
			float3 lerpResult4521_g54857 = lerp( float3( 1,1,1 ) , ( float3(1,1,1) * float3(1,1,1) * float3(1,1,1) ) , Leaves_Mask4511_g54857);
			float3 lerpResult4519_g54857 = lerp( float3( 1,1,1 ) , (_MainColor).rgb , Leaves_Mask4511_g54857);
			float4 tex2DNode29_g54857 = tex2D( _MainAlbedoTex, Main_UVs15_g54857 );
			half3 Main_Albedo99_g54857 = ( lerpResult4519_g54857 * (tex2DNode29_g54857).rgb );
			half3 Second_Albedo153_g54857 = (( _SecondColor * tex2D( _SecondAlbedoTex, Second_UVs17_g54857 ) )).rgb;
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g56501 = 2.0;
			#else
				float staticSwitch1_g56501 = 4.594794;
			#endif
			float3 lerpResult235_g54857 = lerp( Main_Albedo99_g54857 , ( Main_Albedo99_g54857 * Second_Albedo153_g54857 * staticSwitch1_g56501 ) , Mask_Detail147_g54857);
			float3 lerpResult208_g54857 = lerp( Main_Albedo99_g54857 , Second_Albedo153_g54857 , Mask_Detail147_g54857);
			#if defined(TVE_DETAIL_BLEND_OVERLAY)
				float3 staticSwitch4062_g54857 = lerpResult235_g54857;
			#elif defined(TVE_DETAIL_BLEND_REPLACE)
				float3 staticSwitch4062_g54857 = lerpResult208_g54857;
			#else
				float3 staticSwitch4062_g54857 = lerpResult235_g54857;
			#endif
			#if defined(TVE_DETAIL_MODE_OFF)
				float3 staticSwitch255_g54857 = Main_Albedo99_g54857;
			#elif defined(TVE_DETAIL_MODE_ON)
				float3 staticSwitch255_g54857 = staticSwitch4062_g54857;
			#else
				float3 staticSwitch255_g54857 = Main_Albedo99_g54857;
			#endif
			half3 Blend_Albedo265_g54857 = staticSwitch255_g54857;
			half3 Blend_AlbedoTinted2808_g54857 = ( lerpResult4521_g54857 * Blend_Albedo265_g54857 );
			half3 Blend_AlbedoColored863_g54857 = Blend_AlbedoTinted2808_g54857;
			half3 Blend_AlbedoAndSubsurface149_g54857 = Blend_AlbedoColored863_g54857;
			half3 Global_OverlayColor1758_g54857 = (TVE_OverlayColor).rgb;
			float3 Main_Normal_WS4101_g54857 = (WorldNormalVector( i , Main_Normal137_g54857 ));
			float lerpResult3567_g54857 = lerp( _OverlayBottomValue , 1.0 , Main_Normal_WS4101_g54857.y);
			half Main_AlbedoTex_G3526_g54857 = tex2DNode29_g54857.g;
			half Second_AlbedoTex_G3581_g54857 = (tex2D( _SecondAlbedoTex, Second_UVs17_g54857 )).g;
			float lerpResult3579_g54857 = lerp( Main_AlbedoTex_G3526_g54857 , Second_AlbedoTex_G3581_g54857 , Mask_Detail147_g54857);
			#if defined(TVE_DETAIL_MODE_OFF)
				float staticSwitch3574_g54857 = Main_AlbedoTex_G3526_g54857;
			#elif defined(TVE_DETAIL_MODE_ON)
				float staticSwitch3574_g54857 = lerpResult3579_g54857;
			#else
				float staticSwitch3574_g54857 = Main_AlbedoTex_G3526_g54857;
			#endif
			float3 WorldPosition3905_g54857 = i.vertexToFrag3890_g54857;
			float3 Position82_g56552 = WorldPosition3905_g54857;
			float temp_output_84_0_g56552 = _LayerExtrasValue;
			float4 lerpResult88_g56552 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, float3(( (TVE_ExtrasCoord).zw + ( (TVE_ExtrasCoord).xy * (Position82_g56552).xz ) ),temp_output_84_0_g56552) ) , TVE_ExtrasUsage[(int)temp_output_84_0_g56552]);
			float4 break89_g56552 = lerpResult88_g56552;
			half Global_Extras_Overlay156_g54857 = break89_g56552.b;
			float temp_output_1025_0_g54857 = ( _GlobalOverlay * Global_Extras_Overlay156_g54857 );
			half Overlay_Commons1365_g54857 = temp_output_1025_0_g54857;
			float temp_output_7_0_g56528 = _OverlayMaskMinValue;
			half Overlay_Mask269_g54857 = saturate( ( ( ( ( ( lerpResult3567_g54857 * 0.5 ) + staticSwitch3574_g54857 ) * Overlay_Commons1365_g54857 ) - temp_output_7_0_g56528 ) / ( _OverlayMaskMaxValue - temp_output_7_0_g56528 ) ) );
			float3 lerpResult336_g54857 = lerp( Blend_AlbedoAndSubsurface149_g54857 , Global_OverlayColor1758_g54857 , Overlay_Mask269_g54857);
			half3 Final_Albedo359_g54857 = lerpResult336_g54857;
			float3 Vertex_Occlusion648_g54857 = saturate( i.vertexToFrag11_g56558 );
			o.Albedo = ( Final_Albedo359_g54857 * Vertex_Occlusion648_g54857 );
			float4 temp_output_4214_0_g54857 = ( _EmissiveColor * _EmissiveIntensityParams.x );
			half2 Emissive_UVs2468_g54857 = i.vertexToFrag11_g56542;
			half Global_Extras_Emissive4203_g54857 = break89_g56552.r;
			float lerpResult4206_g54857 = lerp( 1.0 , Global_Extras_Emissive4203_g54857 , _GlobalEmissive);
			half3 Final_Emissive2476_g54857 = ( (( temp_output_4214_0_g54857 * tex2D( _EmissiveTex, Emissive_UVs2468_g54857 ) )).rgb * lerpResult4206_g54857 );
			o.Emission = Final_Emissive2476_g54857;
			float3 temp_cast_4 = (( 0.04 * _RenderSpecular )).xxx;
			o.Specular = temp_cast_4;
			half Main_Smoothness227_g54857 = ( tex2DNode35_g54857.a * _MainSmoothnessValue );
			half Second_Smoothness236_g54857 = ( tex2DNode33_g54857.a * _SecondSmoothnessValue );
			float lerpResult266_g54857 = lerp( Main_Smoothness227_g54857 , Second_Smoothness236_g54857 , Mask_Detail147_g54857);
			#if defined(TVE_DETAIL_BLEND_OVERLAY)
				float staticSwitch4065_g54857 = Main_Smoothness227_g54857;
			#elif defined(TVE_DETAIL_BLEND_REPLACE)
				float staticSwitch4065_g54857 = lerpResult266_g54857;
			#else
				float staticSwitch4065_g54857 = Main_Smoothness227_g54857;
			#endif
			#if defined(TVE_DETAIL_MODE_OFF)
				float staticSwitch297_g54857 = Main_Smoothness227_g54857;
			#elif defined(TVE_DETAIL_MODE_ON)
				float staticSwitch297_g54857 = staticSwitch4065_g54857;
			#else
				float staticSwitch297_g54857 = Main_Smoothness227_g54857;
			#endif
			half Blend_Smoothness314_g54857 = staticSwitch297_g54857;
			half Global_OverlaySmoothness311_g54857 = TVE_OverlaySmoothness;
			float lerpResult343_g54857 = lerp( Blend_Smoothness314_g54857 , Global_OverlaySmoothness311_g54857 , Overlay_Mask269_g54857);
			half Final_Smoothness371_g54857 = lerpResult343_g54857;
			half Global_Extras_Wetness305_g54857 = break89_g56552.g;
			float lerpResult3673_g54857 = lerp( 0.0 , Global_Extras_Wetness305_g54857 , _GlobalWetness);
			half Final_SmoothnessAndWetness4130_g54857 = saturate( ( Final_Smoothness371_g54857 + lerpResult3673_g54857 ) );
			o.Smoothness = Final_SmoothnessAndWetness4130_g54857;
			float lerpResult240_g54857 = lerp( 1.0 , tex2DNode35_g54857.g , _MainOcclusionValue);
			half Main_Occlusion247_g54857 = lerpResult240_g54857;
			float lerpResult239_g54857 = lerp( 1.0 , tex2DNode33_g54857.g , _SecondOcclusionValue);
			half Second_Occlusion251_g54857 = lerpResult239_g54857;
			float lerpResult294_g54857 = lerp( Main_Occlusion247_g54857 , Second_Occlusion251_g54857 , Mask_Detail147_g54857);
			#if defined(TVE_DETAIL_BLEND_OVERLAY)
				float staticSwitch4066_g54857 = Main_Occlusion247_g54857;
			#elif defined(TVE_DETAIL_BLEND_REPLACE)
				float staticSwitch4066_g54857 = lerpResult294_g54857;
			#else
				float staticSwitch4066_g54857 = Main_Occlusion247_g54857;
			#endif
			#if defined(TVE_DETAIL_MODE_OFF)
				float staticSwitch310_g54857 = Main_Occlusion247_g54857;
			#elif defined(TVE_DETAIL_MODE_ON)
				float staticSwitch310_g54857 = staticSwitch4066_g54857;
			#else
				float staticSwitch310_g54857 = Main_Occlusion247_g54857;
			#endif
			half Blend_Occlusion323_g54857 = staticSwitch310_g54857;
			o.Occlusion = Blend_Occlusion323_g54857;
			float localCustomAlphaClip3735_g54857 = ( 0.0 );
			half Fade_Camera3743_g54857 = i.vertexToFrag11_g56491;
			half Final_AlphaFade3727_g54857 = ( 1.0 * Fade_Camera3743_g54857 );
			float temp_output_41_0_g56562 = Final_AlphaFade3727_g54857;
			float Main_Alpha316_g54857 = ( _MainColor.a * tex2DNode29_g54857.a );
			half AlphaTreshold2132_g54857 = _Cutoff;
			#ifdef TVE_ALPHA_CLIP
				float staticSwitch3792_g54857 = ( Main_Alpha316_g54857 - ( AlphaTreshold2132_g54857 - 0.5 ) );
			#else
				float staticSwitch3792_g54857 = Main_Alpha316_g54857;
			#endif
			half Final_Alpha3754_g54857 = staticSwitch3792_g54857;
			float temp_output_661_0_g54857 = ( saturate( ( temp_output_41_0_g56562 + ( temp_output_41_0_g56562 * tex3D( TVE_ScreenTex3D, ( TVE_ScreenTexCoord * WorldPosition3905_g54857 ) ).r ) ) ) * Final_Alpha3754_g54857 );
			float Alpha3735_g54857 = temp_output_661_0_g54857;
			float Treshold3735_g54857 = 0.5;
			{
			#if TVE_ALPHA_CLIP
				clip(Alpha3735_g54857 - Treshold3735_g54857);
			#endif
			}
			half Final_Clip914_g54857 = saturate( Alpha3735_g54857 );
			o.Alpha = Final_Clip914_g54857;
		}

		ENDCG
	}
	Fallback "Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback"
	CustomEditor "TVEShaderCoreGUI"
}
/*ASEBEGIN
Version=18909
1920;0;1920;1029;3985.255;1185.982;2.268934;True;False
Node;AmplifyShaderEditor.RangedFloatNode;10;-2176,-768;Half;False;Property;_render_cull;_render_cull;203;1;[HideInInspector];Create;True;0;3;Both;0;Back;1;Front;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;372;-1856,384;Inherit;False;Define Pipeline Standard;-1;;49634;9af03ae8defe78d448ef2a4ef3601e12;0;0;1;FLOAT;529
Node;AmplifyShaderEditor.FunctionNode;307;-2176,384;Inherit;False;Define Shader Vegetation;-1;;49635;b458122dd75182d488380bd0f592b9e6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-1984,-896;Half;False;Property;_IsStandardShader;_IsStandardShader;202;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;127;-2176,-896;Half;False;Property;_IsBarkShader;_IsBarkShader;201;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1984,-768;Half;False;Property;_render_src;_render_src;205;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1792,-768;Half;False;Property;_render_dst;_render_dst;206;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1600,-768;Half;False;Property;_render_zw;_render_zw;207;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;373;-1344,-896;Inherit;False;Compile All Shaders;-1;;49636;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;374;-1536,-896;Inherit;False;Compile Core;-1;;49637;634b02fd1f32e6a4c875d8fc2c450956;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;376;-2176,-384;Inherit;False;Base Shader;0;;54857;856f7164d1c579d43a5cf4968a75ca43;81,3882,1,3880,1,3957,1,4028,1,4029,1,3903,1,3900,1,3904,1,4204,1,3908,1,4172,1,1300,1,1298,1,4179,1,3586,0,4499,1,1708,0,3658,0,3509,1,1712,1,3873,1,1714,1,1715,1,1717,1,1718,1,916,1,1762,0,1763,0,3568,1,1949,1,1776,0,3475,1,4210,1,893,0,1745,1,3479,0,4510,0,3501,1,3221,2,1646,0,1757,0,1271,1,3889,0,2807,0,3886,0,2953,0,3887,0,3243,0,3888,0,3728,1,3949,0,2172,0,3883,0,2658,0,1742,0,3484,0,3575,1,1737,1,1733,1,1734,1,1736,1,1735,1,878,0,1550,0,4068,0,4072,0,4070,0,4067,0,4069,0,860,1,2261,1,2260,1,2032,1,2054,1,2062,0,2039,0,4177,1,4217,1,3592,1,4242,0,2750,0;0;19;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;531;FLOAT;4135;FLOAT;529;FLOAT;3678;FLOAT;530;FLOAT;4127;FLOAT;4122;FLOAT;4134;FLOAT;1235;FLOAT3;1230;FLOAT;1461;FLOAT;1290;FLOAT;721;FLOAT;532;FLOAT;629;FLOAT3;534
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;360;-1376,-384;Float;False;True;-1;4;TVEShaderCoreGUI;0;0;StandardSpecular;BOXOPHOBIC/The Vegetation Engine/Vegetation/Bark Standard Lit;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;True;Back;0;True;17;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;Geometry;All;16;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;5;True;20;10;True;7;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Absolute;0;Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback;204;-1;-1;-1;0;False;0;0;True;10;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2176,-512;Inherit;False;1022.896;100;Final;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;37;-2176,-1024;Inherit;False;1026.438;100;Internal;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;285;-2176,256;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
WireConnection;360;0;376;0
WireConnection;360;1;376;528
WireConnection;360;2;376;2489
WireConnection;360;3;376;3678
WireConnection;360;4;376;530
WireConnection;360;5;376;531
WireConnection;360;9;376;532
WireConnection;360;11;376;534
ASEEND*/
//CHKSM=F4BDE3417529F547557481CC32822AC2307B556A
