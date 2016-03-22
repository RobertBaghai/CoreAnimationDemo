//
//  ReflectionViewController.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/20/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "ReflectionViewController.h"
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)
#define MIDDLE_VIEW_X CGRectGetMidX(self.view.bounds)
#define MIDDLE_VIEW_Y CGRectGetMidY(self.view.bounds)

@interface ReflectionViewController ()

@end

@implementation ReflectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor   = [UIColor whiteColor];
    
    //TODO: Try CAReplicatorLayer for reflections.. compare result to CALayer
    
    UIImage *eagle         = [UIImage imageNamed:@"eagle"];
    // Image Layer
    CALayer *imageLayer    = [CALayer layer];
    imageLayer.contents    = (id)eagle.CGImage;
    imageLayer.bounds      = CGRectMake(0, 0, eagle.size.width, eagle.size.height);
    imageLayer.position    = CGPointMake(MIDDLE_VIEW_X, 160);
    imageLayer.borderColor = [UIColor darkGrayColor].CGColor;
    imageLayer.borderWidth = 1.0;
    [self.view.layer addSublayer:imageLayer];
    
    // Reflection Layer
    CALayer *reflectionLayer    = [CALayer layer];
    reflectionLayer.contents    = imageLayer.contents;
    reflectionLayer.bounds      = imageLayer.bounds;
    reflectionLayer.position    = CGPointMake(MIDDLE_VIEW_X, 495);
    reflectionLayer.borderColor = imageLayer.borderColor;
    reflectionLayer.borderWidth = imageLayer.borderWidth;
    reflectionLayer.opacity     = 0.5;
    // Transform X by 180 degrees... can also use M_PI for 180 degrees
    [reflectionLayer setValue:@(DEGREES_TO_RADIANS(180)) forKeyPath:@"transform.rotation.x"];

    // Gradient Layer - Use as mask
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds           = reflectionLayer.bounds;
    gradientLayer.position   = CGPointMake(reflectionLayer.bounds.size.width / 2, reflectionLayer.bounds.size.height * 0.65);
    gradientLayer.colors     = @[(id)[UIColor blueColor].CGColor,(id)[UIColor whiteColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 0.5);
    gradientLayer.endPoint   = CGPointMake(0.5, 1.0);
    
    // Add gradient layer as a mask
    reflectionLayer.mask = gradientLayer;
    [self.view.layer addSublayer:reflectionLayer];
}

+ (NSString *)displayName {
    return @"Reflection Layer";
}

@end
