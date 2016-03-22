//
//  SublayerViewController.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/21/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "SublayerViewController.h"
#define MIDDLE_VIEW_X CGRectGetMidX(self.view.bounds)
#define MIDDLE_VIEW_Y CGRectGetMidY(self.view.bounds)
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

@interface SublayerViewController ()

@property (nonatomic, strong) CALayer *parentLayer;

@end

@implementation SublayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createRootLayer];
    [self createSubLayersFromColorsArray];
    [self performSelector:@selector(rotateRootLayer) withObject:nil afterDelay:1.0];
}

- (void)createRootLayer {
    self.parentLayer                   = [CALayer layer];
    CATransform3D perspective          = CATransform3DIdentity;
    //the smaller the number we divide by.. the closer to the "eye" it will appear
    perspective.m34                    = - 1.0 / 150;
    self.parentLayer.sublayerTransform = perspective;
    self.parentLayer.bounds            = self.view.bounds;
    self.parentLayer.position          = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y);
    [self.view.layer addSublayer:self.parentLayer];
}

- (void)createSubLayersFromColorsArray {
    NSArray *colorsArray = @[[UIColor blueColor], [UIColor redColor], [UIColor yellowColor], [UIColor greenColor], [UIColor orangeColor]];
    for (UIColor *color in colorsArray) {
        CALayer *layer        = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        layer.opacity         = 1.0;
        layer.borderColor     = [UIColor blackColor].CGColor;
        layer.borderWidth     = 1.0;
        layer.position        = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y);
        layer.bounds          = CGRectMake(0, 0, 200, 200);
        [self.parentLayer addSublayer:layer];
    }
}

-(void)rotateRootLayer {
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue         = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue           = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(100), 1, 6, 1)];
    transformAnimation.duration          = 1.5;
    transformAnimation.autoreverses      = YES;
    transformAnimation.repeatCount       = HUGE_VALF;
    transformAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    int transformX = 0;
    // Loop through sublayers-- add animation for each
    for (CALayer *layer in self.parentLayer.sublayers) {
        [layer addAnimation:transformAnimation forKey:nil];
        
        // Create animation to translate along the X axis
        CABasicAnimation *translateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        translateAnimation.fromValue         = [NSValue valueWithCATransform3D:layer.transform];
        translateAnimation.toValue           = [NSNumber numberWithFloat:transformX];
        translateAnimation.duration          = 1.5;
        translateAnimation.autoreverses      = YES;
        translateAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        translateAnimation.repeatCount       = HUGE_VALF;
        [layer addAnimation:translateAnimation forKey:nil];
        transformX += 35;
    }
}

+ (NSString *)displayName {
    return @"Sublayer Transforms";
}

@end
