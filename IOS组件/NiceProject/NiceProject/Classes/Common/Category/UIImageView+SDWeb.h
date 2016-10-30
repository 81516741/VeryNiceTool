//
//  UIImageView+SDWeb.h
//  NiceProject
//
//  Created by ld on 16/10/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SDWeb)
/**
 * 返回一个在modes模式下设置图片的imageView
 */
+(instancetype)hr_imageView:(NSURL *)url placeHolder:(UIImage *)placeHolder modes:(NSArray *)modes;
/**
 * 在modes 模式下设置imageView
 */
-(void)hr_setImageView:(NSURL *)url placeHolder:(UIImage *)placeHolder modes:(NSArray *)modes;
@end
