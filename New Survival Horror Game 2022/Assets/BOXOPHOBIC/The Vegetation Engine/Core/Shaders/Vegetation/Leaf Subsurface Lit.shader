// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Vegetation/Leaf Subsurface Lit"
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
		_FadeGlancingValue("Fade by Glancing Angle", Range( 0 , 1)) = 0
		[StyledCategory(Global Settings)]_GlobalCat("[ Global Cat ]", Float) = 0
		[StyledEnum(Default _Layer 1 _Layer 2 _Layer 3 _Layer 4 _Layer 5 _Layer 6 _Layer 7 _Layer 8)]_LayerColorsValue("Layer Colors", Float) = 0
		[StyledEnum(Default _Layer 1 _Layer 2 _Layer 3 _Layer 4 _Layer 5 _Layer 6 _Layer 7 _Layer 8)]_LayerExtrasValue("Layer Extras", Float) = 0
		[StyledEnum(Default _Layer 1 _Layer 2 _Layer 3 _Layer 4 _Layer 5 _Layer 6 _Layer 7 _Layer 8)]_LayerMotionValue("Layer Motion", Float) = 0
		[StyledEnum(Default _Layer 1 _Layer 2 _Layer 3 _Layer 4 _Layer 5 _Layer 6 _Layer 7 _Layer 8)]_LayerReactValue("Layer React", Float) = 0
		[StyledSpace(10)]_LayersSpace("# Layers Space", Float) = 0
		[StyledMessage(Info, Procedural Variation in use. The Variation might not work as expected when switching from one LOD to another., _VertexVariationMode, 1 , 0, 10)]_VariationGlobalsMessage("# Variation Globals Message", Float) = 0
		_GlobalColors("Global Colors", Range( 0 , 1)) = 1
		_GlobalOverlay("Global Overlay", Range( 0 , 1)) = 1
		_GlobalWetness("Global Wetness", Range( 0 , 1)) = 1
		_GlobalEmissive("Global Emissive", Range( 0 , 1)) = 1
		_GlobalAlpha("Global Alpha", Range( 0 , 1)) = 1
		_GlobalSize("Global Size", Range( 0 , 1)) = 1
		[StyledRemapSlider(_ColorsMaskMinValue, _ColorsMaskMaxValue, 0, 1, 10, 0)]_ColorsMaskRemap("Colors Mask", Vector) = (0,0,0,0)
		[HideInInspector]_ColorsMaskMinValue("Colors Mask Min Value", Range( 0 , 1)) = 0
		[HideInInspector]_ColorsMaskMaxValue("Colors Mask Max Value", Range( 0 , 1)) = 1
		_ColorsVariationValue("Colors Variation", Range( 0 , 1)) = 0
		[StyledRemapSlider(_OverlayMaskMinValue, _OverlayMaskMaxValue, 0, 1, 10, 0)]_OverlayMaskRemap("Overlay Mask", Vector) = (0,0,0,0)
		[HideInInspector]_OverlayMaskMinValue("Overlay Mask Min Value", Range( 0 , 1)) = 0.45
		[HideInInspector]_OverlayMaskMaxValue("Overlay Mask Max Value", Range( 0 , 1)) = 0.55
		_OverlayVariationValue("Overlay Variation", Range( 0 , 1)) = 0
		_OverlayBottomValue("Overlay Bottom", Range( 0 , 1)) = 0.5
		[Space(10)]_AlphaVariationValue("Alpha Variation", Range( 0 , 1)) = 1
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
		[StyledRemapSlider(_DetailBlendMinValue, _DetailBlendMaxValue,0,1)]_DetailBlendRemap("Detail Blending", Vector) = (0,0,0,0)
		[StyledCategory(Occlusion Settings)]_OcclusionCat("[ Occlusion Cat ]", Float) = 0
		[HDR]_VertexOcclusionColor("Vertex Occlusion Color", Color) = (1,1,1,1)
		[StyledRemapSlider(_VertexOcclusionMinValue, _VertexOcclusionMaxValue, 0, 1)]_VertexOcclusionRemap("Vertex Occlusion Mask", Vector) = (0,0,0,0)
		[HideInInspector]_VertexOcclusionMinValue("Vertex Occlusion Min Value", Range( 0 , 1)) = 0
		[HideInInspector]_VertexOcclusionMaxValue("Vertex Occlusion Max Value", Range( 0 , 1)) = 1
		[StyledCategory(Subsurface Settings)]_SubsurfaceCat("[ Subsurface Cat ]", Float) = 0
		_SubsurfaceValue("Subsurface Intensity", Range( 0 , 1)) = 1
		[HDR]_SubsurfaceColor("Subsurface Color", Color) = (0.4,0.4,0.1,1)
		[StyledRemapSlider(_SubsurfaceMaskMinValue, _SubsurfaceMaskMaxValue,0,1)]_SubsurfaceMaskRemap("Subsurface Mask", Vector) = (0,0,0,0)
		[HideInInspector]_SubsurfaceMaskMinValue("Subsurface Mask Min Value", Range( 0 , 1)) = 0
		[HideInInspector]_SubsurfaceMaskMaxValue("Subsurface Mask Max Value", Range( 0 , 1)) = 1
		[Space(10)][DiffusionProfile]_SubsurfaceDiffusion("Subsurface Diffusion", Float) = 0
		[HideInInspector]_SubsurfaceDiffusion_Asset("Subsurface Diffusion", Vector) = (0,0,0,0)
		[HideInInspector][Space(10)][ASEDiffusionProfile(_SubsurfaceDiffusion)]_SubsurfaceDiffusion_asset("Subsurface Diffusion", Vector) = (0,0,0,0)
		[Space(10)]_MainLightScatteringValue("Subsurface Scattering Intensity", Range( 0 , 16)) = 8
		_MainLightNormalValue("Subsurface Scattering Normal", Range( 0 , 1)) = 0.5
		_MainLightAngleValue("Subsurface Scattering Angle", Range( 0 , 16)) = 8
		[Space(10)]_TranslucencyIntensityValue("Translucency Intensity", Range( 0 , 50)) = 1
		_TranslucencyNormalValue("Translucency Normal", Range( 0 , 1)) = 0.1
		_TranslucencyScatteringValue("Translucency Scattering", Range( 1 , 50)) = 2
		_TranslucencyDirectValue("Translucency Direct", Range( 0 , 1)) = 1
		_TranslucencyAmbientValue("Translucency Ambient", Range( 0 , 1)) = 0.2
		_TranslucencyShadowValue("Translucency Shadow", Range( 0 , 1)) = 1
		[StyledMessage(Warning,  Translucency is not supported in HDRP. Diffusion Profiles will be used instead., 10, 5)]_TranslucencyHDMessage("# Translucency HD Message", Float) = 0
		[StyledCategory(Gradient Settings)]_GradientCat("[ Gradient Cat ]", Float) = 0
		[HDR]_GradientColorOne("Gradient Color One", Color) = (1,1,1,1)
		[HDR]_GradientColorTwo("Gradient Color Two", Color) = (1,1,1,1)
		[StyledRemapSlider(_GradientMinValue, _GradientMaxValue, 0, 1)]_GradientMaskRemap("Gradient Mask", Vector) = (0,0,0,0)
		[HideInInspector]_GradientMinValue("Gradient Mask Min", Range( 0 , 1)) = 0
		[HideInInspector]_GradientMaxValue("Gradient Mask Max ", Range( 0 , 1)) = 1
		[StyledCategory(Noise Settings)]_NoiseCat("[ Noise Cat ]", Float) = 0
		[HDR]_NoiseColorOne("Noise Color One", Color) = (1,1,1,1)
		[HDR]_NoiseColorTwo("Noise Color Two", Color) = (1,1,1,1)
		[StyledRemapSlider(_NoiseMinValue, _NoiseMaxValue, 0, 1)]_NoiseMaskRemap("Noise Mask", Vector) = (0,0,0,0)
		[HideInInspector]_NoiseMinValue("Noise Mask Min", Range( 0 , 1)) = 0
		[HideInInspector]_NoiseMaxValue("Noise Mask Max ", Range( 0 , 1)) = 1
		_NoiseScaleValue("Noise Scale", Range( 0 , 1)) = 0.01
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
		[Space(10)]_MotionAmplitude_32("Details Flutter", Range( 0 , 1)) = 0.2
		[IntRange]_MotionSpeed_32("Details Speed", Range( 0 , 40)) = 4
		_MotionScale_32("Details Scale", Range( 0 , 20)) = 0
		_MotionVariation_32("Details Variation", Range( 0 , 20)) = 2
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
		[HideInInspector]_subsurface_shadow("_subsurface_shadow", Float) = 1
		[HideInInspector]_IsLeafShader("_IsLeafShader", Float) = 1
		[HideInInspector]_IsSubsurfaceShader("_IsSubsurfaceShader", Float) = 1
		[HideInInspector]_render_cull("_render_cull", Float) = 0
		[HideInInspector]_render_src("_render_src", Float) = 5
		[HideInInspector]_render_dst("_render_dst", Float) = 10
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
		#include "UnityPBSLighting.cginc"
		#pragma target 4.0
		#pragma shader_feature_local TVE_ALPHA_CLIP
		#pragma shader_feature_local TVE_VERTEX_DATA_BATCHED
		//TVE Shader Type Defines
		#define TVE_IS_VEGETATION_SHADER
		//TVE Pipeline Defines
		#define THE_VEGETATION_ENGINE
		#define TVE_IS_STANDARD_PIPELINE
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

		#pragma surface surf StandardSpecularCustom keepalpha addshadow fullforwardshadows exclude_path:deferred dithercrossfade vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 vertexToFrag11_g67503;
			half ASEVFace : VFACE;
			float3 vertexToFrag11_g67538;
			float3 vertexToFrag11_g67537;
			float vertexToFrag11_g67482;
			float3 vertexToFrag3890_g67473;
			float4 vertexColor : COLOR;
			float3 worldNormal;
			INTERNAL_DATA
			float3 vertexToFrag11_g67531;
			float2 vertexToFrag11_g67515;
			float vertexToFrag11_g67477;
		};

		struct SurfaceOutputStandardSpecularCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half3 Specular;
			half Smoothness;
			half Occlusion;
			half Alpha;
			half3 Transmission;
		};

		uniform half _IsLeafShader;
		uniform half _render_cull;
		uniform half _IsSubsurfaceShader;
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
		uniform half _subsurface_shadow;
		uniform half _render_dst;
		uniform half _render_src;
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
		uniform float _MotionScale_32;
		uniform float _MotionSpeed_32;
		uniform float _MotionVariation_32;
		uniform half _MotionAmplitude_32;
		uniform half TVE_MotionFadeEnd;
		uniform half TVE_MotionFadeStart;
		uniform half _VertexDataMode;
		uniform half _GlobalSize;
		uniform half _DisableSRPBatcher;
		uniform sampler2D _MainNormalTex;
		uniform half4 _MainUVs;
		uniform half _MainNormalValue;
		uniform half3 _render_normals_options;
		uniform half4 _GradientColorTwo;
		uniform half4 _GradientColorOne;
		uniform half _GradientMinValue;
		uniform half _GradientMaxValue;
		uniform half4 _NoiseColorTwo;
		uniform half4 _NoiseColorOne;
		uniform sampler3D TVE_WorldTex3D;
		uniform half _NoiseScaleValue;
		uniform half _NoiseMinValue;
		uniform half _NoiseMaxValue;
		uniform half4 _MainColor;
		uniform sampler2D _MainAlbedoTex;
		uniform half4 TVE_ColorsParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ColorsTex);
		uniform half4 TVE_ColorsCoord;
		uniform half _LayerColorsValue;
		SamplerState samplerTVE_ColorsTex;
		uniform float TVE_ColorsUsage[9];
		uniform half _GlobalColors;
		uniform half _ColorsVariationValue;
		uniform sampler2D _MainMaskTex;
		uniform half _ColorsMaskMinValue;
		uniform half _ColorsMaskMaxValue;
		uniform half4 _SubsurfaceColor;
		uniform half _SubsurfaceValue;
		uniform half4 TVE_MainLightParams;
		uniform half _SubsurfaceMaskMinValue;
		uniform half _SubsurfaceMaskMaxValue;
		uniform half3 TVE_MainLightDirection;
		uniform half _MainLightAngleValue;
		uniform half _MainLightScatteringValue;
		uniform half _MainLightNormalValue;
		uniform half4 TVE_OverlayColor;
		uniform half _OverlayBottomValue;
		uniform half _GlobalOverlay;
		uniform half4 TVE_ExtrasParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ExtrasTex);
		uniform half4 TVE_ExtrasCoord;
		uniform half _LayerExtrasValue;
		SamplerState samplerTVE_ExtrasTex;
		uniform float TVE_ExtrasUsage[9];
		uniform half _OverlayVariationValue;
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
		uniform half TVE_OverlaySmoothness;
		uniform half _GlobalWetness;
		uniform half _MainOcclusionValue;
		uniform half _FadeGlancingValue;
		uniform half TVE_CameraFadeStart;
		uniform half TVE_CameraFadeEnd;
		uniform half _FadeCameraValue;
		uniform sampler3D TVE_ScreenTex3D;
		uniform half TVE_ScreenTexCoord;
		uniform half _AlphaVariationValue;
		uniform half _GlobalAlpha;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VertexPosition3588_g67473 = ase_vertex3Pos;
			half3 Mesh_PivotsOS2291_g67473 = half3(0,0,0);
			float3 temp_output_2283_0_g67473 = ( VertexPosition3588_g67473 - Mesh_PivotsOS2291_g67473 );
			half3 VertexPos40_g67495 = temp_output_2283_0_g67473;
			float3 appendResult74_g67495 = (float3(VertexPos40_g67495.x , 0.0 , 0.0));
			half3 VertexPosRotationAxis50_g67495 = appendResult74_g67495;
			float3 break84_g67495 = VertexPos40_g67495;
			float3 appendResult81_g67495 = (float3(0.0 , break84_g67495.y , break84_g67495.z));
			half3 VertexPosOtherAxis82_g67495 = appendResult81_g67495;
			half ObjectData20_g67534 = 3.14;
			float Bounds_Height374_g67473 = _MaxBoundsInfo.y;
			half WorldData19_g67534 = ( Bounds_Height374_g67473 * 3.14 );
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g67534 = WorldData19_g67534;
			#else
				float staticSwitch14_g67534 = ObjectData20_g67534;
			#endif
			float Motion_Max_Bending1133_g67473 = staticSwitch14_g67534;
			float4x4 break19_g67497 = unity_ObjectToWorld;
			float3 appendResult20_g67497 = (float3(break19_g67497[ 0 ][ 3 ] , break19_g67497[ 1 ][ 3 ] , break19_g67497[ 2 ][ 3 ]));
			half3 ObjectData20_g67498 = appendResult20_g67497;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half3 WorldData19_g67498 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g67498 = WorldData19_g67498;
			#else
				float3 staticSwitch14_g67498 = ObjectData20_g67498;
			#endif
			float3 temp_output_114_0_g67497 = staticSwitch14_g67498;
			float3 vertexToFrag4224_g67473 = temp_output_114_0_g67497;
			half3 ObjectData20_g67511 = vertexToFrag4224_g67473;
			float3 vertexToFrag3890_g67473 = ase_worldPos;
			half3 WorldData19_g67511 = vertexToFrag3890_g67473;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g67511 = WorldData19_g67511;
			#else
				float3 staticSwitch14_g67511 = ObjectData20_g67511;
			#endif
			float3 ObjectPosition4223_g67473 = staticSwitch14_g67511;
			float3 Position83_g67540 = ObjectPosition4223_g67473;
			float temp_output_84_0_g67540 = _LayerMotionValue;
			float4 lerpResult87_g67540 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, samplerTVE_MotionTex, float3(( (TVE_MotionCoord).zw + ( (TVE_MotionCoord).xy * (Position83_g67540).xz ) ),temp_output_84_0_g67540), 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g67540]);
			half4 Global_Motion_Params3909_g67473 = lerpResult87_g67540;
			float4 break322_g67490 = Global_Motion_Params3909_g67473;
			half Wind_Power369_g67490 = break322_g67490.z;
			float lerpResult376_g67490 = lerp( TVE_MotionParamsMin.x , TVE_MotionParamsMax.x , Wind_Power369_g67490);
			half Wind_Power_103106_g67473 = lerpResult376_g67490;
			float2 panner73_g67483 = ( _Time.y * (TVE_NoiseParams).xy + ( (ObjectPosition4223_g67473).xz * TVE_NoiseParams.z ));
			float4 tex2DNode75_g67483 = tex2Dlod( TVE_NoiseTex, float4( panner73_g67483, 0, 0.0) );
			float4 saferPower77_g67483 = max( abs( tex2DNode75_g67483 ) , 0.0001 );
			half Wind_Power2223_g67473 = Wind_Power369_g67490;
			float temp_output_167_0_g67483 = Wind_Power2223_g67473;
			float lerpResult168_g67483 = lerp( 1.4 , 0.2 , temp_output_167_0_g67483);
			float4 temp_cast_3 = (lerpResult168_g67483).xxxx;
			float4 break174_g67483 = pow( saferPower77_g67483 , temp_cast_3 );
			half Global_NoiseTex_R34_g67473 = break174_g67483.r;
			float3 appendResult397_g67490 = (float3(break322_g67490.x , 0.0 , break322_g67490.y));
			float3 temp_output_398_0_g67490 = (appendResult397_g67490*2.0 + -1.0);
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 temp_output_339_0_g67490 = ( mul( unity_WorldToObject, float4( temp_output_398_0_g67490 , 0.0 ) ).xyz * ase_parentObjectScale );
			half2 Wind_DirectionOS39_g67473 = (temp_output_339_0_g67490).xz;
			half Input_Speed62_g67496 = _MotionSpeed_10;
			float mulTime373_g67496 = _Time.y * Input_Speed62_g67496;
			float3 break111_g67519 = ObjectPosition4223_g67473;
			half Variation_Complex102_g67519 = frac( ( v.color.r + ( break111_g67519.x + break111_g67519.z ) ) );
			half ObjectData20_g67520 = Variation_Complex102_g67519;
			half Variation_Simple105_g67519 = v.color.r;
			half WorldData19_g67520 = Variation_Simple105_g67519;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g67520 = WorldData19_g67520;
			#else
				float staticSwitch14_g67520 = ObjectData20_g67520;
			#endif
			half Motion_Variation3073_g67473 = staticSwitch14_g67520;
			half Motion_Variation284_g67496 = ( _MotionVariation_10 * Motion_Variation3073_g67473 );
			float Motion_Scale287_g67496 = ( _MotionScale_10 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
			half Sine_MinusOneToOne281_g67496 = sin( ( mulTime373_g67496 + Motion_Variation284_g67496 + Motion_Scale287_g67496 ) );
			half Wind_Squash4479_g67473 = break322_g67490.w;
			half Input_WindSquash419_g67496 = Wind_Squash4479_g67473;
			half Input_WindPower327_g67496 = Wind_Power_103106_g67473;
			float lerpResult321_g67496 = lerp( Sine_MinusOneToOne281_g67496 , (Sine_MinusOneToOne281_g67496*Input_WindSquash419_g67496 + 1.0) , Input_WindPower327_g67496);
			half Mesh_Motion_1082_g67473 = v.texcoord3.x;
			half2 Motion_10_Bending2258_g67473 = ( ( _MotionAmplitude_10 * Motion_Max_Bending1133_g67473 ) * Wind_Power_103106_g67473 * Global_NoiseTex_R34_g67473 * Wind_DirectionOS39_g67473 * lerpResult321_g67496 * Mesh_Motion_1082_g67473 );
			half Interaction_Amplitude4137_g67473 = _InteractionAmplitude;
			float3 Position83_g67485 = ObjectPosition4223_g67473;
			float temp_output_84_0_g67485 = _LayerReactValue;
			float4 lerpResult87_g67485 = lerp( TVE_ReactParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ReactTex, samplerTVE_ReactTex, float3(( (TVE_ReactCoord).zw + ( (TVE_ReactCoord).xy * (Position83_g67485).xz ) ),temp_output_84_0_g67485), 0.0 ) , TVE_ReactUsage[(int)temp_output_84_0_g67485]);
			half4 Global_React_Params4173_g67473 = lerpResult87_g67485;
			float4 break322_g67478 = Global_React_Params4173_g67473;
			half Interaction_Mask66_g67473 = break322_g67478.z;
			float3 appendResult397_g67478 = (float3(break322_g67478.x , 0.0 , break322_g67478.y));
			float3 temp_output_398_0_g67478 = (appendResult397_g67478*2.0 + -1.0);
			float3 temp_output_339_0_g67478 = ( mul( unity_WorldToObject, float4( temp_output_398_0_g67478 , 0.0 ) ).xyz * ase_parentObjectScale );
			half2 Interaction_DirectionOS4158_g67473 = (temp_output_339_0_g67478).xz;
			float lerpResult4494_g67473 = lerp( 1.0 , Mesh_Motion_1082_g67473 , _InteractionMaskValue);
			half2 Motion_10_Interaction53_g67473 = ( Interaction_Amplitude4137_g67473 * Motion_Max_Bending1133_g67473 * Interaction_Mask66_g67473 * Interaction_Mask66_g67473 * Interaction_DirectionOS4158_g67473 * lerpResult4494_g67473 );
			float2 lerpResult109_g67473 = lerp( Motion_10_Bending2258_g67473 , Motion_10_Interaction53_g67473 , ( Interaction_Mask66_g67473 * saturate( Interaction_Amplitude4137_g67473 ) ));
			float2 break143_g67473 = lerpResult109_g67473;
			half Motion_10_ZAxis190_g67473 = break143_g67473.y;
			half Angle44_g67495 = Motion_10_ZAxis190_g67473;
			half3 VertexPos40_g67507 = ( VertexPosRotationAxis50_g67495 + ( VertexPosOtherAxis82_g67495 * cos( Angle44_g67495 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g67495 ) * sin( Angle44_g67495 ) ) );
			float3 appendResult74_g67507 = (float3(0.0 , 0.0 , VertexPos40_g67507.z));
			half3 VertexPosRotationAxis50_g67507 = appendResult74_g67507;
			float3 break84_g67507 = VertexPos40_g67507;
			float3 appendResult81_g67507 = (float3(break84_g67507.x , break84_g67507.y , 0.0));
			half3 VertexPosOtherAxis82_g67507 = appendResult81_g67507;
			half Motion_10_XAxis216_g67473 = break143_g67473.x;
			half Angle44_g67507 = -Motion_10_XAxis216_g67473;
			half3 VertexPos40_g67530 = ( VertexPosRotationAxis50_g67507 + ( VertexPosOtherAxis82_g67507 * cos( Angle44_g67507 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g67507 ) * sin( Angle44_g67507 ) ) );
			float3 appendResult74_g67530 = (float3(0.0 , VertexPos40_g67530.y , 0.0));
			float3 VertexPosRotationAxis50_g67530 = appendResult74_g67530;
			float3 break84_g67530 = VertexPos40_g67530;
			float3 appendResult81_g67530 = (float3(break84_g67530.x , 0.0 , break84_g67530.z));
			float3 VertexPosOtherAxis82_g67530 = appendResult81_g67530;
			half Motion_20_Mode4258_g67473 = _VertexRollingMode;
			half Mesh_Motion_2060_g67473 = v.texcoord3.y;
			float lerpResult410_g67490 = lerp( TVE_MotionParamsMin.y , TVE_MotionParamsMax.y , Wind_Power369_g67490);
			half Wind_Power_203109_g67473 = lerpResult410_g67490;
			half Motion_20_Variation4255_g67473 = ( _MotionVariation_20 * Motion_Variation3073_g67473 );
			half Variation127_g67484 = ( Motion_20_Variation4255_g67473 * Motion_Variation3073_g67473 );
			float mulTime131_g67484 = _Time.y * 0.5;
			float temp_output_134_0_g67484 = (sin( ( Variation127_g67484 + mulTime131_g67484 ) )*0.5 + 0.5);
			float temp_output_112_0_g67484 = Wind_Power2223_g67473;
			float lerpResult136_g67484 = lerp( ( temp_output_134_0_g67484 * temp_output_134_0_g67484 * temp_output_134_0_g67484 * temp_output_134_0_g67484 ) , 1.0 , ( temp_output_112_0_g67484 * temp_output_112_0_g67484 ));
			float lerpResult126_g67484 = lerp( lerpResult136_g67484 , 1.0 , ( 1.0 - saturate( Variation127_g67484 ) ));
			half Motion_Selective4260_g67473 = lerpResult126_g67484;
			half Motion_20_Commons4381_g67473 = ( Motion_20_Mode4258_g67473 * Mesh_Motion_2060_g67473 * Wind_Power_203109_g67473 * Global_NoiseTex_R34_g67473 * Motion_Selective4260_g67473 );
			half Motion_20_Speed4257_g67473 = _MotionSpeed_20;
			half Input_Speed62_g67486 = Motion_20_Speed4257_g67473;
			float mulTime354_g67486 = _Time.y * Input_Speed62_g67486;
			float Motion_Variation284_g67486 = Motion_20_Variation4255_g67473;
			half Motion_20_Scale4256_g67473 = _MotionScale_20;
			float Motion_Scale287_g67486 = ( Motion_20_Scale4256_g67473 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
			half Motion_20_SineWaveA4382_g67473 = sin( ( mulTime354_g67486 + Motion_Variation284_g67486 + Motion_Scale287_g67486 ) );
			half ObjectData20_g67488 = 3.14;
			float Bounds_Radius121_g67473 = _MaxBoundsInfo.x;
			half WorldData19_g67488 = Bounds_Radius121_g67473;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g67488 = WorldData19_g67488;
			#else
				float staticSwitch14_g67488 = ObjectData20_g67488;
			#endif
			float Motion_Max_Rolling1137_g67473 = staticSwitch14_g67488;
			half Motion_20_Rolling138_g67473 = ( _MotionAmplitude_20 * Motion_20_Commons4381_g67473 * Motion_20_SineWaveA4382_g67473 * Motion_Max_Rolling1137_g67473 );
			half Angle44_g67530 = Motion_20_Rolling138_g67473;
			half Input_Speed62_g67518 = ( Motion_20_Speed4257_g67473 - 1.0 );
			float mulTime354_g67518 = _Time.y * Input_Speed62_g67518;
			float Motion_Variation284_g67518 = Motion_20_Variation4255_g67473;
			float Motion_Scale287_g67518 = ( Motion_20_Scale4256_g67473 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
			half Motion_20_SineWaveB4460_g67473 = sin( ( mulTime354_g67518 + Motion_Variation284_g67518 + Motion_Scale287_g67518 ) );
			float3 appendResult4393_g67473 = (float3(0.0 , ( _MotionAmplitude_21 * Motion_20_Commons4381_g67473 * Motion_20_SineWaveB4460_g67473 * Bounds_Radius121_g67473 ) , 0.0));
			half3 Motion_20_Vertical4280_g67473 = appendResult4393_g67473;
			float2 break4421_g67473 = ( ( _MotionAmplitude_22 * Motion_20_Commons4381_g67473 * ( Bounds_Radius121_g67473 * 2.0 ) * (Motion_20_SineWaveA4382_g67473*Wind_Squash4479_g67473 + 1.0) ) * Wind_DirectionOS39_g67473 );
			float3 appendResult4417_g67473 = (float3(break4421_g67473.x , 0.0 , break4421_g67473.y));
			half3 Motion_20_Squash4418_g67473 = appendResult4417_g67473;
			half Motion_Scale321_g67522 = ( _MotionScale_32 * 10.0 );
			half Input_Speed62_g67522 = _MotionSpeed_32;
			float mulTime349_g67522 = _Time.y * Input_Speed62_g67522;
			float Motion_Variation330_g67522 = ( _MotionVariation_32 * Motion_Variation3073_g67473 );
			half Input_Amplitude58_g67522 = ( _MotionAmplitude_32 * Bounds_Radius121_g67473 * 0.1 );
			float3 temp_output_299_0_g67522 = ( sin( ( ( ase_worldPos * Motion_Scale321_g67522 ) + mulTime349_g67522 + Motion_Variation330_g67522 ) ) * Input_Amplitude58_g67522 );
			half Mesh_Motion_30144_g67473 = v.texcoord3.z;
			float lerpResult378_g67490 = lerp( TVE_MotionParamsMin.z , TVE_MotionParamsMax.z , Wind_Power369_g67490);
			half Wind_Power_303115_g67473 = lerpResult378_g67490;
			float temp_output_7_0_g67529 = TVE_MotionFadeEnd;
			half Wind_FadeOut4005_g67473 = saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g67529 ) / ( TVE_MotionFadeStart - temp_output_7_0_g67529 ) ) );
			half3 Motion_30_Details263_g67473 = ( temp_output_299_0_g67522 * ( Global_NoiseTex_R34_g67473 * Mesh_Motion_30144_g67473 * Wind_Power_303115_g67473 * Wind_FadeOut4005_g67473 * Motion_Selective4260_g67473 ) );
			float3 Vertex_Motion_Object833_g67473 = ( ( ( VertexPosRotationAxis50_g67530 + ( VertexPosOtherAxis82_g67530 * cos( Angle44_g67530 ) ) + ( cross( float3(0,1,0) , VertexPosOtherAxis82_g67530 ) * sin( Angle44_g67530 ) ) ) + Motion_20_Vertical4280_g67473 + Motion_20_Squash4418_g67473 ) + Motion_30_Details263_g67473 );
			float3 temp_output_3474_0_g67473 = ( VertexPosition3588_g67473 - Mesh_PivotsOS2291_g67473 );
			float3 appendResult2043_g67473 = (float3(Motion_10_XAxis216_g67473 , 0.0 , Motion_10_ZAxis190_g67473));
			float3 appendResult2047_g67473 = (float3(Motion_20_Rolling138_g67473 , 0.0 , -Motion_20_Rolling138_g67473));
			float3 Vertex_Motion_World1118_g67473 = ( ( ( temp_output_3474_0_g67473 + appendResult2043_g67473 ) + appendResult2047_g67473 + Motion_20_Vertical4280_g67473 + Motion_20_Squash4418_g67473 ) + Motion_30_Details263_g67473 );
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch3312_g67473 = Vertex_Motion_World1118_g67473;
			#else
				float3 staticSwitch3312_g67473 = ( Vertex_Motion_Object833_g67473 + ( 0.0 * _VertexDataMode ) );
			#endif
			half Global_Vertex_Size174_g67473 = break322_g67478.w;
			float lerpResult346_g67473 = lerp( 1.0 , Global_Vertex_Size174_g67473 , _GlobalSize);
			float3 appendResult3480_g67473 = (float3(lerpResult346_g67473 , lerpResult346_g67473 , lerpResult346_g67473));
			half3 ObjectData20_g67526 = appendResult3480_g67473;
			half3 _Vector11 = half3(1,1,1);
			half3 WorldData19_g67526 = _Vector11;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g67526 = WorldData19_g67526;
			#else
				float3 staticSwitch14_g67526 = ObjectData20_g67526;
			#endif
			half3 Vertex_Size1741_g67473 = staticSwitch14_g67526;
			half3 _Vector5 = half3(1,1,1);
			float3 Vertex_SizeFade1740_g67473 = _Vector5;
			half3 Grass_Coverage2661_g67473 = half3(0,0,0);
			float3 Final_VertexPosition890_g67473 = ( ( ( staticSwitch3312_g67473 * Vertex_Size1741_g67473 * Vertex_SizeFade1740_g67473 ) + Mesh_PivotsOS2291_g67473 + Grass_Coverage2661_g67473 ) + _DisableSRPBatcher );
			v.vertex.xyz = Final_VertexPosition890_g67473;
			v.vertex.w = 1;
			o.vertexToFrag11_g67503 = ( ( v.texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
			float temp_output_7_0_g67480 = _GradientMinValue;
			float4 lerpResult2779_g67473 = lerp( _GradientColorTwo , _GradientColorOne , saturate( ( ( v.color.a - temp_output_7_0_g67480 ) / ( _GradientMaxValue - temp_output_7_0_g67480 ) ) ));
			half3 Gradient_Tint2784_g67473 = (lerpResult2779_g67473).rgb;
			o.vertexToFrag11_g67538 = Gradient_Tint2784_g67473;
			float3 temp_cast_11 = (_NoiseScaleValue).xxx;
			float3 WorldPosition3905_g67473 = vertexToFrag3890_g67473;
			float temp_output_7_0_g67516 = _NoiseMinValue;
			half Noise_Mask3162_g67473 = saturate( ( ( tex3Dlod( TVE_WorldTex3D, float4( ( temp_cast_11 * WorldPosition3905_g67473 * 0.1 ), 0.0) ).r - temp_output_7_0_g67516 ) / ( _NoiseMaxValue - temp_output_7_0_g67516 ) ) );
			float4 lerpResult2800_g67473 = lerp( _NoiseColorTwo , _NoiseColorOne , Noise_Mask3162_g67473);
			half3 Noise_Tint2802_g67473 = (lerpResult2800_g67473).rgb;
			o.vertexToFrag11_g67537 = Noise_Tint2802_g67473;
			float3 Position58_g67481 = WorldPosition3905_g67473;
			float temp_output_82_0_g67481 = _LayerColorsValue;
			float4 lerpResult88_g67481 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, samplerTVE_ColorsTex, float3(( (TVE_ColorsCoord).zw + ( (TVE_ColorsCoord).xy * (Position58_g67481).xz ) ),temp_output_82_0_g67481), 0.0 ) , TVE_ColorsUsage[(int)temp_output_82_0_g67481]);
			half Global_ColorsTex_A1701_g67473 = (lerpResult88_g67481).a;
			o.vertexToFrag11_g67482 = Global_ColorsTex_A1701_g67473;
			o.vertexToFrag3890_g67473 = ase_worldPos;
			float3 temp_cast_14 = (1.0).xxx;
			float Mesh_Occlusion318_g67473 = v.color.g;
			float temp_output_7_0_g67510 = _VertexOcclusionMinValue;
			float3 lerpResult2945_g67473 = lerp( (_VertexOcclusionColor).rgb , temp_cast_14 , saturate( ( ( Mesh_Occlusion318_g67473 - temp_output_7_0_g67510 ) / ( _VertexOcclusionMaxValue - temp_output_7_0_g67510 ) ) ));
			o.vertexToFrag11_g67531 = lerpResult2945_g67473;
			o.vertexToFrag11_g67515 = ( ( v.texcoord.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
			float temp_output_7_0_g67509 = TVE_CameraFadeStart;
			float saferPower3976_g67473 = max( saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g67509 ) / ( TVE_CameraFadeEnd - temp_output_7_0_g67509 ) ) ) , 0.0001 );
			float temp_output_3976_0_g67473 = pow( saferPower3976_g67473 , _FadeCameraValue );
			o.vertexToFrag11_g67477 = temp_output_3976_0_g67473;
		}

		inline half4 LightingStandardSpecularCustom(SurfaceOutputStandardSpecularCustom s, half3 viewDir, UnityGI gi )
		{
			half3 transmission = max(0 , -dot(s.Normal, gi.light.dir)) * gi.light.color * s.Transmission;
			half4 d = half4(s.Albedo * transmission , 0);

			SurfaceOutputStandardSpecular r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Specular = s.Specular;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandardSpecular (r, viewDir, gi) + d;
		}

		inline void LightingStandardSpecularCustom_GI(SurfaceOutputStandardSpecularCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardSpecularCustom o )
		{
			half2 Main_UVs15_g67473 = i.vertexToFrag11_g67503;
			half3 Main_Normal137_g67473 = UnpackScaleNormal( tex2D( _MainNormalTex, Main_UVs15_g67473 ), _MainNormalValue );
			float3 temp_output_13_0_g67494 = Main_Normal137_g67473;
			float3 switchResult12_g67494 = (((i.ASEVFace>0)?(temp_output_13_0_g67494):(( temp_output_13_0_g67494 * _render_normals_options ))));
			half3 Blend_Normal312_g67473 = switchResult12_g67494;
			half3 Final_Normal366_g67473 = Blend_Normal312_g67473;
			o.Normal = Final_Normal366_g67473;
			half Leaves_Mask4511_g67473 = 1.0;
			float3 lerpResult4521_g67473 = lerp( float3( 1,1,1 ) , ( i.vertexToFrag11_g67538 * i.vertexToFrag11_g67537 * float3(1,1,1) ) , Leaves_Mask4511_g67473);
			float3 lerpResult4519_g67473 = lerp( float3( 1,1,1 ) , (_MainColor).rgb , Leaves_Mask4511_g67473);
			float4 tex2DNode29_g67473 = tex2D( _MainAlbedoTex, Main_UVs15_g67473 );
			half3 Main_Albedo99_g67473 = ( lerpResult4519_g67473 * (tex2DNode29_g67473).rgb );
			half3 Blend_Albedo265_g67473 = Main_Albedo99_g67473;
			half3 Blend_AlbedoTinted2808_g67473 = ( lerpResult4521_g67473 * Blend_Albedo265_g67473 );
			float dotResult3616_g67473 = dot( Blend_AlbedoTinted2808_g67473 , float3(0.2126,0.7152,0.0722) );
			float3 temp_cast_1 = (dotResult3616_g67473).xxx;
			half Global_Colors_Influence3668_g67473 = i.vertexToFrag11_g67482;
			float3 lerpResult3618_g67473 = lerp( Blend_AlbedoTinted2808_g67473 , temp_cast_1 , Global_Colors_Influence3668_g67473);
			float3 WorldPosition3905_g67473 = i.vertexToFrag3890_g67473;
			float3 Position58_g67481 = WorldPosition3905_g67473;
			float temp_output_82_0_g67481 = _LayerColorsValue;
			float4 lerpResult88_g67481 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ColorsTex, samplerTVE_ColorsTex, float3(( (TVE_ColorsCoord).zw + ( (TVE_ColorsCoord).xy * (Position58_g67481).xz ) ),temp_output_82_0_g67481) ) , TVE_ColorsUsage[(int)temp_output_82_0_g67481]);
			half3 Global_ColorsTex_RGB1700_g67473 = (lerpResult88_g67481).rgb;
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g67517 = 2.0;
			#else
				float staticSwitch1_g67517 = 4.594794;
			#endif
			half3 Global_Colors1954_g67473 = ( Global_ColorsTex_RGB1700_g67473 * staticSwitch1_g67517 );
			float lerpResult3870_g67473 = lerp( 1.0 , i.vertexColor.r , _ColorsVariationValue);
			half Global_Colors_Value3650_g67473 = ( _GlobalColors * lerpResult3870_g67473 );
			float4 tex2DNode35_g67473 = tex2D( _MainMaskTex, Main_UVs15_g67473 );
			half Main_Mask57_g67473 = tex2DNode35_g67473.b;
			float temp_output_7_0_g67532 = _ColorsMaskMinValue;
			half Global_Colors_Mask3692_g67473 = saturate( ( ( Main_Mask57_g67473 - temp_output_7_0_g67532 ) / ( _ColorsMaskMaxValue - temp_output_7_0_g67532 ) ) );
			float3 lerpResult3628_g67473 = lerp( Blend_AlbedoTinted2808_g67473 , ( lerpResult3618_g67473 * Global_Colors1954_g67473 ) , ( Global_Colors_Value3650_g67473 * Global_Colors_Mask3692_g67473 ));
			half3 Blend_AlbedoColored863_g67473 = lerpResult3628_g67473;
			float3 temp_output_799_0_g67473 = (_SubsurfaceColor).rgb;
			float dotResult3930_g67473 = dot( temp_output_799_0_g67473 , float3(0.2126,0.7152,0.0722) );
			float3 temp_cast_4 = (dotResult3930_g67473).xxx;
			float3 lerpResult3932_g67473 = lerp( temp_output_799_0_g67473 , temp_cast_4 , Global_Colors_Influence3668_g67473);
			float3 lerpResult3942_g67473 = lerp( temp_output_799_0_g67473 , ( lerpResult3932_g67473 * Global_Colors1954_g67473 ) , ( Global_Colors_Value3650_g67473 * Global_Colors_Mask3692_g67473 ));
			half3 Subsurface_Color1722_g67473 = lerpResult3942_g67473;
			half MainLight_Subsurface4041_g67473 = TVE_MainLightParams.a;
			half Subsurface_Intensity1752_g67473 = ( _SubsurfaceValue * MainLight_Subsurface4041_g67473 );
			float temp_output_7_0_g67489 = _SubsurfaceMaskMinValue;
			half Subsurface_Mask1557_g67473 = saturate( ( ( Main_Mask57_g67473 - temp_output_7_0_g67489 ) / ( _SubsurfaceMaskMaxValue - temp_output_7_0_g67489 ) ) );
			half3 Subsurface_Transmission884_g67473 = ( Subsurface_Color1722_g67473 * Subsurface_Intensity1752_g67473 * Subsurface_Mask1557_g67473 );
			half3 MainLight_Direction3926_g67473 = TVE_MainLightDirection;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult2169_g67473 = normalize( ase_worldViewDir );
			float3 ViewDir_Normalized3963_g67473 = normalizeResult2169_g67473;
			float dotResult785_g67473 = dot( -MainLight_Direction3926_g67473 , ViewDir_Normalized3963_g67473 );
			float saferPower1624_g67473 = max( (dotResult785_g67473*0.5 + 0.5) , 0.0001 );
			#ifdef UNITY_PASS_FORWARDADD
				float staticSwitch1602_g67473 = 0.0;
			#else
				float staticSwitch1602_g67473 = ( pow( saferPower1624_g67473 , _MainLightAngleValue ) * _MainLightScatteringValue );
			#endif
			half Mask_Subsurface_View782_g67473 = staticSwitch1602_g67473;
			float3 Main_Normal_WS4101_g67473 = (WorldNormalVector( i , Main_Normal137_g67473 ));
			float dotResult777_g67473 = dot( MainLight_Direction3926_g67473 , Main_Normal_WS4101_g67473 );
			float lerpResult4198_g67473 = lerp( 1.0 , saturate( dotResult777_g67473 ) , _MainLightNormalValue);
			#ifdef UNITY_PASS_FORWARDADD
				float staticSwitch1604_g67473 = 0.0;
			#else
				float staticSwitch1604_g67473 = lerpResult4198_g67473;
			#endif
			half Mask_Subsurface_Normal870_g67473 = staticSwitch1604_g67473;
			half3 Subsurface_Scattering1693_g67473 = ( Subsurface_Transmission884_g67473 * Blend_AlbedoColored863_g67473 * ( Mask_Subsurface_View782_g67473 * Mask_Subsurface_Normal870_g67473 ) );
			half3 Blend_AlbedoAndSubsurface149_g67473 = ( Blend_AlbedoColored863_g67473 + Subsurface_Scattering1693_g67473 );
			half3 Global_OverlayColor1758_g67473 = (TVE_OverlayColor).rgb;
			float lerpResult3567_g67473 = lerp( _OverlayBottomValue , 1.0 , Main_Normal_WS4101_g67473.y);
			half Main_AlbedoTex_G3526_g67473 = tex2DNode29_g67473.g;
			float3 Position82_g67525 = WorldPosition3905_g67473;
			float temp_output_84_0_g67525 = _LayerExtrasValue;
			float4 lerpResult88_g67525 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, float3(( (TVE_ExtrasCoord).zw + ( (TVE_ExtrasCoord).xy * (Position82_g67525).xz ) ),temp_output_84_0_g67525) ) , TVE_ExtrasUsage[(int)temp_output_84_0_g67525]);
			float4 break89_g67525 = lerpResult88_g67525;
			half Global_Extras_Overlay156_g67473 = break89_g67525.b;
			float temp_output_1025_0_g67473 = ( _GlobalOverlay * Global_Extras_Overlay156_g67473 );
			float lerpResult1065_g67473 = lerp( 1.0 , i.vertexColor.r , _OverlayVariationValue);
			half Overlay_Commons1365_g67473 = ( temp_output_1025_0_g67473 * lerpResult1065_g67473 );
			float temp_output_7_0_g67501 = _OverlayMaskMinValue;
			half Overlay_Mask269_g67473 = saturate( ( ( ( ( ( lerpResult3567_g67473 * 0.5 ) + Main_AlbedoTex_G3526_g67473 ) * Overlay_Commons1365_g67473 ) - temp_output_7_0_g67501 ) / ( _OverlayMaskMaxValue - temp_output_7_0_g67501 ) ) );
			float3 lerpResult336_g67473 = lerp( Blend_AlbedoAndSubsurface149_g67473 , Global_OverlayColor1758_g67473 , Overlay_Mask269_g67473);
			half3 Final_Albedo359_g67473 = lerpResult336_g67473;
			float3 Vertex_Occlusion648_g67473 = saturate( i.vertexToFrag11_g67531 );
			o.Albedo = ( Final_Albedo359_g67473 * Vertex_Occlusion648_g67473 );
			float4 temp_output_4214_0_g67473 = ( _EmissiveColor * _EmissiveIntensityParams.x );
			half2 Emissive_UVs2468_g67473 = i.vertexToFrag11_g67515;
			half Global_Extras_Emissive4203_g67473 = break89_g67525.r;
			float lerpResult4206_g67473 = lerp( 1.0 , Global_Extras_Emissive4203_g67473 , _GlobalEmissive);
			half3 Final_Emissive2476_g67473 = ( (( temp_output_4214_0_g67473 * tex2D( _EmissiveTex, Emissive_UVs2468_g67473 ) )).rgb * lerpResult4206_g67473 );
			o.Emission = Final_Emissive2476_g67473;
			float3 temp_cast_7 = (( 0.04 * _RenderSpecular )).xxx;
			o.Specular = temp_cast_7;
			half Main_Smoothness227_g67473 = ( tex2DNode35_g67473.a * _MainSmoothnessValue );
			half Blend_Smoothness314_g67473 = Main_Smoothness227_g67473;
			half Global_OverlaySmoothness311_g67473 = TVE_OverlaySmoothness;
			float lerpResult343_g67473 = lerp( Blend_Smoothness314_g67473 , Global_OverlaySmoothness311_g67473 , Overlay_Mask269_g67473);
			half Final_Smoothness371_g67473 = lerpResult343_g67473;
			half Global_Extras_Wetness305_g67473 = break89_g67525.g;
			float lerpResult3673_g67473 = lerp( 0.0 , Global_Extras_Wetness305_g67473 , _GlobalWetness);
			half Final_SmoothnessAndWetness4130_g67473 = saturate( ( Final_Smoothness371_g67473 + lerpResult3673_g67473 ) );
			o.Smoothness = Final_SmoothnessAndWetness4130_g67473;
			float lerpResult240_g67473 = lerp( 1.0 , tex2DNode35_g67473.g , _MainOcclusionValue);
			half Main_Occlusion247_g67473 = lerpResult240_g67473;
			half Blend_Occlusion323_g67473 = Main_Occlusion247_g67473;
			o.Occlusion = Blend_Occlusion323_g67473;
			o.Transmission = Subsurface_Transmission884_g67473;
			float localCustomAlphaClip3735_g67473 = ( 0.0 );
			float3 normalizeResult3971_g67473 = normalize( cross( ddy( ase_worldPos ) , ddx( ase_worldPos ) ) );
			float3 NormalsWS_Derivates3972_g67473 = normalizeResult3971_g67473;
			float dotResult3851_g67473 = dot( ViewDir_Normalized3963_g67473 , NormalsWS_Derivates3972_g67473 );
			float lerpResult3993_g67473 = lerp( 1.0 , abs( dotResult3851_g67473 ) , _FadeGlancingValue);
			half Fade_Glancing3853_g67473 = lerpResult3993_g67473;
			half Fade_Camera3743_g67473 = i.vertexToFrag11_g67477;
			half Final_AlphaFade3727_g67473 = ( Fade_Glancing3853_g67473 * Fade_Camera3743_g67473 );
			float temp_output_41_0_g67535 = Final_AlphaFade3727_g67473;
			float Main_Alpha316_g67473 = ( _MainColor.a * tex2DNode29_g67473.a );
			float Mesh_Variation16_g67473 = i.vertexColor.r;
			float lerpResult4033_g67473 = lerp( 0.9 , (Mesh_Variation16_g67473*0.5 + 0.5) , _AlphaVariationValue);
			half Global_Extras_Alpha1033_g67473 = break89_g67525.a;
			float temp_output_4022_0_g67473 = ( lerpResult4033_g67473 - ( 1.0 - Global_Extras_Alpha1033_g67473 ) );
			half AlphaTreshold2132_g67473 = _Cutoff;
			#ifdef TVE_ALPHA_CLIP
				float staticSwitch4017_g67473 = ( temp_output_4022_0_g67473 + AlphaTreshold2132_g67473 );
			#else
				float staticSwitch4017_g67473 = temp_output_4022_0_g67473;
			#endif
			float lerpResult4011_g67473 = lerp( 1.0 , staticSwitch4017_g67473 , _GlobalAlpha);
			half Global_Alpha315_g67473 = saturate( lerpResult4011_g67473 );
			#ifdef TVE_ALPHA_CLIP
				float staticSwitch3792_g67473 = ( ( Main_Alpha316_g67473 * Global_Alpha315_g67473 ) - ( AlphaTreshold2132_g67473 - 0.5 ) );
			#else
				float staticSwitch3792_g67473 = ( Main_Alpha316_g67473 * Global_Alpha315_g67473 );
			#endif
			half Final_Alpha3754_g67473 = staticSwitch3792_g67473;
			float temp_output_661_0_g67473 = ( saturate( ( temp_output_41_0_g67535 + ( temp_output_41_0_g67535 * tex3D( TVE_ScreenTex3D, ( TVE_ScreenTexCoord * WorldPosition3905_g67473 ) ).r ) ) ) * Final_Alpha3754_g67473 );
			float Alpha3735_g67473 = temp_output_661_0_g67473;
			float Treshold3735_g67473 = 0.5;
			{
			#if TVE_ALPHA_CLIP
				clip(Alpha3735_g67473 - Treshold3735_g67473);
			#endif
			}
			half Final_Clip914_g67473 = saturate( Alpha3735_g67473 );
			o.Alpha = Final_Clip914_g67473;
		}

		ENDCG
	}
	Fallback "Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback"
	CustomEditor "TVEShaderCoreGUI"
}
/*ASEBEGIN
Version=18909
1920;0;1920;1029;2573.41;282.96;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;168;-2176,-768;Half;False;Property;_IsLeafShader;_IsLeafShader;202;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-2176,-640;Half;False;Property;_render_cull;_render_cull;204;1;[HideInInspector];Create;True;0;3;Both;0;Back;1;Front;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;822;-1984,-768;Half;False;Property;_IsSubsurfaceShader;_IsSubsurfaceShader;203;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1632,-640;Half;False;Property;_render_zw;_render_zw;208;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1237;-2176,-258;Inherit;False;Base Shader;0;;67473;856f7164d1c579d43a5cf4968a75ca43;81,3882,1,3880,1,3957,1,4028,1,4029,1,3903,1,3900,1,3904,1,4204,1,3908,1,4172,1,1300,1,1298,1,4179,1,3586,0,4499,1,1708,1,3658,1,3509,1,1712,2,3873,1,1714,1,1715,1,1717,1,1718,1,916,1,1762,0,1763,0,3568,1,1949,1,1776,1,3475,1,4210,1,893,1,1745,1,3479,0,4510,0,3501,1,3221,2,1646,1,1757,1,1271,1,3889,0,2807,1,3886,0,2953,1,3887,0,3243,0,3888,0,3728,1,3949,0,2172,1,3883,0,2658,0,1742,0,3484,0,3575,0,1737,0,1733,0,1734,0,1736,0,1735,0,878,0,1550,0,4068,0,4072,0,4070,0,4067,0,4069,0,860,1,2261,1,2260,1,2032,1,2054,1,2062,1,2039,1,4177,1,4217,1,3592,1,4242,0,2750,0;0;19;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;531;FLOAT;4135;FLOAT;529;FLOAT;3678;FLOAT;530;FLOAT;4127;FLOAT;4122;FLOAT;4134;FLOAT;1235;FLOAT3;1230;FLOAT;1461;FLOAT;1290;FLOAT;721;FLOAT;532;FLOAT;629;FLOAT3;534
Node;AmplifyShaderEditor.FunctionNode;1087;-1344,-768;Inherit;False;Compile All Shaders;-1;;67541;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;471;-2176,512;Inherit;False;Define Shader Vegetation;-1;;67542;b458122dd75182d488380bd0f592b9e6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1081;-1856,512;Inherit;False;Define Pipeline Standard;-1;;67543;9af03ae8defe78d448ef2a4ef3601e12;0;0;1;FLOAT;529
Node;AmplifyShaderEditor.FunctionNode;1088;-1536,-768;Inherit;False;Compile Core;-1;;67544;634b02fd1f32e6a4c875d8fc2c450956;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;907;-1456,-640;Half;False;Property;_subsurface_shadow;_subsurface_shadow;201;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1808,-640;Half;False;Property;_render_dst;_render_dst;207;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-2000,-640;Half;False;Property;_render_src;_render_src;206;1;[HideInInspector];Create;True;0;0;0;True;0;False;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;1032;-1376,-256;Float;False;True;-1;4;TVEShaderCoreGUI;0;0;StandardSpecular;BOXOPHOBIC/The Vegetation Engine/Vegetation/Leaf Subsurface Lit;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;True;Back;0;True;17;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;Geometry;ForwardOnly;16;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;0;True;20;0;True;7;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Absolute;0;Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback;205;-1;-1;-1;0;False;0;0;True;10;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2176,-384;Inherit;False;1024.392;100;Final;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;37;-2176,-896;Inherit;False;1024.392;100;Internal;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;449;-2176,384;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
WireConnection;1032;0;1237;0
WireConnection;1032;1;1237;528
WireConnection;1032;2;1237;2489
WireConnection;1032;3;1237;3678
WireConnection;1032;4;1237;530
WireConnection;1032;5;1237;531
WireConnection;1032;6;1237;1230
WireConnection;1032;9;1237;532
WireConnection;1032;11;1237;534
ASEEND*/
//CHKSM=DFDB0EE19223BE279BB93111BFCC36B9FC1C743C
