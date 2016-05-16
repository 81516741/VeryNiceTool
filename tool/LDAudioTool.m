//
//  LDAudioTool.m
//  14.音频的播放
//
//  Created by mac on 15/11/10.
//  Copyright © 2015年 LD. All rights reserved.
//

#import "LDAudioTool.h"

@implementation LDAudioTool

static NSMutableDictionary * _soundIDs;
static NSMutableDictionary * _players;

+ (void)initialize
{
    // 音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 设置会话类型（播放类型、播放模式,会自动停止其他音乐的播放）
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 激活会话
    [session setActive:YES error:nil];
}

+(NSMutableDictionary * )soundIDs{
    
    if (_soundIDs == nil) {
        
        _soundIDs = [NSMutableDictionary dictionary];
        return  _soundIDs;
    }
    
    return _soundIDs;
    
}

+(NSMutableDictionary * )players{
    
    if (_players == nil) {
        
        _players = [NSMutableDictionary dictionary];
        return  _players;
    }
    
    return _players;
    
}



/**
 播放本地音乐
 */
+(BOOL)playLocalMusicWithName:(NSString * )name{
    
    if (!name) return NO;
    
    AVAudioPlayer * player = [self players][name];
    
    if (!player) {
        
        NSURL * url = [[NSBundle mainBundle]URLForResource:name withExtension:nil];
        
        if(!url) return NO;
        
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        
        [[self players] setValue:player forKey:name];

    }
    
    if (![player prepareToPlay]) return NO;
    
    if (player.isPlaying) return YES;
    
    return  [player play];
    


    
}

/**
 停止本地音乐
 */
+(void)stopLocalMusicWithName:(NSString * )name{
    
    if(!name) return;
    
    AVAudioPlayer * player = [self players][name];
    
    [player stop];
    
    [[self players] removeObjectForKey:name];
    
    
}

/**
 暂停本地音乐
 */
+(void)pauseLocalMusicWithName:(NSString * )name{
    
    if(!name) return;
    
    AVAudioPlayer * player = [self players][name];
    
    if (!player.isPlaying) return;
    
    [player pause];
    
}



/**
 播放本地短音频
 */
+(void)playLocalAudioWithName:(NSString *)name{
    
    
    if (!name) return;
    
    SystemSoundID soundID = [[self soundIDs][name] unsignedIntValue];
    
    if (!soundID) {
        
        NSURL * url = [[NSBundle mainBundle]URLForResource:name withExtension:nil];
        if (!url) return;
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
        
        [[self soundIDs]setValue:@(soundID) forKey:name];
        
    }

    AudioServicesPlaySystemSound(soundID);
    

}
/**
 销毁本地短音频
 */
+(void)disposeLocalAudioWithName:(NSString *)name{
    
    if (!name) return;
    
    SystemSoundID soundID = [[self soundIDs][name] unsignedIntValue];
    
    if (!soundID) return;
    
    AudioServicesDisposeSystemSoundID(soundID);
    
    [[self soundIDs] removeObjectForKey:name];
}


@end
