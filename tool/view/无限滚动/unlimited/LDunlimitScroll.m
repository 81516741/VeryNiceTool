//
//  LDunlimitScroll.m
//  无限滚动封装
//
//  Created by mac on 15/11/23.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDunlimitScroll.h"
#import "LDCollectionViewCell.h"
#import "LDMidTopScrollModel.h"

#define sectionCount 100


@interface LDunlimitScroll()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageController;

@property(nonatomic, strong) NSTimer  * time;

@end

@implementation LDunlimitScroll

+(instancetype)unlimitScroll{
    
  return  [[[NSBundle mainBundle]loadNibNamed:@"LDunlimitScroll" owner:nil options:nil]lastObject];
}

static NSString * ID = @"item";


-(void)setItemsList:(NSArray *)itemsList{
    
    _itemsList = itemsList;
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"LDCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:ID];
    
    //定时器
    [self startCount];
    
    //基本设置
    [self setBase];
    
    
    
}


/**
 *  基本设置
 */
-(void)setBase{
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
 
    
    //设置pageController
    self.pageController.numberOfPages = _itemsList.count;
    
}

-(void)setFrame:(CGRect)frame{
    
    [super setFrame:frame];
    
    //设置cell的尺寸,和布局,这里拿的比较准
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.itemSize = CGSizeMake(frame.size.width, frame.size.height);
    self.collectionView.collectionViewLayout = flow;
    
}
/**
 *  开始定时器
 */
-(void)startCount{
    
    //定时器
    self.time = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(updata) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.time forMode:NSRunLoopCommonModes];
    
}

/**
 *重置位置，使位置保持在section = sectionCount/2;这个区域内，免得计时器把图片翻完了
 *
 */
-(NSIndexPath * )resetPostion{
    
    NSIndexPath * currentPath = [self.collectionView.indexPathsForVisibleItems lastObject];
    
    NSInteger  item = currentPath.item;
    NSInteger  section = sectionCount/2;
    
    NSIndexPath * newPath = [NSIndexPath indexPathForItem:item inSection:section];
    
    [self.collectionView scrollToItemAtIndexPath:newPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    return newPath;
}

/**
 *  切换画面，当cell到了每组最后一个，就切换至下一组第一个cell
 *
 */
-(void)updata{
    
    NSIndexPath * currentPath = [self resetPostion];
    
    NSInteger  item = currentPath.item + 1;
    NSInteger  section = currentPath.section;
    
    if (item == self.itemsList.count) {
        
        item =0;
        section ++;
    }
    
    NSIndexPath * newPath = [NSIndexPath indexPathForItem:item inSection:section];
    
    
    [self.collectionView scrollToItemAtIndexPath:newPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}
/**
 *  cell有几组
 *
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return sectionCount;
    
}
/**
 *  cell每组几个
 *
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return   self.itemsList.count;
    
    
}

/**
 *  返回cell，并设置内容
 *
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LDCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    LDMidTopScrollModel * item = self.itemsList[indexPath.item];
    
    
    cell.Block = ^(UILabel * lable,UIImageView *imageView){
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:item.LogoUrl]];
        
    };
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
 
        //定位cell
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:sectionCount/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    });
    
    return cell;
}

/**
 *  滚动切换pageController小点
 *
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger  pageNum = (NSInteger)(scrollView.contentOffset.x/scrollView.bounds.size.width + 0.5) % self.itemsList.count;
    
    self.pageController.currentPage = pageNum;
    
    
}

/**
 *  拖拽停止计时器
 *
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.time invalidate];
}

/**
 *  停止拖拽开始计时器
 
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self startCount];
}


@end
