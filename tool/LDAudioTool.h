//
//  LDAudioTool.h
//  14.音频的播放
//
//  Created by mac on 15/11/10.
//  Copyright © 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface LDAudioTool : NSObject

/**
 播放本地音乐
 */
+(BOOL)playLocalMusicWithName:(NSString * )name;

/**
 停止本地音乐
 */
+(void)stopLocalMusicWithName:(NSString * )name;

/**
暂停本地音乐
 */
+(void)pauseLocalMusicWithName:(NSString * )name;


/**
 播放本地短音频
 */
+(void)playLocalAudioWithName:(NSString * )name;


/**
 销毁本地短音频
 */
+(void)disposeLocalAudioWithName:(NSString *)name;
@end
