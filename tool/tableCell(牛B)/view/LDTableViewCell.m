//
//  LDTableViewCell.m
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDTableViewCell.h"
#import "LDItemModel.h"
#import "LDItemSwichModel.h"
#import "LDItemArowModel.h"
#import "LDItemLableModel.h"
#import "savePreference.h"


@interface LDTableViewCell()

@property(nonatomic, strong) UIImageView  *  accImageView;
@property(nonatomic, strong) UISwitch  * accSwich;
@property(nonatomic, strong) UILabel  * accLable;

@end


@implementation LDTableViewCell

-(UILabel *)accLable{
    
    if (_accLable == nil) {
        
        _accLable = [[UILabel alloc]init];
        _accLable.frame = CGRectMake(0, 0, 80, self.bounds.size.height);
        _accLable.textAlignment = NSTextAlignmentRight;
        _accLable.font = [UIFont systemFontOfSize:14];
        _accLable.textColor =[UIColor redColor];
        
    }
    return _accLable;
}


-(UIImageView *)accImageView{
    if (_accImageView == nil) {
#warning 奇怪，这种方式设置不了图片，未注释的用法就可以，奇怪
//        _accImageView = [[UIImageView alloc]init];
//        _accImageView.image =[UIImage imageNamed:@"CellArrow"];
        
        _accImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    
    return _accImageView;
    
}

-(UISwitch *)accSwich{
    
    if (_accSwich == nil) {
        _accSwich = [[UISwitch alloc]init];
        [_accSwich addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _accSwich;
}

-(void)valueChange:(UISwitch *) swich{
    
    [savePreference saveBool:swich.on forKey:self.item.title];
    
}
-(void)setItem:(LDItemModel *)item{
    
    _item = item;
    
    [self setDate];
    
    [self setAccView];
    
}

-(void)setDate{
    
    if (self.imageView.image) {
        
         self.imageView.image = [UIImage imageNamed:_item.icon];
        
    }
   
    self.detailTextLabel.text = _item.detailTitle;
    self.textLabel.text = _item.title;
    
    
}

-(void)setAccView{
    
    if ([self.item isKindOfClass:[LDItemArowModel class]]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryView = self.accImageView;
        
        
    }else if ([self.item isKindOfClass:[LDItemSwichModel class] ]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accSwich.on = [savePreference getBoolForKey:self.item.title];
        self.accessoryView = self.accSwich;
        
    }else if([self.item isKindOfClass:[LDItemLableModel class]]){
        
#warning 我开始是这么写的，我天真的一位给item的lableText赋值就可以了，以后注意啦
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        LDItemLableModel * lable = (LDItemLableModel *)_item;
        self.accLable.text = lable.lableText;
        self.accessoryView = self.accLable;
        
    }else{
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryView = nil;
    }
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    LDTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[LDTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    return cell;
}

@end
