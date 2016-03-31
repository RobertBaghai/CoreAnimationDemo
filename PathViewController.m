//
//  PathViewController.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/29/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "PathViewController.h"
#define MIDDLE_VIEW_X CGRectGetMidX(self.view.bounds)
#define MIDDLE_VIEW_Y CGRectGetMidY(self.view.bounds)
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

@interface PathViewController ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UIBezierPath *shapeOpenMouthPath;
@property (nonatomic, strong) UIBezierPath *shapeClosedMouthPath;

@end

@implementation PathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat radius    = 30.0;
    CGFloat diameter  = radius * 2;
    CGPoint arcCenter = CGPointMake(radius, radius);
    
    // UIBezierPath for CAShapeLayer's Open Mouth State
    self.shapeOpenMouthPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                         radius:radius
                                                     startAngle:DEGREES_TO_RADIANS(35)
                                                       endAngle:DEGREES_TO_RADIANS(315)
                                                      clockwise:YES];
    [self.shapeOpenMouthPath addLineToPoint:arcCenter];
    [self.shapeOpenMouthPath closePath];
    
    // UIBezierPath for CAShapeLayer's Closed Mouth State
    self.shapeClosedMouthPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                           radius:radius
                                                       startAngle:DEGREES_TO_RADIANS(1)
                                                         endAngle:DEGREES_TO_RADIANS(359)
                                                        clockwise:YES];
    [self.shapeClosedMouthPath addLineToPoint:arcCenter];
    [self.shapeClosedMouthPath closePath];
    
    self.shapeLayer             = [CAShapeLayer layer];
    self.shapeLayer.fillColor   = [UIColor yellowColor].CGColor;
    self.shapeLayer.path        = self.shapeClosedMouthPath.CGPath;
    self.shapeLayer.strokeColor = [UIColor cyanColor].CGColor;       //border color
    self.shapeLayer.lineWidth   = 2.0;                              //border width
    self.shapeLayer.bounds      = CGRectMake(0, 0, diameter, diameter);
    self.shapeLayer.position    = CGPointMake(30, 100);
    [self.view.layer addSublayer:self.shapeLayer];

    
    [self startAnimation];
}

- (void)startAnimation {
    CABasicAnimation *chompAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    chompAnimation.duration          = 0.25;
    chompAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    chompAnimation.repeatCount       = HUGE_VALF;
    chompAnimation.autoreverses      = YES;
    chompAnimation.fromValue         = (id)self.shapeClosedMouthPath.CGPath; //closed  mouth
    chompAnimation.toValue           = (id)self.shapeOpenMouthPath.CGPath;   //open    mouth
    [self.shapeLayer addAnimation:chompAnimation forKey:@"chompAnimation"];
    
    //creating a maze-like path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint   :CGPointMake(30,  100)];//start point
    [path addLineToPoint:CGPointMake(30,  700)];
    [path addLineToPoint:CGPointMake(370, 700)];
    [path addLineToPoint:CGPointMake(370, 100)];
    
    [path addLineToPoint:CGPointMake(90,  100)];
    [path addLineToPoint:CGPointMake(90,  640)];
    [path addLineToPoint:CGPointMake(310, 640)];
    [path addLineToPoint:CGPointMake(310, 160)];
    
    [path addLineToPoint:CGPointMake(150, 160)];
    [path addLineToPoint:CGPointMake(150, 580)];
    [path addLineToPoint:CGPointMake(250, 580)];
    [path addLineToPoint:CGPointMake(250, 220)];
    
    [path addLineToPoint:CGPointMake(210, 220)];
    [path addLineToPoint:CGPointMake(210, 520)];
    [path addLineToPoint:CGPointMake(190, 520)];
    [path addLineToPoint:CGPointMake(190, 280)];
    
    [path addLineToPoint:CGPointMake(190, 100)];
    [path addLineToPoint:CGPointMake(30, 100)];//restart point
    
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.duration             = 25.0f;
    moveAnimation.path                 = path.CGPath;
    moveAnimation.repeatCount          = HUGE_VALF;
    //rotation mode ensures the mouth is always forward. very convenient for this type of animation
    moveAnimation.rotationMode         = kCAAnimationRotateAuto;
    moveAnimation.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.shapeLayer addAnimation:moveAnimation forKey:@"moveAnimation"];
}


+ (NSString *)displayName {
    return @"Follow the Path!";
}

@end
