//
//  TopBarViewController.m
//  顶部tabbar的封装
//
//  Created by ld on 16/11/7.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRTopBarViewController.h"
#define kHexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kMarginNaviBar 80
@interface HRTopBarViewController ()
//topView
@property (nonatomic,strong) UIScrollView * topBarScrollView;
@property (nonatomic,strong) UIView * topLineView;
@property (assign ,nonatomic) CGFloat  topLineWidth;
@property (nonatomic,strong) UIView * topBar;
//contentView
@property (nonatomic,strong) UIScrollView * contentScrollerView;

@property (assign ,nonatomic) NSInteger preIndex;

@property (assign ,nonatomic) CGFloat preContentScrollerViewOffsetX;
@property (nonatomic,strong) UIButton * selectedBtn;
@property (nonatomic,strong) NSMutableArray * titleBtns;
@property (assign ,nonatomic) CGFloat topBarScrollViewOffsetX;


@end

@implementation HRTopBarViewController

-(instancetype)initWithControllers:(NSArray<UIViewController *> *)viewControllers titles:(NSArray<NSString *> *)titles
{
    NSAssert((viewControllers != nil) && (titles != nil), @"控制器 或 titles 为nil");
    NSAssert(titles.count == viewControllers.count, @"控制器和titles的数量必须一致");
    self = [super init];
    if (self) {
        self.viewControllers = viewControllers;
        self.titles = titles;
    }
    return self;
}

#pragma life cricle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBasePare];
    [self configUI];
}

-(void)updateUIWithControllers:(NSArray<UIViewController *> *)viewControllers titles:(NSArray<NSString *> *)titles
{
    NSAssert((viewControllers != nil) && (titles != nil), @"控制器 或 titles 为nil");
    NSAssert(titles.count == viewControllers.count, @"控制器和titles的数量必须一致");
    self.viewControllers = viewControllers;
    self.titles = titles;
    
    [self.topBar removeFromSuperview];
    self.topBar = nil;
    
    [self.rootScrollView removeFromSuperview];
    self.rootScrollView = nil;
    
    [self.contentScrollerView removeFromSuperview];
    self.contentScrollerView = nil;
    
    [self configUI];
    
}

-(void)configBasePare
{
    self.automaticallyAdjustsScrollViewInsets = false;
    _preIndex = 0;
    _maxCount = 4;
    _canScroll = YES;
    _canBounce = YES;
    _topBarScrollViewHeight = 44;
    _topBarScrollViewColor = [UIColor whiteColor];
    _topLineHeight = 2.5;
    _titleFontSize = 16;
    _topLineColor = kHexColor(0x0085d0);
    _titleSelectedColor = kHexColor(0x0085d0);
    _titleNormalColor = kHexColor(0x333333);
}

