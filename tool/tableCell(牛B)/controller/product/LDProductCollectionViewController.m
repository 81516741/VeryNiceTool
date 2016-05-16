//
//  LDProductCollectionViewController.m
//  令达网易
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDProductCollectionViewController.h"
#import "LDProductModel.h"
#import "CZProductCell.h"

@interface LDProductCollectionViewController()

@property(nonatomic, strong) NSArray  * productList;

@end

@implementation LDProductCollectionViewController


-(NSArray *)productList{
    
    if (_productList == nil) {
        _productList = [LDProductModel productList];
    }
    return _productList;
}

-(instancetype)init{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    if (self = [super initWithCollectionViewLayout:layout]) {
        
        layout.itemSize = CGSizeMake(80, 100);
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    }
    
    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    UINib * nib = [UINib nibWithNibName:@"CZProductCell" bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.productList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CZProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.product = self.productList[indexPath.row];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LDProductModel * product = self.productList[indexPath.row];
    
   NSString * openurl = [NSString stringWithFormat:@"%@://%@",product.customUrl,product.ID ];
    NSURL * openUrl = [NSURL URLWithString:openurl];
    
    NSURL * downUrl = [NSURL URLWithString:product.url];
    
   UIApplication * app = [UIApplication sharedApplication];
    
    if ([app canOpenURL:openUrl]) {//有就打开
        [app openURL:openUrl];
    }else{//没有就下载
        [app openURL:downUrl];
    }
    
}
@end
