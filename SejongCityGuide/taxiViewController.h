//
//  taxiViewController.h
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 29..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface taxiViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnCall01;
@property (weak, nonatomic) IBOutlet UIButton *btnCall02;
@property (weak, nonatomic) IBOutlet UIButton *btnCall03;
@property (weak, nonatomic) IBOutlet UIButton *btnCall04;

- (IBAction)CallAction:(id)sender;

- (IBAction)BackBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *textBoxView;

@end
