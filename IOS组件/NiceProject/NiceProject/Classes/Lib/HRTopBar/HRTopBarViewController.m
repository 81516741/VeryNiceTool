//
//  HRTopBarViewController.m
//  顶部tabbar的封装
//
//  Created by ld on 16/11/7.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRTopBarViewController.h"

#define kMarginNaviBar 80
@interface HRTopBarViewController ()<UIScrollViewDelegate>
//topView
@property (nonatomic,strong) UIScrollView * topScrollView;
@property (nonatomic,strong) UIView * topLineView;
@property (assign ,nonatomic) CGFloat  topLineWidth;
@property (nonatomic,strong) UIView * topBar;
//contentView
@property (nonatomic,strong) UIScrollView * contentScrollerView;

@property (nonatomic,strong) NSArray * viewControllers;
@property (nonatomic,strong) NSArray * titles;

@property (assign ,nonatomic) NSInteger preIndex;

@property (assign ,nonatomic) CGFloat preContentScrollerViewOffsetX;
@property (nonatomic,strong) UIButton * selectedBtn;
@property (nonatomic,strong) NSMutableArray * titleBtns;
@property (assign ,nonatomic) CGFloat topScrollerViewOffsetX;


@end

@implementation HRTopBarViewController

+(instancetype)instanceWithControllers:(NSArray<UIViewController *> *)viewControllers titles:(NSArray<NSString *> *)titles
{
    HRTopBarViewController * vc = [[HRTopBarViewController alloc]init];
    vc.viewControllers = viewControllers;
    vc.titles = titles;
    NSAssert((viewControllers != nil) && (titles != nil), @"控制器 或 titles 为nil");
    NSAssert(titles.count == viewControllers.count, @"控制器和titles的数量必须一致");
    return vc;
}

#pragma life cricle

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = false;
        _preIndex = 0;
        _maxCount = 4;
        _canScroll = YES;
        _canBounce = YES;
        _topScrollerViewHeight = 42;
        _topScrollerViewColor = [UIColor whiteColor];
        _topLineHeight = 2;
        _topLineColor = [UIColor colorWithRed:4/255. green:182/255. blue:236/255. alpha:1];
        _titleSelectedColor = [UIColor colorWithRed:4/255.0 green:182/255. blue:236/255. alpha:1];
        _titleNormalColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBasePare];
    [self configUI];
}

-(void)configBasePare
{
    NSInteger count = self.titles.count;
    if (_titles.count > _maxCount) {
        count = _maxCount;
    }
    if (self.isNaviTopBar) {
        _topLineWidth = (self.view.bounds.size.width - 2 * kMarginNaviBar)/count;
    }else{
        _topLineWidth = self.view.bounds.size.width/count;
    }
}

