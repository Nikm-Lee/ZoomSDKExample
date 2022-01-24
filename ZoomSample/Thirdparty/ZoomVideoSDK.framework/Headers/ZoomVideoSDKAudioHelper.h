//
//  ZoomVideoSDKAudioHelper.h
//  ZoomVideoSDK
//
//  Created by Zoom Video Communications on 2018/12/6.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoomVideoSDK.h"

/*!
 @class ZoomVideoSDKAudioHelper
 @brief A class to operate the audio action.
 */
@interface ZoomVideoSDKAudioHelper : NSObject

/*!
 @brief Start audio.
 @return the result of it
 */
- (ZoomVideoSDKERROR)startAudio;

/*!
 @brief Stop audio.
 @return the result of it
 */
- (ZoomVideoSDKERROR)stopAudio;

/*!
 @brief Mute user audio by userId
 @return the result of it
 @warning If mute self use userid=0.
 @warning Only user who start the session can mute others audio..
 */
- (ZoomVideoSDKERROR)muteAudio:(ZoomVideoSDKUser *)user;

/*!
 @brief Unmute user audio by userId
 @return the result of it
 @warning If unmute self use userid=0.
 @warning Only user who start the session can unmute others audio..
 */
- (ZoomVideoSDKERROR)unmuteAudio:(ZoomVideoSDKUser *)user;

/*!
 @brief Call the function to subscribe audio rawdata.
 */
- (ZoomVideoSDKERROR)subscribe;

/*!
 @brief Call the function to unSubscribe audio rawdata.
 */
- (ZoomVideoSDKERROR)unSubscribe;

@end

