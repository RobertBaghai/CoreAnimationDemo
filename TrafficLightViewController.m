//
//  TrafficLightViewController.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/29/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "TrafficLightViewController.h"
#define MIDDLE_VIEW_X CGRectGetMidX(self.view.bounds)
#define MIDDLE_VIEW_Y CGRectGetMidY(self.view.bounds)
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

@interface TrafficLightViewController ()

@property (nonatomic, strong) CAShapeLayer    *containerLayer;
@property (nonatomic, strong) CAShapeLayer    *redLayer;
@property (nonatomic, strong) CAShapeLayer    *yellowLayer;
@property (nonatomic, strong) CAShapeLayer    *greenLayer;
@property (nonatomic, strong) CAGradientLayer *lightLayer;
@property (nonatomic, strong) CAShapeLayer    *light;

@end

@implementation TrafficLightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self createTrafficLight];
    [self addMaskToLightLayer];
    
}


- (void)createTrafficLight {
    self.containerLayer           = [CAShapeLayer layer];
    self.containerLayer.position  = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y);
    self.containerLayer.bounds    = CGRectMake(0, 0, 150, 400);
    self.containerLayer.fillColor = [UIColor colorWithRed:35.0/255.0 green:35.0/255.0 blue:35.0/255.0 alpha:1.0].CGColor;
    self.containerLayer.path      = [UIBezierPath bezierPathWithRoundedRect:self.containerLayer.bounds
                                                          byRoundingCorners:UIRectCornerAllCorners
                                                                cornerRadii:CGSizeMake(20, 20)].CGPath;
    [self.view.layer addSublayer:self.containerLayer];
    
    self.redLayer = [CAShapeLayer layer];
    self.redLayer.position = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y - 120);
    self.redLayer.bounds   = CGRectMake(0, 0, 80, 80);
    self.redLayer.backgroundColor = [UIColor redColor].CGColor;
    self.redLayer.cornerRadius = 40;
    self.redLayer.zPosition = 1;
    self.redLayer.opacity = 0.5;
    [self.view.layer addSublayer:self.redLayer];
    
    self.yellowLayer = [CAShapeLayer layer];
    self.yellowLayer.position = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y);
    self.yellowLayer.bounds   = CGRectMake(0, 0, 80, 80);
    self.yellowLayer.backgroundColor = [UIColor yellowColor].CGColor;
    self.yellowLayer.cornerRadius = 40;
    self.yellowLayer.zPosition = 1;
    [self.view.layer addSublayer:self.yellowLayer];
    
    self.greenLayer = [CAShapeLayer layer];
    self.greenLayer.position = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y + 120);
    self.greenLayer.bounds   = CGRectMake(0, 0, 80, 80);
    self.greenLayer.backgroundColor = [UIColor greenColor].CGColor;
    self.greenLayer.cornerRadius = 40;
    self.greenLayer.zPosition = 1;
    [self.view.layer addSublayer:self.greenLayer];
    
//    self.lightLayer           = [CAGradientLayer layer];
//    self.lightLayer.colors    = @[(id)[UIColor clearColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor clearColor].CGColor];
//    self.lightLayer.locations = @[@(0.6f), @(0.65f), @(0.7f)];
//    self.lightLayer.frame     = self.lightLayer.bounds;
//    self.lightLayer.zPosition = 4;
//    [self.redLayer addSublayer:self.lightLayer];
}

-(void)addMaskToLightLayer {
    
//    self.light = [CAShapeLayer layer];
//    self.light.fillColor = [UIColor blackColor].CGColor;
//    self.light.shadowColor = [UIColor blackColor].CGColor;
//    self.light.shadowRadius = 15.0;
//    self.light.shadowOpacity = 0.5;
//    self.light.zPosition = 100;
//
//    self.light.frame = self.view.bounds;
    
//    CGRect frame =CGRectInset(self.view.bounds, 40, 40);
//    self.light.path = [UIBezierPath bezierPathWithRoundedRect:self.redLayer.bounds cornerRadius:30].CGPath;
//    self.light.shadowPath = self.light.path;
    
    
    CAShapeLayer *ovalLayer = [CAShapeLayer layer];
    ovalLayer.shadowColor = [UIColor purpleColor].CGColor;
    ovalLayer.shadowOpacity = 1.0;
    ovalLayer.shadowRadius = 40.0;
    ovalLayer.position = self.redLayer.position;
    ovalLayer.bounds = CGRectMake(0, 0, 100, 100);
//    ovalLayer.frame = self.view.bounds;
    ovalLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.redLayer.bounds, 60, 60)].CGPath;
    ovalLayer.zPosition = 100;
//    ovalLayer.shadowPath = ovalLayer.path;
//    self.redLayer.mask = ovalLayer;
    [self.redLayer addSublayer:self.light];
    
    
    
    
}

+ (NSString *)displayName {
    return @"Red Light Green Light 123";
}

@end
