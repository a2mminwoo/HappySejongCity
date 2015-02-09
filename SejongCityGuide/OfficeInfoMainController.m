//
//  OfficeInfoMainController.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 2. 9..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "OfficeInfoMainController.h"
#import "officeCommuePdf.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
@interface OfficeInfoMainController ()

@end

@implementation OfficeInfoMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setConnectIv];
}
-(void)setConnectIv{
    
    UITapGestureRecognizer *OfficeTapMenu02 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionOffice02:)];
    UITapGestureRecognizer *OfficeTapMenu04 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionOffice04:)];
    UITapGestureRecognizer *OfficeTapMenu05 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionOffice05:)];
    UITapGestureRecognizer *OfficeTapMenu06 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionOffice06:)];
    
    [self.officeBtn02 addGestureRecognizer:OfficeTapMenu02];
    [self.officeBtn04 addGestureRecognizer:OfficeTapMenu04];
    [self.officeBtn05 addGestureRecognizer:OfficeTapMenu05];
    [self.officeBtn06 addGestureRecognizer:OfficeTapMenu06];
    
}



- (IBAction)tapActionOffice02:(id)sender{
    [self startActionWebViewOffice:@"http://sejong.a2m.co.kr/www/info_arrange.html" title:@"입주기관 배치도"];
}
- (IBAction)tapActionOffice04:(id)sender{
    [self startActionWebViewOffice:@"http://sejong.a2m.co.kr/www/info_parking.html" title:@"옥외주차장 안내"];
}
- (IBAction)tapActionOffice05:(id)sender{
    [self startActionWebViewOffice:@"http://sejong.a2m.co.kr/pdf/office_cycle.pdf" title:@"청사순환버스"];
}
- (IBAction)tapActionOffice06:(id)sender{
    [self startActionWebViewOffice:@"http://sejong.a2m.co.kr/pdf/company_call.pdf" title:@"업무연락버스"];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self.slidingViewController.underRightViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underRightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuView"];
    }
    //  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}
-(void)startActionWebViewOffice:(NSString*) url title:(NSString*) title{
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    officeCommuePdf *viewController = (officeCommuePdf *)[storyboard instantiateViewControllerWithIdentifier:@"officeCommute"];
    viewController.title = title;
    viewController.url = url;
    
    
    [self presentViewController:viewController animated:YES completion:nil];
    
}

- (IBAction)btnMenuAction:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECLeft];
}

@end
