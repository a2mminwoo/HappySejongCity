//
//  conveniDetailViewController.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 6..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface conveniDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIImageView *imageItem;
@property (weak, nonatomic) IBOutlet UILabel *locationItem;
@property (weak, nonatomic) IBOutlet UILabel *telItem;
@property (weak, nonatomic) IBOutlet UILabel *timeItem;
@property (weak, nonatomic) IBOutlet UILabel *etcItem;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;
- (IBAction)clickCall:(id)sender;

@end
