//
//  CommuteSejong.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 29..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "CommuteSejong.h"
#import <QuartzCore/QuartzCore.h>
#import "PDFView.h"
@implementation CommuteSejong

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self setBtnLayer:self.btnSejong01];
    [self setBtnLayer:self.btnSejong02];
    [self setBtnLayer:self.btnSejong03];
    [self setBtnLayer:self.btnSejong04];
    [self setBtnLayer:self.btnSejong05];
    [self setBtnLayer:self.btnSejong06];
    [self setBtnLayer:self.btnSejong07];
    [self setBtnLayer:self.btnSejong08];
    [self setBtnLayer:self.btnSejong09];
    [self setBtnLayer:self.btnSejong10];

}

-(void)setBtnLayer:(UIButton*) btn{
    btn.layer.cornerRadius = 10;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
}

- (IBAction)btnAction:(id)sender {
     NSString * input = @"";
    
    switch ([sender tag]) {
        case 0:
           input = @"os_sj_commute.pdf";
        break;
        case 1:
            input = @"jc_sj.pdf";
            break;
        case 2:
            input = @"dg_sj.pdf";
            break;
        case 3:
            input = @"js_sj.pdf";
            break;
        case 4:
            input = @"bs_sj.pdf";
            break;
        case 5:
            input = @"ds_sj.pdf";
            break;
        case 6:
            input = @"os_sj.pdf";
            break;
        case 7:
            input = @"ne_sj.pdf";
            break;
        case 8:
            input = @"cj_sj.pdf";
            break;
        case 9:
            input = @"first_sj.pdf";
            break;
}
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    PDFView *viewController = (PDFView *)[storyboard instantiateViewControllerWithIdentifier:@"PdfView"];
    viewController.pdfName = input;
     viewController.isSejongMenu = YES;
    
    [self presentViewController:viewController animated:YES completion:nil];

}

- (IBAction)BackBtn:(id)sender {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    CommuteSejong *viewController = (CommuteSejong *)[storyboard instantiateViewControllerWithIdentifier:@"mainCommute"];
        [self presentViewController:viewController animated:YES completion:nil];
       
    
}
@end
