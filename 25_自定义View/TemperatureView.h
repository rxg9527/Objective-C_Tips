//
//  TemperatureView.h
//  Objective-C_201605
//
//  Created by Yuen on 16/6/29.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface TemperatureView : UIView

@property (nonatomic, assign) IBInspectable float celsius;
@property (nonatomic, assign) IBInspectable float fahrenheit;

@end