-(void)configUI
{
    if (self.viewControllers == nil || self.titles == nil) {
        return;
    }
    
    NSInteger count = self.titles.count;
    if (_titles.count > _maxCount) {
        count = _maxCount;
    }
    if (_isNaviTopBar) {
        NSAssert(self.navigationController != nil, @"导航控制器不存在");
    }
    
    if (self.isNaviTopBar) {
        _topLineWidth = (self.view.bounds.size.width - 2 * kMarginNaviBar)/count;
    }else{
        _topLineWidth = self.view.bounds.size.width/count;
    }
    
    self.rootScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.rootScrollView.delegate = self;
    [self.view addSubview:self.rootScrollView];
    //添加第一个控制器
    for (int i = 0 ; i < _viewControllers.count; i ++) {
        UIViewController * vc = _viewControllers[i];
        [self addChildViewController:vc];
        CGRect frame = self.contentScrollerView.bounds;
        frame.origin.x = i * self.contentScrollerView.bounds.size.width;
        vc.view.frame = frame;
        [self.contentScrollerView addSubview:vc.view];
        self.contentScrollerView.backgroundColor = [UIColor whiteColor];
        self.view.backgroundColor = [UIColor whiteColor];
        if (!_loadAllViews) {
            break;
        }
    }
    
    //添加topbar
    if (self.isNaviTopBar) {
        self.topBar = [[UIView alloc]initWithFrame:CGRectMake(kMarginNaviBar,0, [UIScreen mainScreen].bounds.size.width - 2 * kMarginNaviBar,self.topBarScrollViewHeight + self.topLineHeight)];
        self.navigationItem.titleView = self.topBar;
        
    }else{
        self.topBar = [[UIView alloc]initWithFrame:CGRectMake(0,self.topOffsetY, self.view.bounds.size.width,self.topBarScrollViewHeight + self.topLineHeight)];
        
        [self.rootScrollView addSubview:self.topBar];  
    }
    
    self.topBarScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.topBarScrollViewHeight)];
    self.topBarScrollView.backgroundColor = self.topBarScrollViewColor;
    
    self.topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topBarScrollViewHeight, self.topLineWidth, self.topLineHeight)];
    self.topLineView.backgroundColor = self.topLineColor;
    self.titleBtns = @[].mutableCopy;
    for (int i = 0; i < self.titles.count; i ++) {
        CGFloat x = i * self.topLineWidth;
        UIButton * titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, 0, self.topLineWidth, 42)];
        [titleBtn setTitle:self.titles[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        [titleBtn setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
        titleBtn.tag = i;
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:_titleFontSize];
        [titleBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleBtns addObject:titleBtn];
        [self.topBarScrollView addSubview:titleBtn];
        if (0 == i) {
            self.selectedBtn = titleBtn;
            self.selectedBtn.selected = true;
        }
        
    }
    self.topBarScrollView.contentSize = CGSizeMake(self.titles.count * self.topLineWidth, 0);
    CGFloat px = 1/[UIScreen mainScreen].scale;
    UIView * sepaLineTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.topBar.frame.size.width,px)];
    sepaLineTop.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView * sepaLineBottom = [[UIView alloc]initWithFrame:CGRectMake(0, self.topBar.frame.size.height - px, self.topBar.frame.size.width, px)];
    sepaLineBottom.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.topBar addSubview:_topBarScrollView];
    [self.topBar addSubview:_topLineView];
    [self.topBar addSubview:sepaLineTop];
    [self.topBar addSubview:sepaLineBottom];
    self.topBarScrollView.delegate = self;
    self.topBar.clipsToBounds = true;
}

-(void)scrollToIndex:(NSInteger)index animation:(BOOL)animation
{
    [self.contentScrollerView setContentOffset:CGPointMake(self.contentScrollerView.bounds.size.width * index, 0) animated:animation];
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
        CGFloat contentScrollViewHeight = 0;
        if (self.isNaviTopBar) {
            if (0 == self.contentScrollViewHeight) {
                contentScrollViewHeight = self.view.bounds.size.height - self.topOffsetY;
            }else{
                contentScrollViewHeight = self.contentScrollViewHeight;
            }
            _contentScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,self.topOffsetY, self.view.bounds.size.width, contentScrollViewHeight)];
        }else{
            
            if (0 == self.contentScrollViewHeight) {
                contentScrollViewHeight = self.view.bounds.size.height - self.topBarScrollViewHeight - self.topLineHeight - self.topOffsetY;
            }else{
                contentScrollViewHeight = self.contentScrollViewHeight;
            }
            _contentScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.topBarScrollViewHeight + self.topLineHeight + self.topOffsetY, self.view.bounds.size.width, contentScrollViewHeight)];
        }
        _contentScrollerView.contentSize = CGSizeMake(self.view.bounds.size.width * _titles.count, 0);
        _contentScrollerView.pagingEnabled = true;
        _contentScrollerView.delegate = self;
        _contentScrollerView.showsVerticalScrollIndicator = false;
        _contentScrollerView.showsHorizontalScrollIndicator = false;
        _contentScrollerView.scrollEnabled = _canScroll;
        _contentScrollerView.bounces = _canBounce;
        [self.rootScrollView addSubview:_contentScrollerView];
    }
    return _contentScrollerView;
}
#pragma mark - scrollerViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.rootScrollView) {
        [self rootScrollViewDidScroll:scrollView];
    }else if (scrollView == self.topBarScrollView){
        [self topBarScrollViewDidScroll:scrollView];
    }else if (scrollView == self.contentScrollerView){
        [self contentScrollViewDidScroll:scrollView];
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
                [self didSelectedIndex:index];

            }
            
        }else if (self.preContentScrollerViewOffsetX < offsetX){// 左滑
            if (_preIndex != index && index != self.titles.count) { //代表改变了index
                self.selectedBtn.selected = false;
                self.selectedBtn = self.titleBtns[index];
                self.selectedBtn.selected = true;
                [self didSelectedIndex:index];
                
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

-(void)didSelectedIndex:(NSInteger)index
{
    
}

-(void)contentScrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

-(void)topBarScrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
-(void)rootScrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

@end
