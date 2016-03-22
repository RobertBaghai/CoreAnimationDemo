//
//  PulseViewController.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/20/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "PulseViewController.h"
#define MIDDLE_VIEW_X CGRectGetMidX(self.view.bounds)
#define MIDDLE_VIEW_Y CGRectGetMidY(self.view.bounds)

@interface PulseViewController ()

@property (nonatomic, strong) CALayer *layer;

@end

@implementation PulseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createHeartLayerWithContents];
    [self addPulseAnimation];
}

- (void)createHeartLayerWithContents {
    UIImage *heart       = [UIImage imageNamed:@"heart"];
    self.layer           = [CALayer layer];
    self.layer.bounds    = CGRectMake(0, 0, heart.size.width, heart.size.height);
    self.layer.position  = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y);
    self.layer.contents  = (id)heart.CGImage;
    self.layer.transform = CATransform3DMakeScale(0.90, 0.90, 1.00);
    [self.view.layer addSublayer:self.layer];
}

- (void)addPulseAnimation {
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    pulseAnimation.toValue           = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    pulseAnimation.autoreverses      = YES;
    pulseAnimation.duration          = 0.5;
    pulseAnimation.repeatCount       = HUGE_VALF;
    pulseAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:pulseAnimation forKey:@"pulse"];
}

+ (NSString *)displayName {
    return @"Heart Pulse";
}


@end
