//
//  RadiumImprove.m
//  雷达效果
//
//  Created by skunk  on 15/1/29.
//  Copyright (c) 2015年 skunk . All rights reserved.
//

#import "RadiumImprove.h"
@interface RadiumImprove()
{
    NSInteger _count;
    NSTimer *_timer;
    BOOL _hidden;
    UIButton *_search;
}
@end
@implementation RadiumImprove

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    [self prepare];
    [self createButton];
    for (int i=0; i<4; i++)
    {
        CAShapeLayer *layer=[CAShapeLayer new];
        if (i>0) {
            layer.hidden=YES;
        }
        layer.lineWidth=2;
        UIColor *lineColor=[UIColor blueColor];
        layer.strokeColor=lineColor.CGColor;
        layer.fillColor=nil;
        layer.frame=self.bounds;
        [self.layer addSublayer:layer];
        
        UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:self.center radius:_miniumRadius+_addRadius*i startAngle:0 endAngle:2*M_PI clockwise:YES];
        layer.path=path.CGPath;
    }
    
}
-(void)prepare
{
    _count=1;
    _hidden=NO;
}
-(void)createButton
{
    _search=[UIButton buttonWithType:UIButtonTypeCustom];
    _search.backgroundColor=[UIColor redColor];
    [_search.titleLabel setFont:[UIFont systemFontOfSize:12]];
    _search.frame=CGRectMake(self.center.x-30, self.center.y-20, 60, 40);
    [_search addTarget:self action:@selector(pressSearch) forControlEvents:UIControlEventTouchUpInside];
    [_search setTitle:@"search" forState:UIControlStateNormal];
    [self addSubview:_search];
}
-(void)pressSearch
{
    _search.enabled=NO;
    [self performSelectorInBackground:@selector(startTimerForSearch) withObject:nil];
    
}
- (void)startTimerForSearch
{
    // 第1种方式
    //此种方式创建的timer已经添加至runloop中
    //        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    //保持线程为活动状态，才能保证定时器执行
    //        [[NSRunLoop currentRunLoop] run];//已经将nstimer添加到NSRunloop中了
    
    //第二种方式
    //此种方法创建的timer没有添加至runloop中
    _timer=[NSTimer scheduledTimerWithTimeInterval:0.5f
                                            target:self
                                          selector:@selector(startSearch)
                                          userInfo:nil
                                           repeats:YES];
    //将定时器添加到runloop中
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    //保持线程为活动状态，才能保证定时器执行
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"multiThread is finished");
    
}
- (void)startSearch
{
    [self performSelectorOnMainThread:@selector(updateSearchUI) withObject:nil waitUntilDone:NO];
}
- (void)updateSearchUI
{
    
    if (_hidden==NO) {
        
        _count++;
        
        CAShapeLayer *layer=self.layer.sublayers[_count];
        layer.hidden=NO;
        if (_count==4) {
            _hidden=YES;
        }
    }
    else
    {
        
        NSLog(@"hidden count %ld",_count);
        CAShapeLayer *layer=self.layer.sublayers[_count];
        layer.hidden=YES;
        _count--;
        if (_count==1) {
            _hidden=NO;
            //_count--;
        }
        
    }
    
}
-(void)stopSearch
{
    [_timer invalidate];
}
@end
