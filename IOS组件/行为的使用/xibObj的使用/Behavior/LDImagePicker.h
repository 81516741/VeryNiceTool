//
//  LDImagePicker.h
//  Behavior的使用
//
//  Created by yh on 16/8/22.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LDBehavior.h"

@protocol LDImagePickerDelegate <NSObject>

- (void)pickeWithImage:(UIImage *)image imagePath:(NSString *)path imageName:(NSString *)name;

@end

@interface LDImagePicker : LDBehavior

@property (nonatomic, weak) IBOutlet UIViewController<LDImagePickerDelegate> *delegate;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, weak) IBOutlet UIView *imageView;

- (IBAction)imagePickerAction:(id)sender;

@end
