//
//  metroViewController.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 1. 30..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "metroStationTableViewController.h"
#import "metroBusViewController.h"
#import "metroDetailViewController.h"

@interface metroViewController : UIViewController <metroStationTableViewControllerDelegate, metroBusViewControllerDelegate>
- (IBAction)clickDate:(id)sender;
- (IBAction)clickStartTime:(id)sender;
- (IBAction)clickSearch:(id)sender;
- (IBAction)backBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIImageView *searchIco;
@property (weak, nonatomic) IBOutlet UINavigationItem *naviTitle;

@property (strong, nonatomic) NSString *vehicleType;

@end
