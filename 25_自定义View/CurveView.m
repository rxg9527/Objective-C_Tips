//
//  CurveView.m
//  Objective-C_201605
//
//  Created by Yuen on 16/6/29.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "CurveView.h"



@interface CurveView ()

@property (nonatomic, strong) NSArray *points;

@end

@implementation CurveView

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

- (void)setScaleFactor:(CGFloat)scaleFactor {
    _scaleFactor = scaleFactor;
    [self createCurve];
    [self setNeedsLayout];
}

- (void)setup {
    self.contentMode = UIViewContentModeRedraw;
    self.backgroundColor = nil;
    self.opaque = NO;
    [self createCurve];
}

- (CGFloat)minLengthOfBound {
    return MIN(self.bounds.size.width, self.bounds.size.height);
}

- (void)createCurve {
    NSMutableArray<NSValue *> * a = @[].mutableCopy;
    for (int i = -[self minLengthOfBound] / 2; i <= [self minLengthOfBound] / 2; i++) {
        CGFloat r = i * M_PI / 100;
        CGFloat y = self.scaleFactor * sin(2 * r);
        CGPoint pt = CGPointMake(i, y);
        [a addObject:[NSValue valueWithCGPoint:pt]];
    }
    self.points = a;
}

- (void)drawParameter {
    UIFont *parameterFont = [UIFont systemFontOfSize:[self minLengthOfBound] / 20];
    NSAttributedString *paramterText = [[NSAttributedString alloc] initWithString:@"sinCurve" attributes:@{
                                                                                                           NSFontAttributeName : parameterFont,
                                                                                                           NSForegroundColorAttributeName : [UIColor greenColor]}];
    [paramterText drawAtPoint:CGPointMake([self minLengthOfBound] / 15, [self minLengthOfBound] / 15)];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self minLengthOfBound]/20];
    [roundedRect addClip];
    [[UIColor redColor] setFill];
    UIRectFill(self.bounds);
    
    UIBezierPath *round = [[UIBezierPath alloc] init];
    [round addArcWithCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:[self minLengthOfBound] / 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [round stroke];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = 1.0;
    [path moveToPoint:[self.points[0] CGPointValue]];
    [self.points enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            CGPoint pt = [obj CGPointValue];
            [path addLineToPoint:pt];
        }
    }];
    [[UIColor greenColor] setStroke];
    [path stroke];
    
    CGContextRestoreGState(context);
    
    CGContextSetShadowWithColor(context, CGSizeMake(0, 5), 5.0, [UIColor blackColor].CGColor);
    [self drawParameter];
    
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [self drawParameter];
}

@end
