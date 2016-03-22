//
//  TrippyBorderViewController.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/20/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "TrippyBorderViewController.h"
#define MIDDLE_VIEW_X CGRectGetMidX(self.view.bounds)
#define MIDDLE_VIEW_Y CGRectGetMidY(self.view.bounds)

@interface TrippyBorderViewController ()

@property (nonatomic, strong) CALayer *layer;

@end

@implementation TrippyBorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self createLayer];
    [self animateLayerBorderWithGroup];
}

- (void)createLayer {
    self.layer                 = [CALayer layer];
    self.layer.backgroundColor = [UIColor blueColor].CGColor;
    self.layer.position        = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y);
    self.layer.bounds          = CGRectMake(0.0, 0.0, 300.0, 300.0);
    self.layer.cornerRadius    = 100.0;
    [self.view.layer addSublayer:self.layer];
}

- (void)animateLayerBorderWithGroup {
    CAKeyframeAnimation *widthAnimation    = [CAKeyframeAnimation animationWithKeyPath:@"borderWidth"];
    NSArray             *borderWidthValues = [NSArray arrayWithObjects:
                                              @1.0,
                                              @10.0,
                                              @5.0,
                                              @30.0,
                                              @0.5,
                                              @45.0,
                                              @20.0,
                                              @60.0,
                                              @30,
                                              @80,
                                              @15,
                                              @85,
                                              @0.0,
                                              nil];
    widthAnimation.values          = borderWidthValues;
    widthAnimation.calculationMode = kCAAnimationPaced;
    
    CAKeyframeAnimation *colorAnimation = [CAKeyframeAnimation animationWithKeyPath:@"borderColor"];
    NSArray *borderColorValues = [NSArray arrayWithObjects:
                                  (id)[UIColor greenColor].CGColor,
                                  (id)[UIColor redColor].CGColor,
                                  (id)[UIColor purpleColor].CGColor,
                                  (id)[UIColor orangeColor].CGColor,
                                  (id)[UIColor yellowColor].CGColor,
                                  (id)[UIColor cyanColor].CGColor,
                                  (id)[UIColor magentaColor].CGColor,
                                  nil];
    colorAnimation.values          = borderColorValues;
    colorAnimation.calculationMode = kCAAnimationPaced;
    
    //Add animations to animation group
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations        = [NSArray arrayWithObjects:colorAnimation, widthAnimation, nil];
    animationGroup.duration          = 3.0;
    animationGroup.repeatCount       = HUGE_VALF;
    
    [self.layer      addAnimation:animationGroup forKey:@"borderChanges"];
    [self.view.layer addAnimation:animationGroup forKey:@"viewBorderChanges"];
}

+ (NSString *)displayName {
    return @"Trippy Layers";
}

@end
