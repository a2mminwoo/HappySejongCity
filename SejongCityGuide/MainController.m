//
//  MainController.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 26..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "MainController.h"
#import "PDFView.h"
#import "CommuteSejong.h"
#import "officeCommuePdf.h"

@implementation MainController



-(void)viewDidLoad
{
    [super viewDidLoad];

    [self setConnectIv];
}

-(void)setConnectIv{

    UITapGestureRecognizer *trafficTapMenu01 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionTrafficTaxi:)];
    [trafficTapMenu01 setNumberOfTapsRequired:1];
    
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
  
    
    UITapGestureRecognizer *OfficeTapMenu02 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionOffice02:)];
    [CommuteTapMenu01 setNumberOfTapsRequired:1];
    UITapGestureRecognizer *OfficeTapMenu04 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionOffice04:)];
    [CommuteTapMenu01 setNumberOfTapsRequired:1];
    UITapGestureRecognizer *OfficeTapMenu05 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionOffice05:)];
    [CommuteTapMenu01 setNumberOfTapsRequired:1];
    UITapGestureRecognizer *OfficeTapMenu06 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionOffice06:)];
    [CommuteTapMenu01 setNumberOfTapsRequired:1];
    
    [self.trafficBtn01 addGestureRecognizer:trafficTapMenu01];


    [self.ivMainSejong addGestureRecognizer:CommuteTapMenu01];
    [self.ivMainPdf01 addGestureRecognizer:CommuteTapMenu02];
    [self.ivMainPdf02 addGestureRecognizer:CommuteTapMenu03];
    [self.ivMainPdf03 addGestureRecognizer:CommuteTapMenu04];
    [self.ivMainPdf04 addGestureRecognizer:CommuteTapMenu05];
    [self.ivMainPdf05 addGestureRecognizer:CommuteTapMenu06];
    
    [self.officeBtn02 addGestureRecognizer:OfficeTapMenu02];
    [self.officeBtn04 addGestureRecognizer:OfficeTapMenu04];
    [self.officeBtn05 addGestureRecognizer:OfficeTapMenu05];
    [self.officeBtn06 addGestureRecognizer:OfficeTapMenu06];

 
}

- (IBAction)tapActionTrafficTaxi:(id)sender{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    CommuteSejong *viewController = (CommuteSejong *)[storyboard instantiateViewControllerWithIdentifier:@"trafficTaxi"];
    
    [self presentViewController:viewController animated:YES completion:nil];
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



-(void)startActionWebViewCommute:(NSString*) input{
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    PDFView *viewController = (PDFView *)[storyboard instantiateViewControllerWithIdentifier:@"PdfView"];
    viewController.pdfName = input;
    viewController.isSejongMenu = NO;
    
    
    [self presentViewController:viewController animated:YES completion:nil];
    
}

-(void)startActionWebViewOffice:(NSString*) url title:(NSString*) title{
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    officeCommuePdf *viewController = (officeCommuePdf *)[storyboard instantiateViewControllerWithIdentifier:@"officeCommute"];
    viewController.title = title;
    viewController.url = url;
    
    
    [self presentViewController:viewController animated:YES completion:nil];
    
}


@end
