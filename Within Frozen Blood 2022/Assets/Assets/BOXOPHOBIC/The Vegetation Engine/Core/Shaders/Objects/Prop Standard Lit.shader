// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Objects/Prop Standard Lit"
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
		[Enum(Off,0,On,1)]_RenderDecals("Receive Decals", Float) = 0
		[Enum(Off,0,On,1)]_RenderSSR("Receive SSR/SSGI", Float) = 0
		[Enum(Off,0,On,1)][Space(10)]_RenderClip("Alpha Clipping", Float) = 1
		_Cutoff("Alpha Treshold", Range( 0 , 1)) = 0.5
		[StyledSpace(10)]_FadeSpace("# Fade Space", Float) = 0
		[StyledCategory(Global Settings)]_GlobalCat("[ Global Cat ]", Float) = 0
		[StyledEnum(Default _Layer 1 _Layer 2 _Layer 3 _Layer 4 _Layer 5 _Layer 6 _Layer 7 _Layer 8)]_LayerExtrasValue("Layer Extras", Float) = 0
		[StyledSpace(10)]_LayersSpace("# Layers Space", Float) = 0
		[StyledMessage(Info, Procedural Variation in use. The Variation might not work as expected when switching from one LOD to another., _VertexVariationMode, 1 , 0, 10)]_VariationGlobalsMessage("# Variation Globals Message", Float) = 0
		_GlobalOverlay("Global Overlay", Range( 0 , 1)) = 1
		_GlobalWetness("Global Wetness", Range( 0 , 1)) = 1
		_GlobalEmissive("Global Emissive", Range( 0 , 1)) = 1
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
		_MainMetallicValue("Main Metallic", Range( 0 , 1)) = 0
		_MainOcclusionValue("Main Occlusion", Range( 0 , 1)) = 1
		_MainSmoothnessValue("Main Smoothness", Range( 0 , 1)) = 1
		[StyledRemapSlider(_LeavesMaskMinValue, _LeavesMaskMaxValue, 0, 1)]_LeavesMaskRemap("Main Leaves Mask", Vector) = (0,0,0,2)
		[StyledCategory(Detail Settings)]_DetailCat("[ Detail Cat ]", Float) = 0
		[Enum(Off,0,On,1)]_DetailMode("Detail Mode", Float) = 0
		[Enum(Overlay,0,Replace,1)]_DetailBlendMode("Detail Blend", Float) = 1
		[Enum(Vertex Blue,0,Projection,1)]_DetailTypeMode("Detail Type", Float) = 0
		[Enum(UV 0,0,UV 2,1)]_DetailCoordMode("Detail Coord", Float) = 0
		[Enum(Top,0,Bottom,1)]_DetailProjectionMode("Detail Projection", Float) = 0
		[NoScaleOffset][Space(10)][StyledTextureSingleLine]_SecondAlbedoTex("Detail Albedo", 2D) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine]_SecondNormalTex("Detail Normal", 2D) = "bump" {}
		[NoScaleOffset][StyledTextureSingleLine]_SecondMaskTex("Detail Mask", 2D) = "white" {}
		[Space(10)][StyledVector(9)]_SecondUVs("Detail UVs", Vector) = (1,1,0,0)
		[HDR]_SecondColor("Detail Color", Color) = (1,1,1,1)
		_SecondNormalValue("Detail Normal", Range( -8 , 8)) = 1
		_SecondMetallicValue("Detail Metallic", Range( 0 , 1)) = 0
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
		[StyledRemapSlider(_VertexOcclusionMinValue, _VertexOcclusionMaxValue, 0, 1)]_VertexOcclusionRemap("Vertex Occlusion Mask", Vector) = (0,0,0,0)
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
		[HideInInspector]_MaxBoundsInfo("_MaxBoundsInfo", Vector) = (1,1,1,1)
		[HideInInspector]_render_normals_options("_render_normals_options", Vector) = (1,1,1,0)
		[HideInInspector]_Color("_LegacyColor", Color) = (0,0,0,0)
		[HideInInspector]_MainTex("_LegacyMainTex", 2D) = "white" {}
		[HideInInspector]_BumpMap("_LegacyBumpMap", 2D) = "white" {}
		[HideInInspector]_VertexVariationMode("_VertexVariationMode", Float) = 0
		[HideInInspector]_VertexMasksMode("_VertexMasksMode", Float) = 0
		[HideInInspector]_IsTVEShader("_IsTVEShader", Float) = 1
		[HideInInspector]_IsVersion("_IsVersion", Float) = 500
		[HideInInspector]_HasEmissive("_HasEmissive", Float) = 0
		[HideInInspector]_HasGradient("_HasGradient", Float) = 0
		[HideInInspector]_HasOcclusion("_HasOcclusion", Float) = 0
		[HideInInspector]_IsPropShader("_IsPropShader", Float) = 1
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
		#include "UnityStandardUtils.cginc"
		#pragma target 4.0
		#pragma shader_feature_local TVE_ALPHA_CLIP
		#pragma shader_feature_local TVE_DETAIL_MODE_OFF TVE_DETAIL_MODE_ON
		#pragma shader_feature_local TVE_DETAIL_BLEND_OVERLAY TVE_DETAIL_BLEND_REPLACE
		#pragma shader_feature_local TVE_DETAIL_TYPE_VERTEX_BLUE TVE_DETAIL_TYPE_PROJECTION
		//TVE Pipeline Defines
		#define THE_VEGETATION_ENGINE
		#define TVE_IS_STANDARD_PIPELINE
		//TVE Shader Type Defines
		#define TVE_IS_OBJECT_SHADER
		//TVE Injection Defines
		//SHADER INJECTION POINT BEGIN
		//SHADER INJECTION POINT END
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D_ARRAY(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D_ARRAY(tex,samplertex,coord) tex2DArray(tex,coord)
		#endif//ASE Sampling Macros

		#pragma surface surf Standard keepalpha addshadow fullforwardshadows dithercrossfade vertex:vertexDataFunc 
		struct Input
		{
			float2 vertexToFrag11_g56530;
			float2 vertexToFrag11_g56520;
			float3 worldPos;
			float vertexToFrag11_g56563;
			float3 worldNormal;
			INTERNAL_DATA
			half ASEVFace : VFACE;
			float3 vertexToFrag3890_g56088;
			float2 vertexToFrag11_g56542;
		};

		uniform half _render_cull;
		uniform half _IsPropShader;
		uniform half _IsStandardShader;
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
		uniform half _DisableSRPBatcher;
		uniform sampler2D _MainNormalTex;
		uniform half4 _MainUVs;
		uniform half _MainNormalValue;
		uniform sampler2D _SecondNormalTex;
		uniform half _DetailCoordMode;
		uniform half4 _SecondUVs;
		uniform half _SecondNormalValue;
		uniform half _DetailMeshValue;
		uniform half _DetailProjectionMode;
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
		uniform half4 _EmissiveColor;
		uniform float4 _EmissiveIntensityParams;
		uniform sampler2D _EmissiveTex;
		uniform half4 _EmissiveUVs;
		uniform half _GlobalEmissive;
		uniform half _MainMetallicValue;
		uniform half _SecondMetallicValue;
		uniform half _MainSmoothnessValue;
		uniform half _SecondSmoothnessValue;
		uniform half TVE_OverlaySmoothness;
		uniform half _GlobalWetness;
		uniform half _MainOcclusionValue;
		uniform half _SecondOcclusionValue;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VertexPosition3588_g56088 = ase_vertex3Pos;
			float3 Final_VertexPosition890_g56088 = ( VertexPosition3588_g56088 + _DisableSRPBatcher );
			v.vertex.xyz = Final_VertexPosition890_g56088;
			v.vertex.w = 1;
			o.vertexToFrag11_g56530 = ( ( v.texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
			float2 lerpResult1545_g56088 = lerp( v.texcoord.xy , v.texcoord1.xy , _DetailCoordMode);
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			#if defined(TVE_DETAIL_TYPE_VERTEX_BLUE)
				float2 staticSwitch3466_g56088 = lerpResult1545_g56088;
			#elif defined(TVE_DETAIL_TYPE_PROJECTION)
				float2 staticSwitch3466_g56088 = (ase_worldPos).xz;
			#else
				float2 staticSwitch3466_g56088 = lerpResult1545_g56088;
			#endif
			o.vertexToFrag11_g56520 = ( ( staticSwitch3466_g56088 * (_SecondUVs).xy ) + (_SecondUVs).zw );
			half Mesh_DetailMask90_g56088 = v.color.b;
			o.vertexToFrag11_g56563 = ( ( Mesh_DetailMask90_g56088 - 0.5 ) + _DetailMeshValue );
			o.vertexToFrag3890_g56088 = ase_worldPos;
			o.vertexToFrag11_g56542 = ( ( v.texcoord.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			half2 Main_UVs15_g56088 = i.vertexToFrag11_g56530;
			half3 Main_Normal137_g56088 = UnpackScaleNormal( tex2D( _MainNormalTex, Main_UVs15_g56088 ), _MainNormalValue );
			half2 Second_UVs17_g56088 = i.vertexToFrag11_g56520;
			half3 Second_Normal179_g56088 = UnpackScaleNormal( tex2D( _SecondNormalTex, Second_UVs17_g56088 ), _SecondNormalValue );
			float temp_output_3919_0_g56088 = i.vertexToFrag11_g56563;
			float3 Main_Normal_WS4101_g56088 = (WorldNormalVector( i , Main_Normal137_g56088 ));
			float lerpResult1537_g56088 = lerp( Main_Normal_WS4101_g56088.y , -Main_Normal_WS4101_g56088.y , _DetailProjectionMode);
			#if defined(TVE_DETAIL_TYPE_VERTEX_BLUE)
				float staticSwitch3467_g56088 = temp_output_3919_0_g56088;
			#elif defined(TVE_DETAIL_TYPE_PROJECTION)
				float staticSwitch3467_g56088 = ( ( lerpResult1537_g56088 * 0.5 ) + _DetailMeshValue );
			#else
				float staticSwitch3467_g56088 = temp_output_3919_0_g56088;
			#endif
			half Blend_Source1540_g56088 = staticSwitch3467_g56088;
			float4 tex2DNode35_g56088 = tex2D( _MainMaskTex, Main_UVs15_g56088 );
			half Main_Mask57_g56088 = tex2DNode35_g56088.b;
			float4 tex2DNode33_g56088 = tex2D( _SecondMaskTex, Second_UVs17_g56088 );
			half Second_Mask81_g56088 = tex2DNode33_g56088.b;
			float lerpResult1327_g56088 = lerp( Main_Mask57_g56088 , Second_Mask81_g56088 , _DetailMaskMode);
			float lerpResult4058_g56088 = lerp( lerpResult1327_g56088 , ( 1.0 - lerpResult1327_g56088 ) , _DetailMaskInvertMode);
			float temp_output_7_0_g56541 = _DetailBlendMinValue;
			half Mask_Detail147_g56088 = saturate( ( ( saturate( ( Blend_Source1540_g56088 + ( Blend_Source1540_g56088 * lerpResult4058_g56088 ) ) ) - temp_output_7_0_g56541 ) / ( _DetailBlendMaxValue - temp_output_7_0_g56541 ) ) );
			float3 lerpResult230_g56088 = lerp( float3( 0,0,1 ) , Second_Normal179_g56088 , Mask_Detail147_g56088);
			float3 lerpResult3372_g56088 = lerp( float3( 0,0,1 ) , Main_Normal137_g56088 , _DetailNormalValue);
			float3 lerpResult3376_g56088 = lerp( Main_Normal137_g56088 , BlendNormals( lerpResult3372_g56088 , Second_Normal179_g56088 ) , Mask_Detail147_g56088);
			#if defined(TVE_DETAIL_BLEND_OVERLAY)
				float3 staticSwitch4063_g56088 = BlendNormals( Main_Normal137_g56088 , lerpResult230_g56088 );
			#elif defined(TVE_DETAIL_BLEND_REPLACE)
				float3 staticSwitch4063_g56088 = lerpResult3376_g56088;
			#else
				float3 staticSwitch4063_g56088 = BlendNormals( Main_Normal137_g56088 , lerpResult230_g56088 );
			#endif
			#if defined(TVE_DETAIL_MODE_OFF)
				float3 staticSwitch267_g56088 = Main_Normal137_g56088;
			#elif defined(TVE_DETAIL_MODE_ON)
				float3 staticSwitch267_g56088 = staticSwitch4063_g56088;
			#else
				float3 staticSwitch267_g56088 = Main_Normal137_g56088;
			#endif
			float3 temp_output_13_0_g56521 = staticSwitch267_g56088;
			float3 switchResult12_g56521 = (((i.ASEVFace>0)?(temp_output_13_0_g56521):(( temp_output_13_0_g56521 * _render_normals_options ))));
			half3 Blend_Normal312_g56088 = switchResult12_g56521;
			half3 Final_Normal366_g56088 = Blend_Normal312_g56088;
			o.Normal = Final_Normal366_g56088;
			half Leaves_Mask4511_g56088 = 1.0;
			float3 lerpResult4521_g56088 = lerp( float3( 1,1,1 ) , ( float3(1,1,1) * float3(1,1,1) * float3(1,1,1) ) , Leaves_Mask4511_g56088);
			float3 lerpResult4519_g56088 = lerp( float3( 1,1,1 ) , (_MainColor).rgb , Leaves_Mask4511_g56088);
			float4 tex2DNode29_g56088 = tex2D( _MainAlbedoTex, Main_UVs15_g56088 );
			half3 Main_Albedo99_g56088 = ( lerpResult4519_g56088 * (tex2DNode29_g56088).rgb );
			half3 Second_Albedo153_g56088 = (( _SecondColor * tex2D( _SecondAlbedoTex, Second_UVs17_g56088 ) )).rgb;
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g56501 = 2.0;
			#else
				float staticSwitch1_g56501 = 4.594794;
			#endif
			float3 lerpResult235_g56088 = lerp( Main_Albedo99_g56088 , ( Main_Albedo99_g56088 * Second_Albedo153_g56088 * staticSwitch1_g56501 ) , Mask_Detail147_g56088);
			float3 lerpResult208_g56088 = lerp( Main_Albedo99_g56088 , Second_Albedo153_g56088 , Mask_Detail147_g56088);
			#if defined(TVE_DETAIL_BLEND_OVERLAY)
				float3 staticSwitch4062_g56088 = lerpResult235_g56088;
			#elif defined(TVE_DETAIL_BLEND_REPLACE)
				float3 staticSwitch4062_g56088 = lerpResult208_g56088;
			#else
				float3 staticSwitch4062_g56088 = lerpResult235_g56088;
			#endif
			#if defined(TVE_DETAIL_MODE_OFF)
				float3 staticSwitch255_g56088 = Main_Albedo99_g56088;
			#elif defined(TVE_DETAIL_MODE_ON)
				float3 staticSwitch255_g56088 = staticSwitch4062_g56088;
			#else
				float3 staticSwitch255_g56088 = Main_Albedo99_g56088;
			#endif
			half3 Blend_Albedo265_g56088 = staticSwitch255_g56088;
			half3 Blend_AlbedoTinted2808_g56088 = ( lerpResult4521_g56088 * Blend_Albedo265_g56088 );
			half3 Blend_AlbedoColored863_g56088 = Blend_AlbedoTinted2808_g56088;
			half3 Blend_AlbedoAndSubsurface149_g56088 = Blend_AlbedoColored863_g56088;
			half3 Global_OverlayColor1758_g56088 = (TVE_OverlayColor).rgb;
			float lerpResult3567_g56088 = lerp( _OverlayBottomValue , 1.0 , Main_Normal_WS4101_g56088.y);
			half Main_AlbedoTex_G3526_g56088 = tex2DNode29_g56088.g;
			half Second_AlbedoTex_G3581_g56088 = (tex2D( _SecondAlbedoTex, Second_UVs17_g56088 )).g;
			float lerpResult3579_g56088 = lerp( Main_AlbedoTex_G3526_g56088 , Second_AlbedoTex_G3581_g56088 , Mask_Detail147_g56088);
			#if defined(TVE_DETAIL_MODE_OFF)
				float staticSwitch3574_g56088 = Main_AlbedoTex_G3526_g56088;
			#elif defined(TVE_DETAIL_MODE_ON)
				float staticSwitch3574_g56088 = lerpResult3579_g56088;
			#else
				float staticSwitch3574_g56088 = Main_AlbedoTex_G3526_g56088;
			#endif
			float3 WorldPosition3905_g56088 = i.vertexToFrag3890_g56088;
			float3 Position82_g56552 = WorldPosition3905_g56088;
			float temp_output_84_0_g56552 = _LayerExtrasValue;
			float4 lerpResult88_g56552 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, float3(( (TVE_ExtrasCoord).zw + ( (TVE_ExtrasCoord).xy * (Position82_g56552).xz ) ),temp_output_84_0_g56552) ) , TVE_ExtrasUsage[(int)temp_output_84_0_g56552]);
			float4 break89_g56552 = lerpResult88_g56552;
			half Global_Extras_Overlay156_g56088 = break89_g56552.b;
			float temp_output_1025_0_g56088 = ( _GlobalOverlay * Global_Extras_Overlay156_g56088 );
			half Overlay_Commons1365_g56088 = temp_output_1025_0_g56088;
			float temp_output_7_0_g56528 = _OverlayMaskMinValue;
			half Overlay_Mask269_g56088 = saturate( ( ( ( ( ( lerpResult3567_g56088 * 0.5 ) + staticSwitch3574_g56088 ) * Overlay_Commons1365_g56088 ) - temp_output_7_0_g56528 ) / ( _OverlayMaskMaxValue - temp_output_7_0_g56528 ) ) );
			float3 lerpResult336_g56088 = lerp( Blend_AlbedoAndSubsurface149_g56088 , Global_OverlayColor1758_g56088 , Overlay_Mask269_g56088);
			half3 Final_Albedo359_g56088 = lerpResult336_g56088;
			o.Albedo = Final_Albedo359_g56088;
			float4 temp_output_4214_0_g56088 = ( _EmissiveColor * _EmissiveIntensityParams.x );
			half2 Emissive_UVs2468_g56088 = i.vertexToFrag11_g56542;
			half Global_Extras_Emissive4203_g56088 = break89_g56552.r;
			float lerpResult4206_g56088 = lerp( 1.0 , Global_Extras_Emissive4203_g56088 , _GlobalEmissive);
			half3 Final_Emissive2476_g56088 = ( (( temp_output_4214_0_g56088 * tex2D( _EmissiveTex, Emissive_UVs2468_g56088 ) )).rgb * lerpResult4206_g56088 );
			o.Emission = Final_Emissive2476_g56088;
			half Main_Metallic237_g56088 = ( tex2DNode35_g56088.r * _MainMetallicValue );
			half Second_Metallic226_g56088 = ( tex2DNode33_g56088.r * _SecondMetallicValue );
			float lerpResult278_g56088 = lerp( Main_Metallic237_g56088 , Second_Metallic226_g56088 , Mask_Detail147_g56088);
			#if defined(TVE_DETAIL_BLEND_OVERLAY)
				float staticSwitch4064_g56088 = Main_Metallic237_g56088;
			#elif defined(TVE_DETAIL_BLEND_REPLACE)
				float staticSwitch4064_g56088 = lerpResult278_g56088;
			#else
				float staticSwitch4064_g56088 = Main_Metallic237_g56088;
			#endif
			#if defined(TVE_DETAIL_MODE_OFF)
				float staticSwitch299_g56088 = Main_Metallic237_g56088;
			#elif defined(TVE_DETAIL_MODE_ON)
				float staticSwitch299_g56088 = staticSwitch4064_g56088;
			#else
				float staticSwitch299_g56088 = Main_Metallic237_g56088;
			#endif
			half Blend_Metallic306_g56088 = staticSwitch299_g56088;
			float lerpResult342_g56088 = lerp( Blend_Metallic306_g56088 , 0.0 , Overlay_Mask269_g56088);
			half Final_Metallic367_g56088 = lerpResult342_g56088;
			o.Metallic = Final_Metallic367_g56088;
			half Main_Smoothness227_g56088 = ( tex2DNode35_g56088.a * _MainSmoothnessValue );
			half Second_Smoothness236_g56088 = ( tex2DNode33_g56088.a * _SecondSmoothnessValue );
			float lerpResult266_g56088 = lerp( Main_Smoothness227_g56088 , Second_Smoothness236_g56088 , Mask_Detail147_g56088);
			#if defined(TVE_DETAIL_BLEND_OVERLAY)
				float staticSwitch4065_g56088 = Main_Smoothness227_g56088;
			#elif defined(TVE_DETAIL_BLEND_REPLACE)
				float staticSwitch4065_g56088 = lerpResult266_g56088;
			#else
				float staticSwitch4065_g56088 = Main_Smoothness227_g56088;
			#endif
			#if defined(TVE_DETAIL_MODE_OFF)
				float staticSwitch297_g56088 = Main_Smoothness227_g56088;
			#elif defined(TVE_DETAIL_MODE_ON)
				float staticSwitch297_g56088 = staticSwitch4065_g56088;
			#else
				float staticSwitch297_g56088 = Main_Smoothness227_g56088;
			#endif
			half Blend_Smoothness314_g56088 = staticSwitch297_g56088;
			half Global_OverlaySmoothness311_g56088 = TVE_OverlaySmoothness;
			float lerpResult343_g56088 = lerp( Blend_Smoothness314_g56088 , Global_OverlaySmoothness311_g56088 , Overlay_Mask269_g56088);
			half Final_Smoothness371_g56088 = lerpResult343_g56088;
			half Global_Extras_Wetness305_g56088 = break89_g56552.g;
			float lerpResult3673_g56088 = lerp( 0.0 , Global_Extras_Wetness305_g56088 , _GlobalWetness);
			half Final_SmoothnessAndWetness4130_g56088 = saturate( ( Final_Smoothness371_g56088 + lerpResult3673_g56088 ) );
			o.Smoothness = Final_SmoothnessAndWetness4130_g56088;
			float lerpResult240_g56088 = lerp( 1.0 , tex2DNode35_g56088.g , _MainOcclusionValue);
			half Main_Occlusion247_g56088 = lerpResult240_g56088;
			float lerpResult239_g56088 = lerp( 1.0 , tex2DNode33_g56088.g , _SecondOcclusionValue);
			half Second_Occlusion251_g56088 = lerpResult239_g56088;
			float lerpResult294_g56088 = lerp( Main_Occlusion247_g56088 , Second_Occlusion251_g56088 , Mask_Detail147_g56088);
			#if defined(TVE_DETAIL_BLEND_OVERLAY)
				float staticSwitch4066_g56088 = Main_Occlusion247_g56088;
			#elif defined(TVE_DETAIL_BLEND_REPLACE)
				float staticSwitch4066_g56088 = lerpResult294_g56088;
			#else
				float staticSwitch4066_g56088 = Main_Occlusion247_g56088;
			#endif
			#if defined(TVE_DETAIL_MODE_OFF)
				float staticSwitch310_g56088 = Main_Occlusion247_g56088;
			#elif defined(TVE_DETAIL_MODE_ON)
				float staticSwitch310_g56088 = staticSwitch4066_g56088;
			#else
				float staticSwitch310_g56088 = Main_Occlusion247_g56088;
			#endif
			half Blend_Occlusion323_g56088 = staticSwitch310_g56088;
			o.Occlusion = Blend_Occlusion323_g56088;
			float localCustomAlphaClip3735_g56088 = ( 0.0 );
			half Final_AlphaFade3727_g56088 = 1.0;
			float Main_Alpha316_g56088 = ( _MainColor.a * tex2DNode29_g56088.a );
			half AlphaTreshold2132_g56088 = _Cutoff;
			#ifdef TVE_ALPHA_CLIP
				float staticSwitch3792_g56088 = ( Main_Alpha316_g56088 - ( AlphaTreshold2132_g56088 - 0.5 ) );
			#else
				float staticSwitch3792_g56088 = Main_Alpha316_g56088;
			#endif
			half Final_Alpha3754_g56088 = staticSwitch3792_g56088;
			float temp_output_661_0_g56088 = ( Final_AlphaFade3727_g56088 * Final_Alpha3754_g56088 );
			float Alpha3735_g56088 = temp_output_661_0_g56088;
			float Treshold3735_g56088 = 0.5;
			{
			#if TVE_ALPHA_CLIP
				clip(Alpha3735_g56088 - Treshold3735_g56088);
			#endif
			}
			half Final_Clip914_g56088 = saturate( Alpha3735_g56088 );
			o.Alpha = Final_Clip914_g56088;
		}

		ENDCG
	}
	Fallback "Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback"
	CustomEditor "TVEShaderCoreGUI"
}
/*ASEBEGIN
Version=18909
1920;0;1920;1029;2725.378;419.7064;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;10;-2176,-768;Half;False;Property;_render_cull;_render_cull;203;1;[HideInInspector];Create;True;0;3;Both;0;Back;1;Front;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;127;-2176,-896;Half;False;Property;_IsPropShader;_IsPropShader;201;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-1984,-896;Half;False;Property;_IsStandardShader;_IsStandardShader;202;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1984,-768;Half;False;Property;_render_src;_render_src;205;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1792,-768;Half;False;Property;_render_dst;_render_dst;206;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1600,-768;Half;False;Property;_render_zw;_render_zw;207;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;386;-1344,-896;Inherit;False;Compile All Shaders;-1;;51076;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;387;-1536,-896;Inherit;False;Compile Core;-1;;51077;634b02fd1f32e6a4c875d8fc2c450956;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;384;-1888,384;Inherit;False;Define Pipeline Standard;-1;;56086;9af03ae8defe78d448ef2a4ef3601e12;0;0;1;FLOAT;529
Node;AmplifyShaderEditor.FunctionNode;343;-2176,384;Inherit;False;Define Shader Object;-1;;56087;1237b3cc9fbfe714d8343c91216dc9b4;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;393;-2176,-384;Inherit;False;Base Shader;0;;56088;856f7164d1c579d43a5cf4968a75ca43;81,3882,1,3880,1,3957,0,4028,1,4029,1,3903,1,3900,1,3904,1,4204,1,3908,1,4172,1,1300,1,1298,1,4179,1,3586,0,4499,0,1708,0,3658,0,3509,1,1712,0,3873,1,1714,1,1715,1,1717,1,1718,1,916,1,1762,0,1763,0,3568,1,1949,1,1776,0,3475,1,4210,1,893,0,1745,0,3479,0,4510,0,3501,0,3221,2,1646,0,1757,0,1271,0,3889,1,2807,0,3886,0,2953,0,3887,0,3243,0,3888,0,3728,0,3949,0,2172,0,3883,0,2658,0,1742,0,3484,0,3575,1,1737,1,1733,1,1734,1,1736,1,1735,1,878,1,1550,1,4068,0,4072,0,4070,0,4067,0,4069,0,860,0,2261,1,2260,1,2032,1,2054,1,2062,1,2039,1,4177,1,4217,1,3592,1,4242,0,2750,0;0;19;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;531;FLOAT;4135;FLOAT;529;FLOAT;3678;FLOAT;530;FLOAT;4127;FLOAT;4122;FLOAT;4134;FLOAT;1235;FLOAT3;1230;FLOAT;1461;FLOAT;1290;FLOAT;721;FLOAT;532;FLOAT;629;FLOAT3;534
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;383;-1376,-384;Float;False;True;-1;4;TVEShaderCoreGUI;0;0;Standard;BOXOPHOBIC/The Vegetation Engine/Objects/Prop Standard Lit;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;True;Back;0;True;17;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;Geometry;All;16;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;0;True;20;0;True;7;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Absolute;0;Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback;204;-1;-1;-1;0;False;0;0;True;10;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;340;-2176,256;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;37;-2176,-1024;Inherit;False;1026.438;100;Internal;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2176,-512;Inherit;False;1022.896;100;Final;0;;0,1,0.5,1;0;0
WireConnection;383;0;393;0
WireConnection;383;1;393;528
WireConnection;383;2;393;2489
WireConnection;383;3;393;529
WireConnection;383;4;393;530
WireConnection;383;5;393;531
WireConnection;383;9;393;532
WireConnection;383;11;393;534
ASEEND*/
//CHKSM=67A5438D5C455A82DBD689F74A8E4B4B974E7B06
