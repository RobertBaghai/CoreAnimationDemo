//
//  ExplicitSpin.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/20/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "ExplicitSpin.h"
#define MIDDLE_VIEW_X CGRectGetMidX(self.view.bounds)
#define MIDDLE_VIEW_Y CGRectGetMidY(self.view.bounds)

@interface ExplicitSpin ()

@property (nonatomic, strong) CALayer *layer;

@end

@implementation ExplicitSpin

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createExplicitLayer];
    [self infiniteSpinAnimation];
}

- (void)createExplicitLayer {
    self.layer                 = [CALayer layer]; 
    self.layer.position        = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y);
    self.layer.bounds          = CGRectMake(0.0, 0.0, 250, 250);
    self.layer.backgroundColor = [UIColor blueColor].CGColor;
//    self.layer.anchorPoint     = CGPointMake(0.0, 1.0); //test
    [self.view.layer addSublayer:self.layer];
}

- (void) infiniteSpinAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // M_PI is equivalent of 180 degrees. Can mulitply PI * 2 or use 6.28319 for 360 degree rotation
    rotationAnimation.toValue           = @(M_PI * 2.0); /* full rotation*/
    rotationAnimation.duration          = 2.0;
    rotationAnimation.cumulative        = YES; //not needed to make this animation work
    rotationAnimation.repeatCount       = HUGE_VALF;
    //linear displays the smoothest spin without any pauses
    rotationAnimation.timingFunction    = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

+ (NSString *)displayName {
    return @"Linear Spin";
}

@end
