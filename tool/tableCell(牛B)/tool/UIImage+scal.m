//
//  UIImage+scal.m
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "UIImage+scal.h"

@implementation UIImage (scal)

+(UIImage *)resizeImage:(NSString *)imageName{
    
    UIImage * image = [UIImage imageNamed:imageName];
    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    
    return image;
}

@end
