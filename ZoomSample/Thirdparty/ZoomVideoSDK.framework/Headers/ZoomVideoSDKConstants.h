//
//  ZoomVideoSDKConstants.h
//  ZoomVideoSDK
//
#ifndef ZoomVideoSDKConstants_h
#define ZoomVideoSDKConstants_h

/*!
 @brief ZoomVideoSDKERROR An enumeration of error.
 */
typedef NS_ENUM(NSUInteger,ZoomVideoSDKERROR)
{
    Errors_Success = 0,///<Success.
    Errors_Wrong_Usage,
    Errors_Internal_Error,
    Errors_Uninitialize,
    Errors_Memory_Error,
    Errors_Load_Module_Error,
    Errors_UnLoad_Module_Error,
    Errors_Invalid_Parameter,
    Errors_Unknown,
    Errors_Auth_Base = 1000,
    Errors_Auth_Error,
    Errors_Auth_Empty_Key_or_Secret,
    Errors_Auth_Wrong_Key_or_Secret,
    Errors_Auth_DoesNot_Support_SDK,
    Errors_Auth_Disable_SDK,
    Errors_Session_Base = 2000,
    Errors_Session_Module_Not_Found,
    Errors_Session_Service_Invaild,
    Errors_Session_Join_Failed,
    Errors_Session_No_Rights,
    Errors_Session_Already_In_Progress,
    Errors_Session_Dont_Support_SessionType,
    Errors_Session_Reconncting,
    Errors_Session_Disconncting,
    Errors_Session_Not_Started = 2010,
    Errors_Session_Need_Password,
    Errors_Session_Password_Wrong,
    Errors_Session_Remote_DB_Error,
    Errors_Session_Invalid_Param,
    Errors_Session_Audio_Error = 3000,
    Errors_Session_Audio_No_Microphone,
    Errors_Session_Video_Error = 4000,
    Errors_Session_Video_Device_Error,
    
    Errors_Session_Live_Stream_Error = 5000,
    
    Errors_Malloc_Failed = 6001,
    Errors_Not_In_Session,
    Errors_No_License,
    
    Errors_Video_Module_Not_Ready,
    Errors_Video_Module_Error,
    Errors_Video_device_error,
    Errors_No_Video_Data,
    
    Errors_Share_Module_Not_Ready,
    Errors_Share_Module_Error,
    Errors_No_Share_Data,
    
    Errors_Audio_Module_Not_Ready,
    Errors_Audio_Module_Error,
    Errors_No_Audio_Data,
    
    Errors_Preprocess_Rawdata_Error,
    Errors_Rawdata_No_Device_Running,
    Errors_Rawdata_Init_Device,
    Errors_Rawdata_Virtual_Device,
    Errors_Rawdata_Cannot_Change_Virtual_Device_In_Preview,
    Errors_Rawdata_Internal_Error,
    Errors_Rawdata_Send_Too_Much_Data_In_Single_Time,
    Errors_Rawdata_Send_Too_Frequently,
    Errors_Rawdata_Virtual_Mic_Is_Terminate,

    Errors_meeting_Share_Error = 7001,
    Errors_meeting_Share_Module_Not_Ready,
    Errors_meeting_Share_You_Are_Not_Sharing,
    Errors_meeting_Share_Type_Is_Not_Support,
    Errors_meeting_Share_Internal_Error,
};

/*!
 @brief ZoomVideoSDKAudioType An enumeration of audio type.
 */
typedef NS_ENUM(NSUInteger,ZoomVideoSDKAudioType) {
    ZoomVideoSDKAudioType_None   = 0,
    ZoomVideoSDKAudioType_VOIP,
    ZoomVideoSDKAudioType_Unknow,
};

/*!
 @brief ZoomVideoSDKVideoAspect An enumeration of video aspect.
 */
