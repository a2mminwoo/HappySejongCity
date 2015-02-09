//
//  InitialSlidingViewController.m
//  SlideToDo
//
//  Created by Brandon King on 4/18/13.
//  Copyright (c) 2013 King's Cocoa. All rights reserved.
//

#import "InitialTraffic.h"

@interface InitialTraffic ()
@end


@implementation InitialTraffic

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainTraffic"];
}

@end
