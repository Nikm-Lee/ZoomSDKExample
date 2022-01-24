//
//  ZoomVideoSDKDelegate.h
//  ZoomVideoSDK
//

#import <Foundation/Foundation.h>
#import "ZoomVideoSDKConstants.h"
#import "ZoomVideoSDKVideoRawData.h"
#import "ZoomVideoSDKAudioRawData.h"
#import "ZoomVideoSDKChatHelper.h"
#import "ZoomVideoSDKPreProcessRawData.h"
#import "ZoomVideoSDKVideoSender.h"
#import "ZoomVideoSDKAudioSender.h"
#import "ZoomVideoSDKVideoCapability.h"
#import "ZoomVideoSDKVideoHelper.h"
#import "ZoomVideoSDKAudioHelper.h"
#import "ZoomVideoSDKShareHelper.h"
#import "ZoomVideoSDKLiveStreamHelper.h"
#import "ZoomVideoSDKUserHelper.h"

@class ZoomVideoSDKUser;
/*!
 @brief Methods  to manage meeting events callback from ZoomVideoSDK.
 */
@protocol ZoomVideoSDKDelegate <NSObject>
@optional
/*!
 @brief The callback of session join.
 */
- (void)onSessionJoin;

/*!
 @brief The callback of session left.
 */
- (void)onSessionLeave;

/*!
 @brief The callback of all event error message.
 @param ErrorType error type in enumeration
 @param details The detail of error message.
 */
- (void)onError:(ZoomVideoSDKERROR)ErrorType detail:(NSInteger)details;

/*!
 @brief The callback of user join session.
 @param userArray Array contains join users.
 */
- (void)onUserJoin:(ZoomVideoSDKUserHelper *)helper users:(NSArray <ZoomVideoSDKUser *>*)userArray;

/*!
 @brief The callback of user left session.
 @param userArray Array contains leave users.
 */
- (void)onUserLeave:(ZoomVideoSDKUserHelper *)helper users:(NSArray <ZoomVideoSDKUser *>*)userArray;

/*!
 @brief The callback of user's video status change.
 @param userArray Array contains video status change users.
 */
- (void)onUserVideoStatusChanged:(ZoomVideoSDKVideoHelper *)helper user:(NSArray <ZoomVideoSDKUser *>*)userArray;

/*!
 @brief The callback of user's audio status change.
 @param userArray Array contains audio status change users.
 */
- (void)onUserAudioStatusChanged:(ZoomVideoSDKAudioHelper *)helper user:(NSArray <ZoomVideoSDKUser *>*)userArray;

/*!
 @brief The callback of user's share status change.
 @param status share status in enumeration.
 */
- (void)onUserShareStatusChanged:(ZoomVideoSDKShareHelper *)helper user:(ZoomVideoSDKUser *)user status:(ZoomVideoSDKReceiveSharingStatus)status;

/*!
 @brief The callback of user's live stream status change.
 @param status live stream status in enumeration.
 */
- (void)onLiveStreamStatusChanged:(ZoomVideoSDKLiveStreamHelper *)helper status:(ZoomVideoSDKLiveStreamStatus)status;

/*!
 @brief The callback of instant message in the session.
 @param chatMessage the object which contains the message content.
 */
- (void)onChatNewMessageNotify:(ZoomVideoSDKChatHelper *)helper message:(ZoomVideoSDKChatMessage *)chatMessage;

/*!
 @brief The callback of session's host change.
 */
- (void)onUserHostChanged:(ZoomVideoSDKUserHelper *)helper users:(ZoomVideoSDKUser *)user;

/*!
@brief The callback of session's manager change.
*/
- (void)onUserManagerChanged:(ZoomVideoSDKUser *)user;

/*!
@brief The callback of user's name change.
*/
- (void)onUserNameChanged:(ZoomVideoSDKUser *)user;

/*!
 @brief The callback of active audio change.
 @param userArray The array of active users.
 */
- (void)onUserActiveAudioChanged:(ZoomVideoSDKUserHelper *)helper users:(NSArray <ZoomVideoSDKUser *>*)userArray;

/*!
 @brief The callback of the session need password.
 */
- (void)onSessionNeedPassword:(ZoomVideoSDKERROR (^)(NSString *password, BOOL leaveSessionIgnorePassword))completion;

/*!
 @brief The callback of the session password wrong.
 */
- (void)onSessionPasswordWrong:(ZoomVideoSDKERROR (^)(NSString *password, BOOL leaveSessionIgnorePassword))completion;

/*!
 @brief This method is used to receive audio mixed raw data.
 @param rawData Audio's raw data.
 */
- (void)onMixedAudioRawDataReceived:(ZoomVideoSDKAudioRawData *)rawData;

/*!
 @brief This method is used to receive each user audio raw data.
 @param rawData Audio's raw data.
 */
