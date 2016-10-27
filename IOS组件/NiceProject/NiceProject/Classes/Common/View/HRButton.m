//
//  HRButton.m
//  NiceProject
//
//  Created by ld on 16/10/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRButton.h"

@implementation HRButton

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
   return CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(self.bounds.size.height + 3, contentRect.origin.y, contentRect.size.width, contentRect.size.height);
}

@end
