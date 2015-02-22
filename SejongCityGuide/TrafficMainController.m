//
//  MainController.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 26..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "TrafficMainController.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "metroViewController.h"
#import "LocaBISBrtViewController.h"


@implementation TrafficMainController

-(void)viewDidLoad
{


    [super viewDidLoad];
    [self setConnectIv];
}

- (IBAction)KTXTab:(id)sender {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    metroViewController *viewController = (metroViewController *)[storyboard instantiateViewControllerWithIdentifier:@"metroViewController"];
    viewController.vehicleType = @"KTX";
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)TrainTap:(id)sender {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    metroViewController *viewController = (metroViewController *)[storyboard instantiateViewControllerWithIdentifier:@"metroViewController"];
        viewController.vehicleType = @"train";
    [self presentViewController:viewController animated:YES completion:nil];

    
}

- (IBAction)ExBusTap:(id)sender {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    metroViewController *viewController = (metroViewController *)[storyboard instantiateViewControllerWithIdentifier:@"metroViewController"];
        viewController.vehicleType = @"bus";
    [self presentViewController:viewController animated:YES completion:nil];

}

-(void)setConnectIv{
    UITapGestureRecognizer *trafficTapMenu01 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionTrafficTaxi:)];
    [self.trafficBtn01 addGestureRecognizer:trafficTapMenu01];
}

- (IBAction)tapActionTrafficTaxi:(id)sender{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    TrafficMainController *viewController = (TrafficMainController *)[storyboard instantiateViewControllerWithIdentifier:@"trafficTaxi"];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self.slidingViewController.underRightViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underRightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuView"];
      }
  //  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (IBAction)btnMenuAction:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECLeft];
}
- (IBAction)brtAction:(id)sender {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    LocaBISBrtViewController* detailView =(LocaBISBrtViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LocaBISBrtViewController"];
    detailView.param = @"293000077";
    detailView.SbusNumber= @"(세종광역) 990";
    detailView.SALLOC_TIME = @"1일 75회 운행";
    detailView.SSTART_TIME = @"(첫 차) 600";
    detailView.SEND_TIME = @"(막 차) 2340";
    
    
    [self presentViewController:detailView animated:YES completion:nil];;
}
@end
