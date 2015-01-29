//
//  CommuteSejong.h
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 29..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommuteSejong : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnSejong01;
@property (weak, nonatomic) IBOutlet UIButton *btnSejong02;
@property (weak, nonatomic) IBOutlet UIButton *btnSejong03;
@property (weak, nonatomic) IBOutlet UIButton *btnSejong04;
@property (weak, nonatomic) IBOutlet UIButton *btnSejong05;
@property (weak, nonatomic) IBOutlet UIButton *btnSejong06;
@property (weak, nonatomic) IBOutlet UIButton *btnSejong07;
@property (weak, nonatomic) IBOutlet UIButton *btnSejong08;
@property (weak, nonatomic) IBOutlet UIButton *btnSejong09;
@property (weak, nonatomic) IBOutlet UIButton *btnSejong10;
- (IBAction)btnAction:(id)sender;

- (IBAction)BackBtn:(id)sender;

@end
