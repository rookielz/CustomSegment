//
//  ViewController.m
//  CustomSegment
//
//  Created by rimi on 2017/1/19.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "ViewController.h"
#import "CustomSegment.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"bg"];
    CustomSegment *segment = [[CustomSegment alloc]initWithItems:@[@"item1",@"item2",@"item3"]];
    segment.center = self.view.center;
    [self.view addSubview:imageView];
    [self.view addSubview:segment];
    CustomSegment *segment2 = [[CustomSegment alloc]initWithItems:@[@"选中1",@"选中2",@"选中3"]];
    segment2.center = CGPointMake(self.view.center.x, 100);
    [self.view addSubview:segment2];
    CustomSegment *segment3 = [[CustomSegment alloc]initWithItems:@[@"item1",@"item2"]];
    segment3.cornerRadius = 5;
    segment2.center = CGPointMake(self.view.center.x, 200);
    [self.view addSubview:segment3];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
