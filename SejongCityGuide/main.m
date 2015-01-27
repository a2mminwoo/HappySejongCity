//
//  main.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 1. 15..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        @try
        {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
            
           
        }@catch (NSException *exception)
            {
                // Print exception information
                NSLog( @"NSException caught" );
                NSLog( @"Name: %@", exception.name);
                NSLog( @"Reason: %@", exception.reason );
                return 0;
            }
    }}
