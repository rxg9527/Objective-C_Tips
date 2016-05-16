//
//  ViewController.m
//  08_将CGPoint存入数组
//
//  Created by Yuen on 16/5/16.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *  方法1
     */
    CGPoint itemSprite1position = CGPointMake(100, 200);
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:NSStringFromCGPoint(itemSprite1position), nil];
    //    从数组中取值的过程是这样的：
    CGPoint point = CGPointFromString([array objectAtIndex:0]);

    NSLog(@"point is %@.", NSStringFromCGPoint(point));
    
    /**
     *  方法2
     */
    CGPoint itemSprite1position1 = CGPointMake(100, 200);
    NSValue *originValue = [NSValue valueWithCGPoint:itemSprite1position1];
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithObjects:originValue, nil];
    //    从数组中取值的过程是这样的：
    NSValue *currentValue = [array1 objectAtIndex:0];
    CGPoint point1 = [currentValue CGPointValue];

    NSLog(@"point1 is %@.", NSStringFromCGPoint(point1));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
