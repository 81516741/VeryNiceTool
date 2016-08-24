//
//  LDImagePicker.m
//  Behavior的使用
//
//  Created by yh on 16/8/22.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LDImagePicker.h"

@interface LDImagePicker ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation LDImagePicker

- (IBAction)imagePickerAction:(id)sender
{
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertAction *pickerAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }];
        
        [sheet addAction:pickerAction];
    }
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    UIAlertAction *canleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [sheet addAction:photoAction];
    [sheet addAction:canleAction];
    
    [self.delegate presentViewController:sheet animated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate

- (void)pickerWithSourceType:(UIImagePickerControllerSourceType)type{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = type;
    
    [self.delegate presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = picker.allowsEditing ? info[UIImagePickerControllerEditedImage] : info[UIImagePickerControllerOriginalImage];
    NSURL *imgUrl = info[UIImagePickerControllerReferenceURL];
    if (imgUrl != nil) {
        self.image = image;
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 保存图片至沙盒

/*!
 *
 *  压缩图片至目标尺寸
 *
 *  @param sourceImage 源图片
 *  @param targetWidth 图片最终尺寸的宽
 *
 *  @return 返回按照源图片的宽、高比例压缩至目标宽、高的图片
 */
- (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    UIImage *scaleImg = [self compressImage:currentImage toTargetWidth:100.f];
    NSData *imageData = UIImageJPEGRepresentation(scaleImg, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, nil) lastObject] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
    
    if ([self.delegate respondsToSelector:@selector(pickeWithImage:imagePath:imageName:)]) {
        [self.delegate pickeWithImage:currentImage imagePath:fullPath imageName:imageName];
    }
    
}

#pragma seter & geter

- (void)setImageView:(UIView *)imageView{
    
    _imageView = imageView;
    if ([imageView isKindOfClass:[UIButton class]]) {
        [(UIButton *)imageView addTarget:self action:@selector(imagePickerAction:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePickerAction:)];
        [_imageView addGestureRecognizer:tap];
        
    }
    
}

- (void)setImage:(UIImage *)image{
    
    _image = image;
    if ([self.imageView isKindOfClass:[UIButton class]]) {
        [(UIButton *)self.imageView setImage:image forState:UIControlStateNormal];
    }else{
        ((UIImageView *)self.imageView).image = image;
    }
    
}


@end
