//
//  UITableViewController+Name.m
//  ExplicitImplicit
//
//  Created by Robert Baghai on 3/20/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "UITableViewController+Name.h"

@implementation UITableViewController (Name)

+ (NSString *)displayName {
    return [[self class]displayName];
}

@end
