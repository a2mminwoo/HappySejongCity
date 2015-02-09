//
//  InitialLifeInfo.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 2. 9..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "InitialLifeInfo.h"

@interface InitialLifeInfo ()

@end

@implementation InitialLifeInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainLifeInfo"];

}

@end
