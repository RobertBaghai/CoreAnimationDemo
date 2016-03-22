//
//  RootViewController.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/20/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "RootViewController.h"
#import "ImplicitAnimationViewController.h"
#import "ExplicitSpin.h"
#import "TrippyBorderViewController.h"
#import "ReflectionViewController.h"
#import "PulseViewController.h"
#import "LoveViewController.h"
#import "SublayerViewController.h"
#import "SceneViewController.h"
#import "BallBounceViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) NSMutableArray *listOfItems;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Core Animation";
    //TODO: Test BezierPath, CAEmitterLayer, CAReplicatorLayer
    
    self.listOfItems = [NSMutableArray array];
    
    NSMutableArray *layerList = [NSMutableArray array];
    [layerList addObject:[ImplicitAnimationViewController class]];
    
    NSDictionary *implicitAnimations = @{@"Implicit Animations" : layerList};
    
    NSMutableArray *layerListTwo = [NSMutableArray array];
    [layerListTwo addObject:[ExplicitSpin class]];
    [layerListTwo addObject:[TrippyBorderViewController class]];
    [layerListTwo addObject:[PulseViewController class]];
    [layerListTwo addObject:[LoveViewController class]];
    [layerListTwo addObject:[ReflectionViewController class]];
    [layerListTwo addObject:[SublayerViewController class]];
    [layerListTwo addObject:[SceneViewController class]];
    [layerListTwo addObject:[BallBounceViewController class]];

    NSDictionary *explicitAnimations = @{@"Explicit Animations" : layerListTwo};
    
    [self.listOfItems addObject:implicitAnimations];
    [self.listOfItems addObject:explicitAnimations];
}
- (NSArray *)valuesForSection:(NSUInteger)section {
    
    NSDictionary *dictionary = self.listOfItems[section];
    NSString     *key        = [dictionary allKeys][0];
    return dictionary[key];
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.listOfItems[section] allKeys][0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listOfItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self valuesForSection:section]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSArray *values     = [self valuesForSection:indexPath.section];
    cell.textLabel.text = [values[indexPath.row] displayName];

    return cell;
}

#pragma mark Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    NSArray *values = [self valuesForSection:indexPath.section];
    Class clazz     = values[indexPath.row];
    id controller   = [[clazz alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}

@end
