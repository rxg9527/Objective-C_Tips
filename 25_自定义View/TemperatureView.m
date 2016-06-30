//
//  TemperatureView.m
//  Objective-C_201605
//
//  Created by Yuen on 16/6/29.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "TemperatureView.h"

/**
 将 File's Owner 指定为 TemperatureView
 */
@interface TemperatureView ()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic, weak) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitSegment;

@end

@implementation TemperatureView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)setup {
    /**
     *  Editor -> Debug Selected Views
     */
#if TARGET_INTERFACE_BUILDER
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    [bundle loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
#else
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
#endif
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.view
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0
                                                             constant:0];

    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.view
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeTrailing
                                                           multiplier:1.0
                                                             constant:0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.view
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:0];

    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.view
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:0];

    [self addSubview:self.view];
    [NSLayoutConstraint activateConstraints:@[left, right, top, bottom]];
}

- (void)setCelsius:(float)celsius {
    _celsius = celsius;
    _fahrenheit = 32 + celsius * 1.8;
    [self updateLabel];
}

- (void)setFahrenheit:(float)fahrenheit {
    _celsius = (fahrenheit - 32) / 1.8;
    _fahrenheit = fahrenheit;
}

- (void)updateLabel {
    if (self.unitSegment.selectedSegmentIndex == 0) {
        NSString *text = [NSString stringWithFormat:@"%.1f℃", self.celsius];
        self.temperatureLabel.text = text;
    } else {
        NSString *text = [NSString stringWithFormat:@"%.1f℉", self.fahrenheit];
        self.temperatureLabel.text = text;
    }
}

- (IBAction)unitChanged:(id)sender {
    [self updateLabel];
}

@end
