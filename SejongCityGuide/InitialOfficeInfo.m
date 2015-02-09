//
//  InitialOfficeInfo.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 2. 9..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "InitialOfficeInfo.h"

@interface InitialOfficeInfo ()

@end

@implementation InitialOfficeInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainOfficeInfo"];

}



@end
