//
//  ImplicitAnimationViewController.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/20/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "ImplicitAnimationViewController.h"
#define MIDDLE_VIEW_X CGRectGetMidX(self.view.bounds)
#define MIDDLE_VIEW_Y CGRectGetMidY(self.view.bounds)
#define LAYER_WIDTH   self.layer.bounds.size.width
#define LAYER_HEIGHT  self.layer.bounds.size.height

@interface ImplicitAnimationViewController ()

@property (nonatomic, strong) CALayer *layer;

@end

@implementation ImplicitAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createExplicitLayer];
    [self createImplicitAnimationButtons];
}

- (void)createExplicitLayer {
    self.layer                 = [CALayer layer]; //explicit layer
    self.layer.position        = CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y + 50);
    self.layer.bounds          = CGRectMake(0.0, 0.0, 200, 200);
    self.layer.backgroundColor = [UIColor greenColor].CGColor;
    self.layer.opacity         = 1.0;
    self.layer.shadowColor     = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity   = 1.0;
    self.layer.shadowOffset    = CGSizeMake(0.0, 5.0);
    self.layer.borderColor     = [UIColor greenColor].CGColor;
    self.layer.borderWidth     = 20.0;
    self.layer.zPosition       = 1.0;//only needed when dealing with overlapping sibling layers
    [self.view.layer addSublayer:self.layer];
}
- (void)createImplicitAnimationButtons {
    UIButton *positionButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 90, 40)];
    positionButton.backgroundColor      = [UIColor blueColor];
    positionButton.titleLabel.textColor = [UIColor whiteColor];
    [positionButton setTitle:@"Position" forState:UIControlStateNormal];
    [positionButton addTarget:self action:@selector(animatePosition:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *boundsButton = [[UIButton alloc] initWithFrame:CGRectMake(115, 100, 70, 40)];
    boundsButton.backgroundColor      = [UIColor blueColor];
    boundsButton.titleLabel.textColor = [UIColor whiteColor];
    [boundsButton setTitle:@"Bounds" forState:UIControlStateNormal];
    [boundsButton addTarget:self action:@selector(animateBounds:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *opacityButton = [[UIButton alloc] initWithFrame:CGRectMake(190, 100, 90, 40)];
    opacityButton.backgroundColor      = [UIColor blueColor];
    opacityButton.titleLabel.textColor = [UIColor whiteColor];
    [opacityButton setTitle:@"Opacity" forState:UIControlStateNormal];
    [opacityButton addTarget:self action:@selector(animateOpacity:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cornerRadiusButton = [[UIButton alloc] initWithFrame:CGRectMake(285, 100, 90, 40)];
    cornerRadiusButton.backgroundColor      = [UIColor blueColor];
    cornerRadiusButton.titleLabel.textColor = [UIColor whiteColor];
    [cornerRadiusButton setTitle:@"Corners" forState:UIControlStateNormal];
    [cornerRadiusButton addTarget:self action:@selector(animateCornerRadius:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *borderColorButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 160, 110, 40)];
    borderColorButton.backgroundColor      = [UIColor blueColor];
    borderColorButton.titleLabel.textColor = [UIColor whiteColor];
    [borderColorButton setTitle:@"Border Color" forState:UIControlStateNormal];
    [borderColorButton addTarget:self action:@selector(animateBorderColor:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *colorButton = [[UIButton alloc] initWithFrame:CGRectMake(190, 160, 90, 40)];
    colorButton.backgroundColor      = [UIColor blueColor];
    colorButton.titleLabel.textColor = [UIColor whiteColor];
    [colorButton setTitle:@"Color" forState:UIControlStateNormal];
    [colorButton addTarget:self action:@selector(animateColor:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:positionButton];
    [self.view addSubview:boundsButton];
    [self.view addSubview:opacityButton];
    [self.view addSubview:cornerRadiusButton];
    [self.view addSubview:borderColorButton];
    [self.view addSubview:colorButton];
}

- (IBAction)animatePosition:(id)sender {
    self.layer.position = (self.layer.position.y == MIDDLE_VIEW_Y + 50 ) ? CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y + 200) : CGPointMake(MIDDLE_VIEW_X, MIDDLE_VIEW_Y + 50);
}

- (IBAction)animateBounds:(id)sender {
    self.layer.bounds = (LAYER_WIDTH == LAYER_HEIGHT) ? CGRectMake(0, 0, LAYER_WIDTH + 80, LAYER_HEIGHT) : CGRectMake(0, 0, LAYER_WIDTH - 80, LAYER_HEIGHT);
}

- (IBAction)animateOpacity:(id)sender {
    self.layer.opacity = (self.layer.opacity == 1.0) ? 0.2 : 1.0;
}

- (IBAction)animateCornerRadius:(id)sender {
    self.layer.cornerRadius = (self.layer.cornerRadius == 0.0) ? 100.0 : 0.0;
}

- (IBAction)animateBorderColor:(id)sender {
    self.layer.borderColor = (self.layer.borderColor == [UIColor greenColor].CGColor) ? [UIColor blueColor].CGColor  : [UIColor greenColor].CGColor;
}

- (IBAction)animateColor:(id)sender {
    self.layer.backgroundColor = (self.layer.backgroundColor == [UIColor greenColor].CGColor) ? [UIColor blueColor].CGColor  : [UIColor greenColor].CGColor;
}


+ (NSString *)displayName {
    return @"Layer Property Changes";
}

@end
