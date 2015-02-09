//
//  CommuteMainController.h
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 2. 9..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommuteMainController : UIViewController
- (IBAction)btnMenuAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *ivMainPdf01;
@property (weak, nonatomic) IBOutlet UIImageView *ivMainPdf02;
@property (weak, nonatomic) IBOutlet UIImageView *ivMainPdf03;
@property (weak, nonatomic) IBOutlet UIImageView *ivMainPdf04;
@property (weak, nonatomic) IBOutlet UIImageView *ivMainPdf05;
@property (weak, nonatomic) IBOutlet UIImageView *ivMainSejong;
@end
