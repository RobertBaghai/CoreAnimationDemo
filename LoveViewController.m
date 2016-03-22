//
//  LoveViewController.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/20/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "LoveViewController.h"
#define MIDDLE_VIEW_X CGRectGetMidX(self.view.bounds)
#define MIDDLE_VIEW_Y CGRectGetMidY(self.view.bounds)

@interface LoveViewController ()

@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) CALayer *heartLayer;


@end

@implementation LoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createLayerWithContents];
    [self createHeartLayerWithContents];
    [self moveAndFadeAnimation];
}

- (void)createLayerWithContents {
    UIImage *smileyImage = [UIImage imageNamed:@"smiley.jpeg"];
    self.layer           = [CALayer layer];
    self.layer.position  = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y + 80);
    self.layer.bounds    = CGRectMake(0, 0, smileyImage.size.width, smileyImage.size.height);
    self.layer.contents  = (id)smileyImage.CGImage;
    [self.view.layer addSublayer:self.layer];
}

- (void)createHeartLayerWithContents {
    UIImage *heart            = [UIImage imageNamed:@"mini_heart.png"];
    self.heartLayer           = [CALayer layer];
    self.heartLayer.position  = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y - 100);
    self.heartLayer.bounds    = CGRectMake(0, 0, heart.size.width, heart.size.height);
    self.heartLayer.contents  = (id)heart.CGImage;
    self.heartLayer.zPosition = -1;
    [self.view.layer addSublayer:self.heartLayer];
}

- (void)moveAndFadeAnimation {
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.toValue           = [NSValue valueWithCGPoint:CGPointMake(MIDDLE_VIEW_X - 30, MIDDLE_VIEW_Y - 200)];
    
    CABasicAnimation *opacityAnimation  = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.toValue            = @0.0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations        = [NSArray arrayWithObjects:positionAnimation, opacityAnimation, nil];
    animationGroup.repeatCount       = HUGE_VALF;
    animationGroup.duration          = 4.0;
    [self.heartLayer addAnimation:animationGroup forKey:@"dayDream"];
    //no need to update the layer tree values since the animation is repeating
}

+ (NSString *)displayName {
    return @"Love-Dreaming";
}

@end
