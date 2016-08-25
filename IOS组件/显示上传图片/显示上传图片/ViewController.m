//
//  ViewController.m
//  显示上传图片
//
//  Created by yh on 16/8/25.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "ImageListView.h"
#import "TZImagePickerController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ImageListView *imageContainer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注意循环引用
    [self.imageContainer setAddImageBtnClick:^{
        [self pickImages];
    }];
    self.imageContainer.maxPicCount = 10;
}

//选取图片的方法
-(void)pickImages
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:10 delegate:nil];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *images, NSArray * assets, BOOL isSelectOriginalPhoto) {
        self.imageContainer.images = images.mutableCopy;
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

@end
