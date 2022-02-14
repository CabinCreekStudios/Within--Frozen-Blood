// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Vegetation/Grass Subsurface Lit"
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
		_PerspectivePushValue("Perspective Push", Range( 0 , 4)) = 0
		_PerspectiveNoiseValue("Perspective Noise", Range( 0 , 4)) = 0
		_PerspectiveAngleValue("Perspective Angle", Range( 0 , 8)) = 1
		[StyledCategory(Size Fade Settings)]_SizeFadeCat("[ Size Fade Cat ]", Float) = 0
		[StyledMessage(Info, The Size Fade feature is recommended to be used to fade out vegetation at a distance in combination with the LOD Groups or with a 3rd party culling system., _SizeFadeMode, 1, 0, 10)]_SizeFadeMessage("# Size Fade Message", Float) = 0
		[Enum(Off,0,On,1)]_SizeFadeMode("Size Fade Mode", Float) = 0
		_SizeFadeStartValue("Size Fade Start", Range( 0 , 1000)) = 200
		_SizeFadeEndValue("Size Fade End", Range( 0 , 1000)) = 300
		[StyledCategory(Motion Settings)]_MotionCat("[ Motion Cat ]", Float) = 0
		[StyledMessage(Info, Procedural variation in use. Use the Scale settings if the Variation is breaking the bending and rolling animation., _VertexVariationMode, 1 , 0, 10)]_VariationMotionMessage("# Variation Motion Message", Float) = 0
		[HDR]_MotionHighlightColor("Motion Highlight", Color) = (2,2,2,1)
		[StyledSpace(10)]_MotionSpace("# Motion Space", Float) = 0
		_MotionAmplitude_10("Primary Bending", Range( 0 , 1)) = 0.05
		[IntRange]_MotionSpeed_10("Primary Speed", Range( 0 , 40)) = 2
		_MotionScale_10("Primary Scale", Range( 0 , 20)) = 0
		_MotionVariation_10("Primary Variation", Range( 0 , 20)) = 0
		[Space(10)]_MotionAmplitude_32("Details Flutter", Range( 0 , 1)) = 0.2
		[IntRange]_MotionSpeed_32("Details Speed", Range( 0 , 40)) = 4
		_MotionScale_32("Details Scale", Range( 0 , 20)) = 0
		_MotionVariation_32("Details Variation", Range( 0 , 20)) = 2
		[Space(10)]_InteractionAmplitude("Interaction Amplitude", Range( 0 , 1)) = 1
		_InteractionMaskValue("Interaction Use Mask", Range( 0 , 1)) = 1
		[HideInInspector]_MaxBoundsInfo("_MaxBoundsInfo", Vector) = (1,1,1,1)
		[HideInInspector]_render_normals_options("_render_normals_options", Vector) = (1,1,1,0)
		[HideInInspector]_vertex_pivot_mode("_vertex_pivot_mode", Float) = 0
		[HideInInspector]_Color("_LegacyColor", Color) = (0,0,0,0)
		[HideInInspector]_MainTex("_LegacyMainTex", 2D) = "white" {}
		[HideInInspector]_BumpMap("_LegacyBumpMap", 2D) = "white" {}
		[HideInInspector][StyledToggle]_VertexDataMode("_VertexDataMode", Float) = 0
		[HideInInspector][Enum(Single Pivot,0,Baked Pivots,1)]_VertexPivotMode("_VertexPivotMode", Float) = 0
		[HideInInspector]_VertexVariationMode("_VertexVariationMode", Float) = 0
		[HideInInspector]_VertexMasksMode("_VertexMasksMode", Float) = 0
		[HideInInspector]_IsTVEShader("_IsTVEShader", Float) = 1
		[HideInInspector]_IsVersion("_IsVersion", Float) = 500
		[HideInInspector]_HasEmissive("_HasEmissive", Float) = 0
		[HideInInspector]_HasGradient("_HasGradient", Float) = 0
		[HideInInspector]_HasOcclusion("_HasOcclusion", Float) = 0
		[HideInInspector]_IsGrassShader("_IsGrassShader", Float) = 1
		[HideInInspector]_subsurface_shadow("_subsurface_shadow", Float) = 1
		[HideInInspector]_IsSubsurfaceShader("_IsSubsurfaceShader", Float) = 1
		[HideInInspector]_render_src("_render_src", Float) = 1
		[HideInInspector]_render_cull("_render_cull", Float) = 0
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
		#include "UnityPBSLighting.cginc"
		#pragma target 4.0
		#pragma shader_feature_local TVE_ALPHA_CLIP
		#pragma shader_feature_local TVE_VERTEX_DATA_BATCHED
		//TVE Pipeline Defines
		#define THE_VEGETATION_ENGINE
		#define TVE_IS_STANDARD_PIPELINE
		//TVE Shader Type Defines
		#define TVE_IS_GRASS_SHADER
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
			float2 vertexToFrag11_g60175;
			half ASEVFace : VFACE;
			float3 vertexToFrag11_g60210;
			float3 vertexToFrag11_g60209;
			float3 vertexToFrag11_g60211;
			float vertexToFrag11_g60154;
			float3 vertexToFrag3890_g60145;
			float4 vertexColor : COLOR;
			float3 vertexToFrag11_g60203;
			float2 vertexToFrag11_g60187;
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

		uniform half _render_cull;
		uniform half _IsGrassShader;
		uniform half _IsSubsurfaceShader;
		uniform half _subsurface_shadow;
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
		uniform half _VertexPivotMode;
		uniform half _MotionAmplitude_10;
		uniform float4 TVE_MotionParamsMin;
		uniform float4 TVE_MotionParamsMax;
		uniform half4 TVE_MotionParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_MotionTex);
		uniform half4 TVE_MotionCoord;
		uniform half _vertex_pivot_mode;
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
		uniform float _MotionScale_32;
		uniform float _MotionSpeed_32;
		uniform float _MotionVariation_32;
		uniform half _MotionAmplitude_32;
		uniform half TVE_MotionFadeEnd;
		uniform half TVE_MotionFadeStart;
		uniform half _VertexDataMode;
		uniform half _GlobalSize;
		uniform half TVE_DistanceFadeBias;
		uniform half _SizeFadeEndValue;
		uniform half _SizeFadeStartValue;
		uniform half _SizeFadeMode;
		uniform half _PerspectivePushValue;
		uniform half _PerspectiveNoiseValue;
		uniform half _PerspectiveAngleValue;
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
		uniform half4 _MotionHighlightColor;
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
		uniform half4 TVE_OverlayColor;
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
		uniform sampler2D _MainMaskTex;
		uniform half _MainSmoothnessValue;
		uniform half TVE_OverlaySmoothness;
		uniform half _GlobalWetness;
		uniform half _MainOcclusionValue;
		uniform sampler3D TVE_ScreenTex3D;
		uniform half TVE_ScreenTexCoord;
		uniform half _AlphaVariationValue;
		uniform half _GlobalAlpha;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VertexPosition3588_g60145 = ase_vertex3Pos;
			float3 appendResult60_g60205 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			half3 Mesh_PivotsData2831_g60145 = ( appendResult60_g60205 * _VertexPivotMode );
			half3 Mesh_PivotsOS2291_g60145 = Mesh_PivotsData2831_g60145;
			float3 temp_output_2283_0_g60145 = ( VertexPosition3588_g60145 - Mesh_PivotsOS2291_g60145 );
			half3 VertexPos40_g60167 = temp_output_2283_0_g60145;
			float3 appendResult74_g60167 = (float3(VertexPos40_g60167.x , 0.0 , 0.0));
			half3 VertexPosRotationAxis50_g60167 = appendResult74_g60167;
			float3 break84_g60167 = VertexPos40_g60167;
			float3 appendResult81_g60167 = (float3(0.0 , break84_g60167.y , break84_g60167.z));
			half3 VertexPosOtherAxis82_g60167 = appendResult81_g60167;
			half ObjectData20_g60206 = 3.14;
			float Bounds_Height374_g60145 = _MaxBoundsInfo.y;
			half WorldData19_g60206 = ( Bounds_Height374_g60145 * 3.14 );
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g60206 = WorldData19_g60206;
			#else
				float staticSwitch14_g60206 = ObjectData20_g60206;
			#endif
			float Motion_Max_Bending1133_g60145 = staticSwitch14_g60206;
			float4x4 break19_g60146 = unity_ObjectToWorld;
			float3 appendResult20_g60146 = (float3(break19_g60146[ 0 ][ 3 ] , break19_g60146[ 1 ][ 3 ] , break19_g60146[ 2 ][ 3 ]));
			float3 appendResult60_g60148 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float3 temp_output_91_0_g60146 = ( appendResult60_g60148 * _vertex_pivot_mode );
			float3 PivotsOnly105_g60146 = (mul( unity_ObjectToWorld, float4( temp_output_91_0_g60146 , 0.0 ) ).xyz).xyz;
			half3 ObjectData20_g60147 = ( appendResult20_g60146 + PivotsOnly105_g60146 );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half3 WorldData19_g60147 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g60147 = WorldData19_g60147;
			#else
				float3 staticSwitch14_g60147 = ObjectData20_g60147;
			#endif
			float3 temp_output_114_0_g60146 = staticSwitch14_g60147;
			float3 vertexToFrag4224_g60145 = temp_output_114_0_g60146;
			half3 ObjectData20_g60183 = vertexToFrag4224_g60145;
			float3 vertexToFrag3890_g60145 = ase_worldPos;
			half3 WorldData19_g60183 = vertexToFrag3890_g60145;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g60183 = WorldData19_g60183;
			#else
				float3 staticSwitch14_g60183 = ObjectData20_g60183;
			#endif
			float3 ObjectPosition4223_g60145 = staticSwitch14_g60183;
			float3 Position83_g60212 = ObjectPosition4223_g60145;
			float temp_output_84_0_g60212 = _LayerMotionValue;
			float4 lerpResult87_g60212 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, samplerTVE_MotionTex, float3(( (TVE_MotionCoord).zw + ( (TVE_MotionCoord).xy * (Position83_g60212).xz ) ),temp_output_84_0_g60212), 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g60212]);
			half4 Global_Motion_Params3909_g60145 = lerpResult87_g60212;
			float4 break322_g60162 = Global_Motion_Params3909_g60145;
			half Wind_Power369_g60162 = break322_g60162.z;
			float lerpResult376_g60162 = lerp( TVE_MotionParamsMin.x , TVE_MotionParamsMax.x , Wind_Power369_g60162);
			half Wind_Power_103106_g60145 = lerpResult376_g60162;
			float2 panner73_g60155 = ( _Time.y * (TVE_NoiseParams).xy + ( (ObjectPosition4223_g60145).xz * TVE_NoiseParams.z ));
			float4 tex2DNode75_g60155 = tex2Dlod( TVE_NoiseTex, float4( panner73_g60155, 0, 0.0) );
			float4 saferPower77_g60155 = max( abs( tex2DNode75_g60155 ) , 0.0001 );
			half Wind_Power2223_g60145 = Wind_Power369_g60162;
			float temp_output_167_0_g60155 = Wind_Power2223_g60145;
			float lerpResult168_g60155 = lerp( 1.4 , 0.2 , temp_output_167_0_g60155);
			float4 temp_cast_5 = (lerpResult168_g60155).xxxx;
			float4 break174_g60155 = pow( saferPower77_g60155 , temp_cast_5 );
			half Global_NoiseTex_R34_g60145 = break174_g60155.r;
			float3 appendResult397_g60162 = (float3(break322_g60162.x , 0.0 , break322_g60162.y));
			float3 temp_output_398_0_g60162 = (appendResult397_g60162*2.0 + -1.0);
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 temp_output_339_0_g60162 = ( mul( unity_WorldToObject, float4( temp_output_398_0_g60162 , 0.0 ) ).xyz * ase_parentObjectScale );
			half2 Wind_DirectionOS39_g60145 = (temp_output_339_0_g60162).xz;
			half Input_Speed62_g60168 = _MotionSpeed_10;
			float mulTime373_g60168 = _Time.y * Input_Speed62_g60168;
			float3 break111_g60191 = ObjectPosition4223_g60145;
			half Variation_Complex102_g60191 = frac( ( v.color.r + ( break111_g60191.x + break111_g60191.z ) ) );
			half ObjectData20_g60192 = Variation_Complex102_g60191;
			half Variation_Simple105_g60191 = v.color.r;
			half WorldData19_g60192 = Variation_Simple105_g60191;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g60192 = WorldData19_g60192;
			#else
				float staticSwitch14_g60192 = ObjectData20_g60192;
			#endif
			half Motion_Variation3073_g60145 = staticSwitch14_g60192;
			half Motion_Variation284_g60168 = ( _MotionVariation_10 * Motion_Variation3073_g60145 );
			float Motion_Scale287_g60168 = ( _MotionScale_10 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
			half Sine_MinusOneToOne281_g60168 = sin( ( mulTime373_g60168 + Motion_Variation284_g60168 + Motion_Scale287_g60168 ) );
			half Wind_Squash4479_g60145 = break322_g60162.w;
			half Input_WindSquash419_g60168 = Wind_Squash4479_g60145;
			half Input_WindPower327_g60168 = Wind_Power_103106_g60145;
			float lerpResult321_g60168 = lerp( Sine_MinusOneToOne281_g60168 , (Sine_MinusOneToOne281_g60168*Input_WindSquash419_g60168 + 1.0) , Input_WindPower327_g60168);
			half Mesh_Motion_1082_g60145 = v.texcoord3.x;
			half2 Motion_10_Bending2258_g60145 = ( ( _MotionAmplitude_10 * Motion_Max_Bending1133_g60145 ) * Wind_Power_103106_g60145 * Global_NoiseTex_R34_g60145 * Wind_DirectionOS39_g60145 * lerpResult321_g60168 * Mesh_Motion_1082_g60145 );
			half Interaction_Amplitude4137_g60145 = _InteractionAmplitude;
			float3 Position83_g60157 = ObjectPosition4223_g60145;
			float temp_output_84_0_g60157 = _LayerReactValue;
			float4 lerpResult87_g60157 = lerp( TVE_ReactParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ReactTex, samplerTVE_ReactTex, float3(( (TVE_ReactCoord).zw + ( (TVE_ReactCoord).xy * (Position83_g60157).xz ) ),temp_output_84_0_g60157), 0.0 ) , TVE_ReactUsage[(int)temp_output_84_0_g60157]);
			half4 Global_React_Params4173_g60145 = lerpResult87_g60157;
			float4 break322_g60150 = Global_React_Params4173_g60145;
			half Interaction_Mask66_g60145 = break322_g60150.z;
			float3 appendResult397_g60150 = (float3(break322_g60150.x , 0.0 , break322_g60150.y));
			float3 temp_output_398_0_g60150 = (appendResult397_g60150*2.0 + -1.0);
			float3 temp_output_339_0_g60150 = ( mul( unity_WorldToObject, float4( temp_output_398_0_g60150 , 0.0 ) ).xyz * ase_parentObjectScale );
			half2 Interaction_DirectionOS4158_g60145 = (temp_output_339_0_g60150).xz;
			float lerpResult4494_g60145 = lerp( 1.0 , Mesh_Motion_1082_g60145 , _InteractionMaskValue);
			half2 Motion_10_Interaction53_g60145 = ( Interaction_Amplitude4137_g60145 * Motion_Max_Bending1133_g60145 * Interaction_Mask66_g60145 * Interaction_Mask66_g60145 * Interaction_DirectionOS4158_g60145 * lerpResult4494_g60145 );
			float2 lerpResult109_g60145 = lerp( Motion_10_Bending2258_g60145 , Motion_10_Interaction53_g60145 , ( Interaction_Mask66_g60145 * saturate( Interaction_Amplitude4137_g60145 ) ));
			float2 break143_g60145 = lerpResult109_g60145;
			half Motion_10_ZAxis190_g60145 = break143_g60145.y;
			half Angle44_g60167 = Motion_10_ZAxis190_g60145;
			half3 VertexPos40_g60179 = ( VertexPosRotationAxis50_g60167 + ( VertexPosOtherAxis82_g60167 * cos( Angle44_g60167 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g60167 ) * sin( Angle44_g60167 ) ) );
			float3 appendResult74_g60179 = (float3(0.0 , 0.0 , VertexPos40_g60179.z));
			half3 VertexPosRotationAxis50_g60179 = appendResult74_g60179;
			float3 break84_g60179 = VertexPos40_g60179;
			float3 appendResult81_g60179 = (float3(break84_g60179.x , break84_g60179.y , 0.0));
			half3 VertexPosOtherAxis82_g60179 = appendResult81_g60179;
			half Motion_10_XAxis216_g60145 = break143_g60145.x;
			half Angle44_g60179 = -Motion_10_XAxis216_g60145;
			half Motion_Scale321_g60194 = ( _MotionScale_32 * 10.0 );
			half Input_Speed62_g60194 = _MotionSpeed_32;
			float mulTime349_g60194 = _Time.y * Input_Speed62_g60194;
			float Motion_Variation330_g60194 = ( _MotionVariation_32 * Motion_Variation3073_g60145 );
			float Bounds_Radius121_g60145 = _MaxBoundsInfo.x;
			half Input_Amplitude58_g60194 = ( _MotionAmplitude_32 * Bounds_Radius121_g60145 * 0.1 );
			float3 temp_output_299_0_g60194 = ( sin( ( ( ase_worldPos * Motion_Scale321_g60194 ) + mulTime349_g60194 + Motion_Variation330_g60194 ) ) * Input_Amplitude58_g60194 );
			half Mesh_Motion_30144_g60145 = v.texcoord3.z;
			float lerpResult378_g60162 = lerp( TVE_MotionParamsMin.z , TVE_MotionParamsMax.z , Wind_Power369_g60162);
			half Wind_Power_303115_g60145 = lerpResult378_g60162;
			float temp_output_7_0_g60201 = TVE_MotionFadeEnd;
			half Wind_FadeOut4005_g60145 = saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g60201 ) / ( TVE_MotionFadeStart - temp_output_7_0_g60201 ) ) );
			half Motion_Selective4260_g60145 = 1.0;
			half3 Motion_30_Details263_g60145 = ( temp_output_299_0_g60194 * ( Global_NoiseTex_R34_g60145 * Mesh_Motion_30144_g60145 * Wind_Power_303115_g60145 * Wind_FadeOut4005_g60145 * Motion_Selective4260_g60145 ) );
			float3 Vertex_Motion_Object833_g60145 = ( ( VertexPosRotationAxis50_g60179 + ( VertexPosOtherAxis82_g60179 * cos( Angle44_g60179 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g60179 ) * sin( Angle44_g60179 ) ) ) + Motion_30_Details263_g60145 );
			float3 temp_output_3474_0_g60145 = ( VertexPosition3588_g60145 - Mesh_PivotsOS2291_g60145 );
			float3 appendResult2043_g60145 = (float3(Motion_10_XAxis216_g60145 , 0.0 , Motion_10_ZAxis190_g60145));
			float3 Vertex_Motion_World1118_g60145 = ( ( temp_output_3474_0_g60145 + appendResult2043_g60145 ) + Motion_30_Details263_g60145 );
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch3312_g60145 = Vertex_Motion_World1118_g60145;
			#else
				float3 staticSwitch3312_g60145 = ( Vertex_Motion_Object833_g60145 + ( 0.0 * _VertexDataMode ) );
			#endif
			half Global_Vertex_Size174_g60145 = break322_g60150.w;
			float lerpResult346_g60145 = lerp( 1.0 , Global_Vertex_Size174_g60145 , _GlobalSize);
			float3 appendResult3480_g60145 = (float3(lerpResult346_g60145 , lerpResult346_g60145 , lerpResult346_g60145));
			half3 ObjectData20_g60198 = appendResult3480_g60145;
			half3 _Vector11 = half3(1,1,1);
			half3 WorldData19_g60198 = _Vector11;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g60198 = WorldData19_g60198;
			#else
				float3 staticSwitch14_g60198 = ObjectData20_g60198;
			#endif
			half3 Vertex_Size1741_g60145 = staticSwitch14_g60198;
			half3 _Vector5 = half3(1,1,1);
			float temp_output_7_0_g60184 = _SizeFadeEndValue;
			float temp_output_335_0_g60145 = saturate( ( ( ( distance( _WorldSpaceCameraPos , ObjectPosition4223_g60145 ) * ( 1.0 / TVE_DistanceFadeBias ) ) - temp_output_7_0_g60184 ) / ( _SizeFadeStartValue - temp_output_7_0_g60184 ) ) );
			float3 appendResult3482_g60145 = (float3(temp_output_335_0_g60145 , temp_output_335_0_g60145 , temp_output_335_0_g60145));
			float3 lerpResult3556_g60145 = lerp( _Vector5 , appendResult3482_g60145 , _SizeFadeMode);
			half3 ObjectData20_g60199 = lerpResult3556_g60145;
			half3 WorldData19_g60199 = _Vector5;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g60199 = WorldData19_g60199;
			#else
				float3 staticSwitch14_g60199 = ObjectData20_g60199;
			#endif
			float3 Vertex_SizeFade1740_g60145 = staticSwitch14_g60199;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult2696_g60145 = normalize( ase_worldViewDir );
			float3 break2709_g60145 = cross( normalizeResult2696_g60145 , half3(0,1,0) );
			float3 appendResult2710_g60145 = (float3(-break2709_g60145.z , 0.0 , break2709_g60145.x));
			float3 appendResult2667_g60145 = (float3(v.color.r , 0.5 , v.color.r));
			float3 normalizeResult2169_g60145 = normalize( ase_worldViewDir );
			float3 ViewDir_Normalized3963_g60145 = normalizeResult2169_g60145;
			float dotResult2212_g60145 = dot( ViewDir_Normalized3963_g60145 , float3(0,1,0) );
			half Mask_HView2656_g60145 = dotResult2212_g60145;
			float saferPower2652_g60145 = max( Mask_HView2656_g60145 , 0.0001 );
			half3 Grass_Coverage2661_g60145 = ( ( ( mul( unity_WorldToObject, float4( appendResult2710_g60145 , 0.0 ) ).xyz * _PerspectivePushValue ) + ( (appendResult2667_g60145*2.0 + -1.0) * _PerspectiveNoiseValue ) ) * v.color.a * pow( saferPower2652_g60145 , _PerspectiveAngleValue ) );
			float3 Final_VertexPosition890_g60145 = ( ( ( staticSwitch3312_g60145 * Vertex_Size1741_g60145 * Vertex_SizeFade1740_g60145 ) + Mesh_PivotsOS2291_g60145 + Grass_Coverage2661_g60145 ) + _DisableSRPBatcher );
			v.vertex.xyz = Final_VertexPosition890_g60145;
			v.vertex.w = 1;
			o.vertexToFrag11_g60175 = ( ( v.texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
			float temp_output_7_0_g60152 = _GradientMinValue;
			float4 lerpResult2779_g60145 = lerp( _GradientColorTwo , _GradientColorOne , saturate( ( ( v.color.a - temp_output_7_0_g60152 ) / ( _GradientMaxValue - temp_output_7_0_g60152 ) ) ));
			half3 Gradient_Tint2784_g60145 = (lerpResult2779_g60145).rgb;
			o.vertexToFrag11_g60210 = Gradient_Tint2784_g60145;
			float3 temp_cast_15 = (_NoiseScaleValue).xxx;
			float3 WorldPosition3905_g60145 = vertexToFrag3890_g60145;
			float temp_output_7_0_g60188 = _NoiseMinValue;
			half Noise_Mask3162_g60145 = saturate( ( ( tex3Dlod( TVE_WorldTex3D, float4( ( temp_cast_15 * WorldPosition3905_g60145 * 0.1 ), 0.0) ).r - temp_output_7_0_g60188 ) / ( _NoiseMaxValue - temp_output_7_0_g60188 ) ) );
			float4 lerpResult2800_g60145 = lerp( _NoiseColorTwo , _NoiseColorOne , Noise_Mask3162_g60145);
			half3 Noise_Tint2802_g60145 = (lerpResult2800_g60145).rgb;
			o.vertexToFrag11_g60209 = Noise_Tint2802_g60145;
			float lerpResult169_g60155 = lerp( 4.0 , 2.0 , temp_output_167_0_g60155);
			half Global_NoiseTex_H2869_g60145 = pow( abs( tex2DNode75_g60155.a ) , lerpResult169_g60155 );
			half3 Highlight_Tint3231_g60145 = ( ( (_MotionHighlightColor).rgb * Global_NoiseTex_H2869_g60145 * Wind_Power_103106_g60145 * Wind_FadeOut4005_g60145 * v.color.a ) + float3( 1,1,1 ) );
			o.vertexToFrag11_g60211 = Highlight_Tint3231_g60145;
			float3 Position58_g60153 = WorldPosition3905_g60145;
			float temp_output_82_0_g60153 = _LayerColorsValue;
			float4 lerpResult88_g60153 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, samplerTVE_ColorsTex, float3(( (TVE_ColorsCoord).zw + ( (TVE_ColorsCoord).xy * (Position58_g60153).xz ) ),temp_output_82_0_g60153), 0.0 ) , TVE_ColorsUsage[(int)temp_output_82_0_g60153]);
			half Global_ColorsTex_A1701_g60145 = (lerpResult88_g60153).a;
			o.vertexToFrag11_g60154 = Global_ColorsTex_A1701_g60145;
			o.vertexToFrag3890_g60145 = ase_worldPos;
			float3 temp_cast_18 = (1.0).xxx;
			float Mesh_Occlusion318_g60145 = v.color.g;
			float temp_output_7_0_g60182 = _VertexOcclusionMinValue;
			float3 lerpResult2945_g60145 = lerp( (_VertexOcclusionColor).rgb , temp_cast_18 , saturate( ( ( Mesh_Occlusion318_g60145 - temp_output_7_0_g60182 ) / ( _VertexOcclusionMaxValue - temp_output_7_0_g60182 ) ) ));
			o.vertexToFrag11_g60203 = lerpResult2945_g60145;
			o.vertexToFrag11_g60187 = ( ( v.texcoord.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
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
			half2 Main_UVs15_g60145 = i.vertexToFrag11_g60175;
			half3 Main_Normal137_g60145 = UnpackScaleNormal( tex2D( _MainNormalTex, Main_UVs15_g60145 ), _MainNormalValue );
			float3 temp_output_13_0_g60166 = Main_Normal137_g60145;
			float3 switchResult12_g60166 = (((i.ASEVFace>0)?(temp_output_13_0_g60166):(( temp_output_13_0_g60166 * _render_normals_options ))));
			half3 Blend_Normal312_g60145 = switchResult12_g60166;
			half3 Final_Normal366_g60145 = Blend_Normal312_g60145;
			o.Normal = Final_Normal366_g60145;
			half Leaves_Mask4511_g60145 = 1.0;
			float3 lerpResult4521_g60145 = lerp( float3( 1,1,1 ) , ( i.vertexToFrag11_g60210 * i.vertexToFrag11_g60209 * i.vertexToFrag11_g60211 ) , Leaves_Mask4511_g60145);
			float3 lerpResult4519_g60145 = lerp( float3( 1,1,1 ) , (_MainColor).rgb , Leaves_Mask4511_g60145);
			float4 tex2DNode29_g60145 = tex2D( _MainAlbedoTex, Main_UVs15_g60145 );
			half3 Main_Albedo99_g60145 = ( lerpResult4519_g60145 * (tex2DNode29_g60145).rgb );
			half3 Blend_Albedo265_g60145 = Main_Albedo99_g60145;
			half3 Blend_AlbedoTinted2808_g60145 = ( lerpResult4521_g60145 * Blend_Albedo265_g60145 );
			float dotResult3616_g60145 = dot( Blend_AlbedoTinted2808_g60145 , float3(0.2126,0.7152,0.0722) );
			float3 temp_cast_1 = (dotResult3616_g60145).xxx;
			half Global_Colors_Influence3668_g60145 = i.vertexToFrag11_g60154;
			float3 lerpResult3618_g60145 = lerp( Blend_AlbedoTinted2808_g60145 , temp_cast_1 , Global_Colors_Influence3668_g60145);
			float3 WorldPosition3905_g60145 = i.vertexToFrag3890_g60145;
			float3 Position58_g60153 = WorldPosition3905_g60145;
			float temp_output_82_0_g60153 = _LayerColorsValue;
			float4 lerpResult88_g60153 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ColorsTex, samplerTVE_ColorsTex, float3(( (TVE_ColorsCoord).zw + ( (TVE_ColorsCoord).xy * (Position58_g60153).xz ) ),temp_output_82_0_g60153) ) , TVE_ColorsUsage[(int)temp_output_82_0_g60153]);
			half3 Global_ColorsTex_RGB1700_g60145 = (lerpResult88_g60153).rgb;
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g60189 = 2.0;
			#else
				float staticSwitch1_g60189 = 4.594794;
			#endif
			half3 Global_Colors1954_g60145 = ( Global_ColorsTex_RGB1700_g60145 * staticSwitch1_g60189 );
			float lerpResult3870_g60145 = lerp( 1.0 , i.vertexColor.r , _ColorsVariationValue);
			half Global_Colors_Value3650_g60145 = ( _GlobalColors * lerpResult3870_g60145 );
			float temp_output_7_0_g60204 = _ColorsMaskMinValue;
			half Global_Colors_Mask3692_g60145 = saturate( ( ( ( 1.0 - i.vertexColor.a ) - temp_output_7_0_g60204 ) / ( _ColorsMaskMaxValue - temp_output_7_0_g60204 ) ) );
			float3 lerpResult3628_g60145 = lerp( Blend_AlbedoTinted2808_g60145 , ( lerpResult3618_g60145 * Global_Colors1954_g60145 ) , ( Global_Colors_Value3650_g60145 * Global_Colors_Mask3692_g60145 ));
			half3 Blend_AlbedoColored863_g60145 = lerpResult3628_g60145;
			float3 temp_output_799_0_g60145 = (_SubsurfaceColor).rgb;
			float dotResult3930_g60145 = dot( temp_output_799_0_g60145 , float3(0.2126,0.7152,0.0722) );
			float3 temp_cast_4 = (dotResult3930_g60145).xxx;
			float3 lerpResult3932_g60145 = lerp( temp_output_799_0_g60145 , temp_cast_4 , Global_Colors_Influence3668_g60145);
			float3 lerpResult3942_g60145 = lerp( temp_output_799_0_g60145 , ( lerpResult3932_g60145 * Global_Colors1954_g60145 ) , ( Global_Colors_Value3650_g60145 * Global_Colors_Mask3692_g60145 ));
			half3 Subsurface_Color1722_g60145 = lerpResult3942_g60145;
			half MainLight_Subsurface4041_g60145 = TVE_MainLightParams.a;
			half Subsurface_Intensity1752_g60145 = ( _SubsurfaceValue * MainLight_Subsurface4041_g60145 );
			float temp_output_7_0_g60161 = _SubsurfaceMaskMinValue;
			half Subsurface_Mask1557_g60145 = saturate( ( ( i.vertexColor.a - temp_output_7_0_g60161 ) / ( _SubsurfaceMaskMaxValue - temp_output_7_0_g60161 ) ) );
			half3 Subsurface_Transmission884_g60145 = ( Subsurface_Color1722_g60145 * Subsurface_Intensity1752_g60145 * Subsurface_Mask1557_g60145 );
			half3 MainLight_Direction3926_g60145 = TVE_MainLightDirection;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult2169_g60145 = normalize( ase_worldViewDir );
			float3 ViewDir_Normalized3963_g60145 = normalizeResult2169_g60145;
			float dotResult785_g60145 = dot( -MainLight_Direction3926_g60145 , ViewDir_Normalized3963_g60145 );
			float saferPower1624_g60145 = max( (dotResult785_g60145*0.5 + 0.5) , 0.0001 );
			#ifdef UNITY_PASS_FORWARDADD
				float staticSwitch1602_g60145 = 0.0;
			#else
				float staticSwitch1602_g60145 = ( pow( saferPower1624_g60145 , _MainLightAngleValue ) * _MainLightScatteringValue );
			#endif
			half Mask_Subsurface_View782_g60145 = staticSwitch1602_g60145;
			half3 Subsurface_Scattering1693_g60145 = ( Subsurface_Transmission884_g60145 * Blend_AlbedoColored863_g60145 * Mask_Subsurface_View782_g60145 );
			half3 Blend_AlbedoAndSubsurface149_g60145 = ( Blend_AlbedoColored863_g60145 + Subsurface_Scattering1693_g60145 );
			half3 Global_OverlayColor1758_g60145 = (TVE_OverlayColor).rgb;
			half Main_AlbedoTex_G3526_g60145 = tex2DNode29_g60145.g;
			float3 Position82_g60197 = WorldPosition3905_g60145;
			float temp_output_84_0_g60197 = _LayerExtrasValue;
			float4 lerpResult88_g60197 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, float3(( (TVE_ExtrasCoord).zw + ( (TVE_ExtrasCoord).xy * (Position82_g60197).xz ) ),temp_output_84_0_g60197) ) , TVE_ExtrasUsage[(int)temp_output_84_0_g60197]);
			float4 break89_g60197 = lerpResult88_g60197;
			half Global_Extras_Overlay156_g60145 = break89_g60197.b;
			float temp_output_1025_0_g60145 = ( _GlobalOverlay * Global_Extras_Overlay156_g60145 );
			float lerpResult1065_g60145 = lerp( 1.0 , i.vertexColor.r , _OverlayVariationValue);
			half Overlay_Commons1365_g60145 = ( temp_output_1025_0_g60145 * lerpResult1065_g60145 );
			float temp_output_7_0_g60173 = _OverlayMaskMinValue;
			half Overlay_Mask269_g60145 = saturate( ( ( ( ( ( i.vertexColor.a * 0.5 ) + Main_AlbedoTex_G3526_g60145 ) * Overlay_Commons1365_g60145 ) - temp_output_7_0_g60173 ) / ( _OverlayMaskMaxValue - temp_output_7_0_g60173 ) ) );
			float3 lerpResult336_g60145 = lerp( Blend_AlbedoAndSubsurface149_g60145 , Global_OverlayColor1758_g60145 , Overlay_Mask269_g60145);
			half3 Final_Albedo359_g60145 = lerpResult336_g60145;
			float3 Vertex_Occlusion648_g60145 = saturate( i.vertexToFrag11_g60203 );
			o.Albedo = ( Final_Albedo359_g60145 * Vertex_Occlusion648_g60145 );
			float4 temp_output_4214_0_g60145 = ( _EmissiveColor * _EmissiveIntensityParams.x );
			half2 Emissive_UVs2468_g60145 = i.vertexToFrag11_g60187;
			half Global_Extras_Emissive4203_g60145 = break89_g60197.r;
			float lerpResult4206_g60145 = lerp( 1.0 , Global_Extras_Emissive4203_g60145 , _GlobalEmissive);
			half3 Final_Emissive2476_g60145 = ( (( temp_output_4214_0_g60145 * tex2D( _EmissiveTex, Emissive_UVs2468_g60145 ) )).rgb * lerpResult4206_g60145 );
			o.Emission = Final_Emissive2476_g60145;
			float3 temp_cast_7 = (( 0.04 * _RenderSpecular )).xxx;
			o.Specular = temp_cast_7;
			float4 tex2DNode35_g60145 = tex2D( _MainMaskTex, Main_UVs15_g60145 );
			half Main_Smoothness227_g60145 = ( tex2DNode35_g60145.a * _MainSmoothnessValue );
			half Blend_Smoothness314_g60145 = Main_Smoothness227_g60145;
			half Global_OverlaySmoothness311_g60145 = TVE_OverlaySmoothness;
			float lerpResult343_g60145 = lerp( Blend_Smoothness314_g60145 , Global_OverlaySmoothness311_g60145 , Overlay_Mask269_g60145);
			half Final_Smoothness371_g60145 = lerpResult343_g60145;
			half Global_Extras_Wetness305_g60145 = break89_g60197.g;
			float lerpResult3673_g60145 = lerp( 0.0 , Global_Extras_Wetness305_g60145 , _GlobalWetness);
			half Final_SmoothnessAndWetness4130_g60145 = saturate( ( Final_Smoothness371_g60145 + lerpResult3673_g60145 ) );
			o.Smoothness = Final_SmoothnessAndWetness4130_g60145;
			float lerpResult240_g60145 = lerp( 1.0 , tex2DNode35_g60145.g , _MainOcclusionValue);
			half Main_Occlusion247_g60145 = lerpResult240_g60145;
			half Blend_Occlusion323_g60145 = Main_Occlusion247_g60145;
			o.Occlusion = Blend_Occlusion323_g60145;
			o.Transmission = Subsurface_Transmission884_g60145;
			float localCustomAlphaClip3735_g60145 = ( 0.0 );
			half Final_AlphaFade3727_g60145 = 1.0;
			float temp_output_41_0_g60207 = Final_AlphaFade3727_g60145;
			float Main_Alpha316_g60145 = ( _MainColor.a * tex2DNode29_g60145.a );
			float Mesh_Variation16_g60145 = i.vertexColor.r;
			float lerpResult4033_g60145 = lerp( 0.9 , (Mesh_Variation16_g60145*0.5 + 0.5) , _AlphaVariationValue);
			half Global_Extras_Alpha1033_g60145 = break89_g60197.a;
			float temp_output_4022_0_g60145 = ( lerpResult4033_g60145 - ( 1.0 - Global_Extras_Alpha1033_g60145 ) );
			half AlphaTreshold2132_g60145 = _Cutoff;
			#ifdef TVE_ALPHA_CLIP
				float staticSwitch4017_g60145 = ( temp_output_4022_0_g60145 + AlphaTreshold2132_g60145 );
			#else
				float staticSwitch4017_g60145 = temp_output_4022_0_g60145;
			#endif
			float lerpResult4011_g60145 = lerp( 1.0 , staticSwitch4017_g60145 , _GlobalAlpha);
			half Global_Alpha315_g60145 = saturate( lerpResult4011_g60145 );
			#ifdef TVE_ALPHA_CLIP
				float staticSwitch3792_g60145 = ( ( Main_Alpha316_g60145 * Global_Alpha315_g60145 ) - ( AlphaTreshold2132_g60145 - 0.5 ) );
			#else
				float staticSwitch3792_g60145 = ( Main_Alpha316_g60145 * Global_Alpha315_g60145 );
			#endif
			half Final_Alpha3754_g60145 = staticSwitch3792_g60145;
			float temp_output_661_0_g60145 = ( saturate( ( temp_output_41_0_g60207 + ( temp_output_41_0_g60207 * tex3D( TVE_ScreenTex3D, ( TVE_ScreenTexCoord * WorldPosition3905_g60145 ) ).r ) ) ) * Final_Alpha3754_g60145 );
			float Alpha3735_g60145 = temp_output_661_0_g60145;
			float Treshold3735_g60145 = 0.5;
			{
			#if TVE_ALPHA_CLIP
				clip(Alpha3735_g60145 - Treshold3735_g60145);
			#endif
			}
			half Final_Clip914_g60145 = saturate( Alpha3735_g60145 );
			o.Alpha = Final_Clip914_g60145;
		}

		ENDCG
	}
	Fallback "Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback"
	CustomEditor "TVEShaderCoreGUI"
}
/*ASEBEGIN
Version=18909
1920;0;1920;1029;3013.42;379.6876;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;10;-2176,-768;Half;False;Property;_render_cull;_render_cull;206;1;[HideInInspector];Create;True;0;3;Both;0;Back;1;Front;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;168;-2176,-896;Half;False;Property;_IsGrassShader;_IsGrassShader;201;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1010;-1984,-896;Half;False;Property;_IsSubsurfaceShader;_IsSubsurfaceShader;203;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1040;-1344,-896;Inherit;False;Compile All Shaders;-1;;59913;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1013;-1408,-768;Half;False;Property;_subsurface_shadow;_subsurface_shadow;202;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1984,-768;Half;False;Property;_render_src;_render_src;204;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1792,-768;Half;False;Property;_render_dst;_render_dst;207;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1041;-1536,-896;Inherit;False;Compile Core;-1;;59914;634b02fd1f32e6a4c875d8fc2c450956;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1600,-768;Half;False;Property;_render_zw;_render_zw;208;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1039;-1888,384;Inherit;False;Define Pipeline Standard;-1;;60007;9af03ae8defe78d448ef2a4ef3601e12;0;0;1;FLOAT;529
Node;AmplifyShaderEditor.FunctionNode;713;-2176,384;Inherit;False;Define Shader Grass;-1;;60008;921559c53826c0142ba6e27dd03eaef2;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1048;-2176,-384;Inherit;False;Base Shader;0;;60145;856f7164d1c579d43a5cf4968a75ca43;81,3882,1,3880,1,3957,1,4028,1,4029,1,3903,1,3900,1,3904,1,4204,1,3908,1,4172,1,1300,1,1298,1,4179,1,3586,0,4499,1,1708,1,3658,1,3509,1,1712,0,3873,1,1714,1,1715,1,1717,1,1718,1,916,0,1762,0,1763,0,3568,1,1949,1,1776,1,3475,1,4210,1,893,1,1745,1,3479,0,4510,0,3501,1,3221,1,1646,1,1757,0,1271,1,3889,0,2807,1,3886,0,2953,1,3887,0,3243,1,3888,0,3728,0,3949,0,2172,0,3883,0,2658,1,1742,1,3484,0,3575,0,1737,0,1733,0,1734,0,1736,0,1735,0,878,0,1550,0,4068,0,4072,0,4070,0,4067,0,4069,0,860,1,2261,1,2260,1,2032,0,2054,0,2062,1,2039,1,4177,0,4217,1,3592,1,4242,1,2750,1;0;19;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;531;FLOAT;4135;FLOAT;529;FLOAT;3678;FLOAT;530;FLOAT;4127;FLOAT;4122;FLOAT;4134;FLOAT;1235;FLOAT3;1230;FLOAT;1461;FLOAT;1290;FLOAT;721;FLOAT;532;FLOAT;629;FLOAT3;534
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;1038;-1376,-384;Float;False;True;-1;4;TVEShaderCoreGUI;0;0;StandardSpecular;BOXOPHOBIC/The Vegetation Engine/Vegetation/Grass Subsurface Lit;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;True;Back;0;True;17;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;Geometry;ForwardOnly;16;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;0;True;20;0;True;7;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Absolute;0;Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback;205;-1;-1;-1;0;False;0;0;True;10;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;37;-2176,-1024;Inherit;False;1023.392;100;Internal;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;408;-2176,256;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2176,-512;Inherit;False;1024.392;100;Final;0;;0,1,0.5,1;0;0
WireConnection;1038;0;1048;0
WireConnection;1038;1;1048;528
WireConnection;1038;2;1048;2489
WireConnection;1038;3;1048;3678
WireConnection;1038;4;1048;530
WireConnection;1038;5;1048;531
WireConnection;1038;6;1048;1230
WireConnection;1038;9;1048;532
WireConnection;1038;11;1048;534
ASEEND*/
//CHKSM=D7B5EAA44B2B555D6AB734D9625CE66E4DF15E0B
