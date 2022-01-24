//
//  ZoomVideoSDKChatHelper.h
//  ZoomVideoSDK
//
//  Created by Zoom Video Communications on 2019/1/9.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class ZoomVideoSDKChatMessage
 @brief A class that contains all the information for a message.
 */

@class ZoomVideoSDKUser;
@interface ZoomVideoSDKChatMessage : NSObject
/*!
 @brief The sender user.
 */
@property (nonatomic, strong) ZoomVideoSDKUser   *senderUser;

/*!
 @brief The receiver user.
 */
@property (nonatomic, strong) ZoomVideoSDKUser   *receiverUser;

/*!
 @brief The message content.
 */
@property (nonatomic, strong) NSString     *content;
/*!
 @brief The message sent time in timestamp.
 */
@property (nonatomic, assign) long long    timeStamp;
/*!
 @brief The message is send to all user or not.
 */
@property (nonatomic, assign) BOOL         isChatToAll;
/*!
 @brief The message is send by me or not.
 */
@property (nonatomic, assign) BOOL         isSelfSend;

@end

/*!
 @class ZoomVideoSDKChatHelper
 @brief A class to operate the instant message in session.
 */
@interface ZoomVideoSDKChatHelper : NSObject

/*!
 @brief Call the function to send a message to a specified user.
 @param user The user who you want to send message.
 @param content The content what you want to send.
 @return The result of it.
 */
- (ZoomVideoSDKERROR)SendChatToUser:(ZoomVideoSDKUser *)user Content:(NSString *)content;

/*!
 @brief Call the function to send a message to all users.
 @param content The content what you want to send.
 @return The result of it.
 */
- (ZoomVideoSDKERROR)SendChatToAll:(NSString *)content;

/*!
 @brief Call the function to check that chat feature is disabled or not.
 @return Yes means disabled, otherwise enabled.
 */
- (BOOL)IsChatDisabled;

/*!
 @brief Call the function to check that private chats are disabed or not.
 @return Yes means disabled, Otherwise enabled.
 */
- (BOOL)IsPrivateChatDisabled;

@end
