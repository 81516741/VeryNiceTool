//
//  TextView.m
//  宫格布局
//
//  Created by ld on 16/9/8.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "TextView.h"
#import "LDGridView.h"

@interface TextView()

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic,copy)  void(^itemClick)(NSInteger index);

@end

@implementation TextView

+(void)showIn:(UIView *)desView models:(NSArray *)models itemH:(CGFloat)itemH col:(NSInteger)col startY:(CGFloat)startY itemClick:(void(^)(NSInteger index))itemClick
{
    [LDGridView configSubItemsIn:desView count:models.count col:col itemH:itemH startY:startY fetchItemAtIndex:^UIView *(NSInteger index) {
        TextView * textView = [[[NSBundle mainBundle]loadNibNamed:@"TextView" owner:nil options:nil]lastObject];
        textView.button.tag = index;
        textView.model = models[index];
        textView.itemClick = itemClick;
        return textView;
    }];
}
- (IBAction)itemClick:(UIButton *)sender
{
    if (self.itemClick) {
        self.itemClick(sender.tag);
    }
}


@end
