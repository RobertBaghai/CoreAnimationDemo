//
//  EmitterViewController.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/23/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "EmitterViewController.h"
#define MIDDLE_VIEW_X CGRectGetMidX(self.view.bounds)
#define MIDDLE_VIEW_Y CGRectGetMidY(self.view.bounds)

@interface EmitterViewController ()

@end

@implementation EmitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createEmitterLayer];
    [self createFireLayerBase];
}

- (void)createEmitterLayer {
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.bounds          = self.view.bounds;
    emitterLayer.position        = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y);
    emitterLayer.backgroundColor = [UIColor whiteColor].CGColor;
    emitterLayer.emitterPosition = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y + 200);
    emitterLayer.renderMode      = kCAEmitterLayerSurface;
    emitterLayer.emitterMode     = kCAEmitterLayerSurface;
    [self.view.layer addSublayer:emitterLayer];
    
    
    UIImage *fireImage         = [UIImage imageNamed:@"fire.png"];
    CAEmitterCell *fireCell    = [CAEmitterCell emitterCell];
    fireCell.contents          = (id)fireImage.CGImage;
    fireCell.lifetime          = 0.60;
    fireCell.yAcceleration     = -250;
    fireCell.beginTime         = 0.9;
    fireCell.scale             = 1.0;
    fireCell.birthRate         = 12.0;
    fireCell.emissionRange     = M_PI * 3;
    fireCell.lifetimeRange     = 5.0;
    fireCell.emissionLongitude = M_PI / 2;
    fireCell.emissionLatitude  = 0.0;
    fireCell.alphaSpeed        = -0.5;
    fireCell.scaleSpeed        = -0.1;
    fireCell.scaleRange        =  0.1;
    
    //add emitter cells
    emitterLayer.emitterCells = @[fireCell];
}

- (void)createFireLayerBase {
    CALayer *fireWoodLayer = [CALayer layer];
    fireWoodLayer.contents = (id)[UIImage imageNamed:@"firewood.jpeg"].CGImage;
    fireWoodLayer.bounds   = CGRectMake(0, 0, 80, 80);
    fireWoodLayer.position = CGPointMake(MIDDLE_VIEW_X + 15, MIDDLE_VIEW_Y + 340);
    [fireWoodLayer setMasksToBounds:YES];
    [self.view.layer addSublayer:fireWoodLayer];
}

+ (NSString *)displayName {
    return @"Fire Emitter";
}


@end