-(void)configUI
{
    if (_isNaviTopBar) {
        NSAssert(self.navigationController != nil, @"导航控制器不存在");
    }
    //添加第一个控制器
    UIViewController * vc = _viewControllers[0];
    [self addChildViewController:vc];
    vc.view.frame = self.contentScrollerView.bounds;
    [self.contentScrollerView addSubview:vc.view];
    self.contentScrollerView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加topbar
    if (self.isNaviTopBar) {
        self.topBar = [[UIView alloc]initWithFrame:CGRectMake(kMarginNaviBar,0, [UIScreen mainScreen].bounds.size.width - 2 * kMarginNaviBar,self.topScrollerViewHeight + self.topLineHeight)];
        self.navigationItem.titleView = self.topBar;
        
    }else{
        self.topBar = [[UIView alloc]initWithFrame:CGRectMake(0,self.topOffsetY, self.view.bounds.size.width,self.topScrollerViewHeight + self.topLineHeight)];
        
        [self.view addSubview:self.topBar];  
    }
    
    self.topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.topScrollerViewHeight)];
    self.topScrollView.backgroundColor = self.topScrollerViewColor;
    
    self.topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topScrollerViewHeight, self.topLineWidth, self.topLineHeight)];
    self.topLineView.backgroundColor = self.topLineColor;
    self.titleBtns = @[].mutableCopy;
    for (int i = 0; i < self.titles.count; i ++) {
        CGFloat x = i * self.topLineWidth;
        UIButton * titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, 0, self.topLineWidth, 42)];
        [titleBtn setTitle:self.titles[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        [titleBtn setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
        titleBtn.tag = i;
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [titleBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleBtns addObject:titleBtn];
        [self.topScrollView addSubview:titleBtn];
        if (0 == i) {
            self.selectedBtn = titleBtn;
            self.selectedBtn.selected = true;
        }
        
    }
    self.topScrollView.contentSize = CGSizeMake(self.titles.count * self.topLineWidth, 0);
    [self.topBar addSubview:_topScrollView];
    [self.topBar addSubview:_topLineView];
    self.topScrollView.delegate = self;
    self.topBar.clipsToBounds = true;
}

#pragma mark - click
-(void)topBtnClick:(UIButton *)btn
{
    [self.contentScrollerView setContentOffset:CGPointMake(self.contentScrollerView.bounds.size.width * btn.tag, 0) animated:YES];
    self.selectedBtn.selected = false;
    self.selectedBtn = btn;
    self.selectedBtn.selected = true;
    
}

#pragma  mark - 默认设置
-(UIScrollView *)contentScrollerView
{
    if (_contentScrollerView == nil) {
        if (self.isNaviTopBar) {
            _contentScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,self.topOffsetY, self.view.bounds.size.width, self.view.bounds.size.height - self.topOffsetY)];
        }else{
            _contentScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.topScrollerViewHeight + self.topLineHeight + self.topOffsetY, self.view.bounds.size.width, self.view.bounds.size.height - self.topScrollerViewHeight - self.topLineHeight - self.topOffsetY)];
        }
        _contentScrollerView.contentSize = CGSizeMake(self.view.bounds.size.width * _titles.count, 0);
        _contentScrollerView.pagingEnabled = true;
        _contentScrollerView.delegate = self;
        _contentScrollerView.showsVerticalScrollIndicator = false;
        _contentScrollerView.showsHorizontalScrollIndicator = false;
        _contentScrollerView.scrollEnabled = _canScroll;
        _contentScrollerView.bounces = _canBounce;
        [self.view addSubview:_contentScrollerView];
    }
    return _contentScrollerView;
}
#pragma mark - scrollerViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.topScrollView) {
        
    }else if (scrollView == self.contentScrollerView){
        CGFloat offsetX = scrollView.contentOffset.x;
        CGFloat offsetLineX = (offsetX * self.topLineWidth)/self.view.bounds.size.width;
        CGRect frame = self.topLineView.frame;
        frame.origin.x = offsetLineX;
        self.topLineView.frame = frame;
        CGFloat contentScrollerViewWidth = self.contentScrollerView.bounds.size.width;
        NSInteger index = (NSInteger)((offsetX/ contentScrollerViewWidth) + 0.5);;
        if (self.preContentScrollerViewOffsetX > offsetX) {//右滑
            
            if (_preIndex != index && _preIndex != self.titles.count) { //代表改变了index
                self.selectedBtn.selected = false;
                self.selectedBtn = self.titleBtns[index];
                self.selectedBtn.selected = true;

            }
            
        }else if (self.preContentScrollerViewOffsetX < offsetX){// 左滑
            if (_preIndex != index && index != self.titles.count) { //代表改变了index
                self.selectedBtn.selected = false;
                self.selectedBtn = self.titleBtns[index];
                self.selectedBtn.selected = true;

                
                //添加控制器的view
                UIViewController * vc = self.viewControllers[index];
                if (![self.childViewControllers containsObject:vc]) {
                    [self addChildViewController:vc];
                    CGRect frame = self.contentScrollerView.bounds;
                    frame.origin.x = index * contentScrollerViewWidth;
                    vc.view.frame = frame;
                    [self.contentScrollerView addSubview:vc.view];
                }
            }
        }
        self.preIndex = index;
        self.preContentScrollerViewOffsetX = offsetX;
    }
}

@end
