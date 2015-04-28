//
//  ViewController.m
//  雷达效果
//
//  Created by skunk  on 15/1/29.
//  Copyright (c) 2015年 skunk . All rights reserved.
//

#import "ViewController.h"
#import "RadiumImprove.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RadiumImprove *radium=[[RadiumImprove alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    radium.backgroundColor=[UIColor whiteColor];
    radium.miniumRadius=60;
    radium.addRadius=20;
    [self.view addSubview:radium];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