- (void)onOneWayAudioRawDataReceived:(ZoomVideoSDKAudioRawData *)rawData user:(ZoomVideoSDKUser *)user;

/*!
 @brief This method is used to receive share audio raw data.
 @param rawData Audio's raw data.
 */
- (void)onSharedAudioRawDataReceived:(ZoomVideoSDKAudioRawData *)rawData;
@end

/*!
 @brief Methods to handle virtual audio speaker.
 */
@protocol ZoomVideoSDKVirtualAudioSpeaker <NSObject>

@optional

/*!
 @brief This method is used to receive audio mixed raw data.
 @param rawData Audio's raw data.
 */
- (void)onVirtualSpeakerMixedAudioReceived:(ZoomVideoSDKAudioRawData *)rawData;

/*!
 @brief This method is used to receive each user audio raw data.
 @param rawData Audio's raw data.
 */
- (void)onVirtualSpeakerOneWayAudioReceived:(ZoomVideoSDKAudioRawData *)rawData user:(ZoomVideoSDKUser *)user;

/*!
 @brief The callback event for receiving the share audio raw data.
 @param rawData Audio's raw data.
 */
- (void)onVirtualSpeakerSharedAudioReceived:(ZoomVideoSDKAudioRawData *)rawData;

@end

#pragma mark - ZoomVideoSDKRawDataPipeDelegate
/*!
 @brief Methods to manage events for receiving video raw data.
 */
@protocol ZoomVideoSDKRawDataPipeDelegate <NSObject>

@optional

/*!
 @brief This method is used to receive video's NV12 data(CVPixelBufferRef).
 @param pixelBuffer Video's CVPixelBufferRef data.
 */
- (void)onPixelBuffer:(CVPixelBufferRef)pixelBuffer
             rotation:(ZoomVideoSDKVideoRawDataRotation)rotation;

/*!
 @brief This method is used to receive video's YUV420 data.
 @param rawData Video's YUV420 data.
 */
- (void)onRawDataFrameReceived:(ZoomVideoSDKVideoRawData *)rawData;

/*!
 @brief Callback event when the sender stop/start to sending raw data.
 @param userRawdataStatus Raw data is sending or not.
 */
- (void)onRawDataStatusChanged:(ZoomVideoSDKUserRawdataStatus)userRawdataStatus;

@end


/*!
 @brief Methods to modify default device capture raw data. @See ZoomVideoSDKSessionContext#preProcessor.
 */
@protocol ZoomVideoSDKVideoSourcePreProcessor <NSObject>

@optional
/*!
 @brief Callback on device capture video frame.
 @param rawData See ZoomVideoSDKPreProcessRawData
 */
- (void)onPreProcessRawData:(ZoomVideoSDKPreProcessRawData *)rawData;

@end

/*!
 @brief Custom external video source interface.
 */
@protocol ZoomVideoSDKVideoSource <NSObject>

@optional

/*!
 @brief Callback for video source prepare.
 @param rawDataSender See ZoomVideoSDKVideoSender
 @param supportCapabilityArray See ZoomVideoSDKVideoCapability
 @param suggestCapability See ZoomVideoSDKVideoCapability
 */
- (void)onInitialize:(ZoomVideoSDKVideoSender *_Nonnull)rawDataSender supportCapabilityArray:(NSArray *_Nonnull)supportCapabilityArray suggestCapability:(ZoomVideoSDKVideoCapability *_Nonnull)suggestCapability;

/*!
 @brief Callback for video size or fps changed.
 @param supportCapabilityArray See ZoomVideoSDKVideoCapability
 @param suggestCapability See ZoomVideoSDKVideoCapability
 */
- (void)onPropertyChange:(NSArray *_Nonnull)supportCapabilityArray suggestCapability:(ZoomVideoSDKVideoCapability *_Nonnull)suggestCapability;

/*!
 @brief Callback for video source should start send raw data.
 */
- (void)onStartSend;

/*!
 @brief Callback for video source should stop send raw data. eg.user mute video
 */
- (void)onStopSend;

/*!
 @brief Callback for video source uninitialized. eg.leave session.
 */
- (void)onUninitialized;

@end

/*!
 @brief Methods to handle virtual audio mic.
 */
@protocol ZoomVideoSDKVirtualAudioMic <NSObject>

@optional
/*!
 @brief Callback for video source prepare.
 @param rawDataSender you can send audio data based on this object, See ZoomVideoSDKAudioSender
 */
- (void)onMicInitialize:(ZoomVideoSDKAudioSender *_Nonnull)rawDataSender;

/*!
 @brief Callback for audio source can start send raw data.
 */
- (void)onMicStartSend;

/*!
 @brief Callback for audio source stop send raw data. eg.user mute audio
 */
- (void)onMicStopSend;

/*!
 @brief Callback for audio source uninitialized. eg.leave session.
 */
- (void)onMicUninitialized;

@end
