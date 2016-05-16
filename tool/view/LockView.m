//
//  LockView.m
//  17.手势解锁
//
//  Created by mac on 15/9/21.
//  Copyright © 2015年 LD. All rights reserved.
//

#import "LockView.h"
#define  ButtonCount 9
#define  Col 3
#define ButtonW 74
#define ButtonH 74
#define ViewW self.bounds.size.width
@interface LockView()

@property (nonatomic, strong) NSMutableArray * buttons;
@property (nonatomic, assign) CGPoint movePoint;


@end


@implementation LockView

-(NSMutableArray *)buttons{
    
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    
    return  _buttons;
}


-(void)layoutSubviews{
   
    [super layoutSubviews];
    //这是在绘制9宫格button
    [self setLockButton];
    
}


#pragma mark - 绘制9宫格button
#warning 第一步。。
-(void)setLockButton{
    
    CGFloat margin = (ViewW - ButtonW * Col)/(Col + 1) ;
    CGFloat col = 0;
    CGFloat row = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i = 0; i < ButtonCount; i ++) {
        
        col = i % Col;
        row = i / Col;
        x = margin + (margin + ButtonW) * col;
        y = margin + (margin + ButtonH) * row;
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = i;
        
        //默认要使所有的button不可以交互，因为我们是判断点在不在button内来控制状态的
        
        button.userInteractionEnabled = NO;
        [button setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        
        button.frame = CGRectMake(x, y , ButtonW, ButtonH);
        
        [self addSubview:button];
        
    }
    
}



#pragma mark -  移动到button上面就将这个button点亮，并存储

#warning 第二步
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self saveButtonByTouches:touches];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self saveButtonByTouches:touches];
    
    [self setNeedsDisplay];
}

#pragma mark - 取出手指所在点的button，并使之变成选中状态，并存在数组里
-(void)saveButtonByTouches:(NSSet *)touches{
    
    UITouch * touch = [touches anyObject];
    
    _movePoint =  [touch locationInView:self];
    
    for (UIButton * btn in self.subviews) {
        
        if (CGRectContainsPoint(btn.frame, _movePoint) && btn.selected == NO) {
            
            btn.selected = YES;
            [self.buttons addObject:btn];
            
        }
    }
}




#pragma  mark - 画线
#warning 第三步
-(void)drawRect:(CGRect)rect{
    
    //为什么要加这一句呢，因为没有起始点就不画，没起始点怎么画，系统同会报错
    if (!self.buttons.count) return;
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    
    for (int i = 0;  i < self.buttons.count; i ++) {
        
        if (!i) [path moveToPoint:[self.buttons[i] center]];
        [path addLineToPoint:[self.buttons[i] center]];
    }
    
    [path addLineToPoint:_movePoint];
    [[UIColor greenColor]set];
    path.lineWidth = 8;
    [path stroke];
    
    
}

#pragma mark 结束touch后清空所有线条，并传递数据
#warning 第四步

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取密码
    NSMutableString * code = [NSMutableString string];
    for (UIButton * btn  in self.buttons) {
        
        [code appendFormat:@"%d",btn.tag];
        
    }
    
    //密码传给需要的人哈哈哈，这里传给控制器把
    self.block(code);
    
    //将所有button的状态设置未选中
    [self.buttons makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    
    [self.buttons removeAllObjects];
    [self setNeedsDisplay];
    
    
}

@end
