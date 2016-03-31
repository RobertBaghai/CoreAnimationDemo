//
//  SpaceViewController.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/29/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "SpaceViewController.h"
#define MIDDLE_VIEW_X CGRectGetMidX(self.view.bounds)
#define MIDDLE_VIEW_Y CGRectGetMidY(self.view.bounds)

@interface SpaceViewController ()

@property (nonatomic, strong) CAEmitterLayer *emitterLayer;
@property (nonatomic, strong) CALayer        *earthLayer;
@property (nonatomic, strong) CALayer        *moonLayer;

@end

@implementation SpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createEmitterLayer]; //for the background
    [self createEarthLayer];
    [self createMoonLayer];
}

- (void)createEmitterLayer {
    // Create a particle emitter for the "stars"
    self.emitterLayer                 = [CAEmitterLayer layer];
    self.emitterLayer.emitterShape    = kCAEmitterLayerRectangle;
    self.emitterLayer.emitterPosition = self.view.center;
    self.emitterLayer.emitterSize     = self.view.bounds.size;
    self.emitterLayer.emitterMode     = kCAEmitterLayerRectangle;
    self.emitterLayer.renderMode      = kCAEmitterLayerSurface;
    [self.view.layer addSublayer:self.emitterLayer];
    
    CAEmitterCell *starCell = [CAEmitterCell emitterCell];
    starCell.contents       = (id)[[UIImage imageNamed:@"star"] CGImage];
    starCell.birthRate      = 20;
    starCell.lifetime       = 5.0;
    starCell.lifetimeRange  = 3.0;
    starCell.scale          = 0.05;
    starCell.scaleRange     = 0.17;
    [starCell setName:@"star"];
    
    //add the emitterCell(s)to the emitterLayer
    self.emitterLayer.emitterCells = @[starCell];
}

- (void)createEarthLayer {
    self.earthLayer                 = [CALayer layer];
    self.earthLayer.contents        = (id)[UIImage imageNamed:@"earth"].CGImage;
    self.earthLayer.bounds          = CGRectMake(0, 0, 200, 200);
    self.earthLayer.position        = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y);
//    self.earthLayer.contentsGravity = kCAGravityCenter;
    [self.view.layer addSublayer:self.earthLayer];
    [self.earthLayer addAnimation:[self rotateEarthLayer] forKey:@"rotateEarth"];
}

- (void)createMoonLayer {
    self.moonLayer                 = [CALayer layer];
    self.moonLayer.contents        = (id)[UIImage imageNamed:@"moon"].CGImage;
    self.moonLayer.position        = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y);
    self.moonLayer.bounds          = CGRectMake(0, 0, 50, 50);
//    self.moonLayer.contentsGravity = kCAGravityRight; //this works for orbiting the "earth" as well
    [self.view.layer addSublayer:self.moonLayer];
    [self.moonLayer addAnimation:[self orbitAndRotateMoonLayer] forKey:@"orbitEarth"];
}

- (CABasicAnimation *)rotateEarthLayer {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue           = @(M_PI *2);
    rotationAnimation.duration          = 10.0;
    rotationAnimation.repeatCount       = HUGE_VALF;
    rotationAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    return rotationAnimation;
}

-(CAAnimationGroup *)orbitAndRotateMoonLayer {
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue           = @(-M_PI * 2);
    rotationAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CGRect boundingRect        = CGRectMake(-150, -150, 300, 300);
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    orbit.path                 = CGPathCreateWithEllipseInRect(boundingRect, NULL);
    orbit.additive             = YES;
    orbit.calculationMode      = kCAAnimationPaced;
//    orbit.rotationMode         = kCAAnimationRotateAuto; //can be useful for animations like this
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations        = @[rotationAnimation,orbit];
    animationGroup.duration          = 4.0;
    animationGroup.repeatCount       = HUGE_VALF;
    
    return animationGroup;
}

+ (NSString *)displayName {
    return @"Moon Orbit";
}

@end
