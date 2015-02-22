//
//  conveniController.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 5..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "conveniTableViewController.h"

@interface conveniController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *conveniBtn1;
@property (weak, nonatomic) IBOutlet UIButton *conveniBtn2;
@property (weak, nonatomic) IBOutlet UIButton *conveniBtn3;
@property (weak, nonatomic) IBOutlet UIButton *conveniBtn4;
@property (weak, nonatomic) IBOutlet UIButton *conveniBtn5;
@property (weak, nonatomic) IBOutlet UIButton *conveniBtn6;
@property (weak, nonatomic) IBOutlet UIButton *conveniBtn7;
@property (weak, nonatomic) IBOutlet UIButton *conveniBtn8;
@property (weak, nonatomic) IBOutlet UIButton *conveniBtn9;

- (IBAction)clickConvBtn:(id)sender;

@end
