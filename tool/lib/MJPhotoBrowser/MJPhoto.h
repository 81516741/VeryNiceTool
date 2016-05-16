//
//  MJPhoto.h
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <Foundation/Foundation.h>

@interface MJPhoto : NSObject
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIImage *image; // 完整的图片

@property (nonatomic, strong) UIImageView *srcImageView; // 来源view
@property (nonatomic, strong, readonly) UIImage *placeholder;
@property (nonatomic, strong, readonly) UIImage *capture;

@property (nonatomic, assign) BOOL firstShow;

// 是否已经保存到相册
@property (nonatomic, assign) BOOL save;
@property (nonatomic, assign) int index; // 索引
@end




///**
// *  监听图片的点击
// */
//- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
//{
//    // 1.创建图片浏览器
//    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//

//    // 2.设置图片浏览器显示的所有图片
//    NSMutableArray *photos = [NSMutableArray array];
//    int count = self.pic_urls.count;
//    for (int i = 0; i<count; i++) {
//        HMPhoto *pic = self.pic_urls[i];
//        
//        MJPhoto *photo = [[MJPhoto alloc] init];
//        // 设置图片的路径
//        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
//        // 设置来源于哪一个UIImageView
//        photo.srcImageView = self.subviews[i];
//        [photos addObject:photo];
//    }
//    browser.photos = photos;
//    
//    // 3.设置默认显示的图片索引
//    browser.currentPhotoIndex = recognizer.view.tag;
//    
//    // 3.显示浏览器
//    [browser show];
//}