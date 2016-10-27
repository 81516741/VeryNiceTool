//
//  YYFPSLabel.h
//  YYKitExample
//
//  Created by ibireme on 15/9/3.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Show Screen FPS...
 
 The maximum fps in OSX/iOS Simulator is 60.00.
 The maximum fps on iPhone is 59.97.
 The maxmium fps on iPad is 60.0.
 */
@interface YYFPSLabel : UILabel

@end

@interface YYWeakProxy : NSProxy

/**
 The proxy target.
 */
@property (nonatomic, weak, readonly) id target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
- (instancetype)initWithTarget:(id)target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
+ (instancetype)proxyWithTarget:(id)target;

@end



@interface NSMutableAttributedString(FPS)
- (void)setAttribute:(NSString *)name value:(id)value range:(NSRange)range;
- (void)setColor:(UIColor *)color range:(NSRange)range;
- (void)setFont:(UIFont *)font ;
- (void)setFont:(UIFont *)font range:(NSRange)range;
@end
