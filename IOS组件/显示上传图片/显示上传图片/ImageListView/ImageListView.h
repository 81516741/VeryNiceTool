//
//  ImageListView.h
//  DriveCloudPhone
//
//  Created by yh on 16/8/25.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageListView : UIView
/**
 *  图片数组，里面装的是image
 */
@property(nonatomic ,copy) NSMutableArray<UIImage *> * images;
/**
 *  最多显示的图片数量
 */
@property (nonatomic,assign) NSInteger  maxPicCount;
/**
 *  选择图片的回调
 */
@property(nonatomic ,copy) void(^addImageBtnClick)();

@end
