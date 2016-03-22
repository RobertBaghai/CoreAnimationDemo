//
//  SceneViewController.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/22/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "SceneViewController.h"
#define MIDDLE_VIEW_X CGRectGetMidX(self.view.bounds)
#define MIDDLE_VIEW_Y CGRectGetMidY(self.view.bounds)

@interface SceneViewController ()

@property (nonatomic, strong) CALayer *layer;

@end

@implementation SceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createBackgroundSubLayer];
    [self createLightSubLayers];
}

- (void) createBackgroundSubLayer {
    UIImage *background = [UIImage imageNamed:@"treee.jpg"];
    CALayer *treeLayer = [CALayer layer];
    treeLayer.position = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y);
    treeLayer.bounds   = self.view.bounds;
    treeLayer.contents = (id)background.CGImage;
    [treeLayer setMasksToBounds:YES];
    [self.view.layer addSublayer:treeLayer];
}

- (void) createLightSubLayers {
    UIImage *light = [UIImage imageNamed:@"bulb.png"];
    
    for (NSValue *value in [self dropLayerAtPoints]) {
        self.layer           = [CALayer layer];
        self.layer.bounds    = CGRectMake(0, 0, 50, 50);
        self.layer.position  = value.CGPointValue;
        self.layer.contents  = (id)light.CGImage;
        self.layer.zPosition = 10;
        [self.layer setMasksToBounds:YES];
        [self.view.layer addSublayer:self.layer];
        [self animateLightSublayers];
    }
}

- (void) animateLightSublayers {
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.fromValue         = @(M_PI/5);
    rotateAnimation.toValue           = @(-M_PI/4);
    rotateAnimation.duration          = 2.0;
    rotateAnimation.autoreverses      = YES;
    rotateAnimation.repeatCount       = HUGE_VALF;
    rotateAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:rotateAnimation forKey:@"rotateBulb"];
}

- (NSArray*) dropLayerAtPoints {

    NSValue *pointOne   = [NSValue valueWithCGPoint:CGPointMake(310, 100)];
    NSValue *pointTwo   = [NSValue valueWithCGPoint:CGPointMake(200, 231)];
    NSValue *pointThree = [NSValue valueWithCGPoint:CGPointMake(275, 257)];
    NSValue *pointFour  = [NSValue valueWithCGPoint:CGPointMake(208, 308)];
    NSValue *pointFive  = [NSValue valueWithCGPoint:CGPointMake(280, 410)];
    NSValue *pointSix   = [NSValue valueWithCGPoint:CGPointMake(105, 384)];
    NSValue *pointSeven = [NSValue valueWithCGPoint:CGPointMake(100, 120)];
    
    return @[pointOne, pointTwo, pointThree, pointFour, pointFive, pointSix, pointSeven];
}

+ (NSString *) displayName {
    return @"Night Scene";
}

@end
