//
//  UIImageView+SDWeb.m
//  NiceProject
//
//  Created by ld on 16/10/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "UIImageView+hr_SDWeb.h"
#import "UIImageView+WebCache.h"
#import <objc/runtime.h>
#import "HRDBTool.h"

@implementation UIImageView (hr_SDWeb)

+(instancetype)hr_imageView:(NSURL *)url placeHolder:(UIImage *)placeHolder modes:(NSArray *)modes
{
    UIImageView * imageView = [[UIImageView alloc]init];
    [imageView hr_setImageView:url placeHolder:placeHolder modes:modes];
    return imageView;
}

-(void)hr_setImageView:(NSURL *)url placeHolder:(UIImage *)placeHolder modes:(NSArray *)modes
{
    self.image = placeHolder;
    [self performSelectorOnMainThread:@selector(hr_setImageView:) withObject:url waitUntilDone:false modes:modes];
}

-(void)hr_setImageView:(NSURL *)url
{
    [self sd_setImageWithURL:url placeholderImage:self.image];
}

@end
