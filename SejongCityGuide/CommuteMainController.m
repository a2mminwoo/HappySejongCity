//
//  CommuteMainController.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 2. 9..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "CommuteMainController.h"
#import "PDFView.h"
#import "CommuteSejong.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface CommuteMainController ()

@end

@implementation CommuteMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setConnectIv];
}

-(void)setConnectIv{
    
    
    UITapGestureRecognizer *CommuteTapMenu01 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionSejong:)];
    [CommuteTapMenu01 setNumberOfTapsRequired:1];
    UITapGestureRecognizer *CommuteTapMenu02 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction01:)];
    [CommuteTapMenu02 setNumberOfTapsRequired:1];
    UITapGestureRecognizer *CommuteTapMenu03 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction02:)];
    [CommuteTapMenu03 setNumberOfTapsRequired:1];
    UITapGestureRecognizer *CommuteTapMenu04 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction03:)];
    [CommuteTapMenu04 setNumberOfTapsRequired:1];
    UITapGestureRecognizer *CommuteTapMenu05 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction04:)];
    [CommuteTapMenu05 setNumberOfTapsRequired:1];
    UITapGestureRecognizer *CommuteTapMenu06 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction05:)];
    [CommuteTapMenu06 setNumberOfTapsRequired:1];
    
    
    
    [self.ivMainSejong addGestureRecognizer:CommuteTapMenu01];
    [self.ivMainPdf01 addGestureRecognizer:CommuteTapMenu02];
    [self.ivMainPdf02 addGestureRecognizer:CommuteTapMenu03];
    [self.ivMainPdf03 addGestureRecognizer:CommuteTapMenu04];
    [self.ivMainPdf04 addGestureRecognizer:CommuteTapMenu05];
    [self.ivMainPdf05 addGestureRecognizer:CommuteTapMenu06];
       
}

- (IBAction)tapActionSejong:(id)sender{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    CommuteSejong *viewController = (CommuteSejong *)[storyboard instantiateViewControllerWithIdentifier:@"CommuteSejong"];
    
    [self presentViewController:viewController animated:YES completion:nil];
}



- (IBAction)tapAction01:(id)sender{
    [self startActionWebViewCommute:@"company_call.pdf"];
}
- (IBAction)tapAction02:(id)sender{
    [self startActionWebViewCommute:@"os_sj_shuttle.pdf"];
}

- (IBAction)tapAction03:(id)sender{
    [self startActionWebViewCommute:@"cap_go.pdf"];
}

- (IBAction)tapAction04:(id)sender{
    [self startActionWebViewCommute:@"cap_leave.pdf"];
}

- (IBAction)tapAction05:(id)sender{
    [self startActionWebViewCommute:@"station_bus.pdf"];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self.slidingViewController.underRightViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underRightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuView"];
    }
    //  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}
-(void)startActionWebViewCommute:(NSString*) input{
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    PDFView *viewController = (PDFView *)[storyboard instantiateViewControllerWithIdentifier:@"PdfView"];
    viewController.pdfName = input;
    viewController.isSejongMenu = NO;
    
    
    [self presentViewController:viewController animated:YES completion:nil];
    
}

- (IBAction)btnMenuAction:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECLeft];
}


@end