typedef NS_ENUM(NSUInteger, ZoomVideoSDKVideoAspect) {
    ///Original
    ZoomVideoSDKVideoAspect_Original         = 0,
    ///Full Filled
    ZoomVideoSDKVideoAspect_Full_Filled,
    ///Letter Box
    ZoomVideoSDKVideoAspect_LetterBox,
    ///Pan And Scan
    ZoomVideoSDKVideoAspect_PanAndScan,
};

/*!
 @brief ZoomVideoSDKVideoType An enumeration of video type.
 */
typedef NS_ENUM(NSUInteger, ZoomVideoSDKVideoType) {
    ///Video Camera Data
    ZoomVideoSDKVideoType_VideoData  = 1,
    ///Share Data
    ZoomVideoSDKVideoType_ShareData,
};

/*!
 @brief ZoomVideoSDKReceiveSharingStatus An enumeration of receive sharing status.
 */
typedef NS_ENUM(NSUInteger, ZoomVideoSDKReceiveSharingStatus) {
    ZoomVideoSDKReceiveSharingStatus_None = 0,
    ZoomVideoSDKReceiveSharingStatus_Start,
    ZoomVideoSDKReceiveSharingStatus_Pause,
    ZoomVideoSDKReceiveSharingStatus_Resume,
    ZoomVideoSDKReceiveSharingStatus_Stop,
};

/*!
 @brief ZoomVideoSDKLiveStreamStatus An enumeration of live stream status.
 */
typedef NS_ENUM(NSUInteger, ZoomVideoSDKLiveStreamStatus) {
    ZoomVideoSDKLiveStreamStatus_None = 1,
    ZoomVideoSDKLiveStreamStatus_InProgress,
    ZoomVideoSDKLiveStreamStatus_Connecting,
    ZoomVideoSDKLiveStreamStatus_FailedTimeout,
    ZoomVideoSDKLiveStreamStatus_StartFailed,
    ZoomVideoSDKLiveStreamStatus_Ended,
};

/*!
 @brief ZoomVideoSDKVideoRawDataFormat An enumeration of video raw data format.
 */
typedef NS_ENUM(NSUInteger, ZoomVideoSDKVideoRawDataFormat) {
    ZoomVideoSDKVideoRawDataFormatI420            = 1,
};

/*!
 @brief ZoomVideoSDKVideoRawDataRotation The direction of video.
 */
typedef NS_ENUM(NSInteger, ZoomVideoSDKVideoRawDataRotation) {
    /// video direction 0
    ZoomVideoSDKVideoRawDataRotationNone      = 1,
    /// video direction 90
    ZoomVideoSDKVideoRawDataRotation90,
    /// video direction 180
    ZoomVideoSDKVideoRawDataRotation180,
    /// video direction 270
    ZoomVideoSDKVideoRawDataRotation270,
};

/*!
 @brief ZoomVideoSDKVideoResolution An enumeration of video raw data resolution.
 */
typedef NS_ENUM(NSUInteger, ZoomVideoSDKVideoResolution) {
    /// video resolution 90
    ZoomVideoSDKVideoResolution_90,
    /// video resolution 180
    ZoomVideoSDKVideoResolution_180,
    /// video resolution 360
    ZoomVideoSDKVideoResolution_360,
    /// video resolution 720
    ZoomVideoSDKVideoResolution_720,
};

/*!
 @brief Rawdata memory mode.
 */
typedef NS_ENUM(NSUInteger, ZoomVideoSDKRawDataMemoryMode) {
    ZoomVideoSDKRawDataMemoryModeStack,
    ZoomVideoSDKRawDataMemoryModeHeap
};

/*!
 @brief user's rawdata status.
 */
typedef NS_ENUM(NSUInteger, ZoomVideoSDKUserRawdataStatus) {
    ZoomVideoSDKUserRawdataOn,
    ZoomVideoSDKUserRawdataOff
};

#endif /* ZoomVideoSDKConstants_h */
