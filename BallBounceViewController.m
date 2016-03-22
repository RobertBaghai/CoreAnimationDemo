//
//  BallBounceViewController.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/22/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "BallBounceViewController.h"
#define MIDDLE_VIEW_X CGRectGetMidX(self.view.bounds)
#define MIDDLE_VIEW_Y CGRectGetMidY(self.view.bounds)

@interface BallBounceViewController ()

@property (nonatomic, strong) CALayer *layer;

@end

@implementation BallBounceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createBallLayer];
    [self addAnimationGroupToBallLayer];
}

- (void) createBallLayer {
    self.layer          = [CALayer layer];
    self.layer.bounds   = CGRectMake(0, 0, 150, 150);
    self.layer.position = CGPointMake(0, 0);
    self.layer.contents = (id)[UIImage imageNamed:@"basketball"].CGImage;
    [self.layer setMasksToBounds:YES];
    [self.view.layer addSublayer:self.layer];
}

- (void) addAnimationGroupToBallLayer {
    //creates a path that implements two arcs and a few "bounces"
    //simulates reverse gravity
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL,74.0,74.0);
    
    CGPathAddCurveToPoint(path,NULL,74.0,800.0,
                                    160.0,800.0,
                                    160.0,74.0);
    
    CGPathAddCurveToPoint(path,NULL,160.0,800.0,
                                    366.0,800.0,
                                    366.0,74.0);
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path                 = path;
    positionAnimation.duration             = 5.0;
    
    CABasicAnimation *rotateAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.toValue            = @(M_PI * 2);
    rotateAnimation.duration           = 5.0;
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations        = @[positionAnimation, rotateAnimation];
    animationgroup.repeatCount       = HUGE_VALF;
    animationgroup.duration          = 5;
    animationgroup.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animationgroup.autoreverses      = YES;
    
    [self.layer addAnimation:animationgroup forKey:@"rotateAndMove"];
}

+ (NSString *) displayName {
    return @"Reverse Ball Bounce";
}

@end
