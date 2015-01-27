//
//  MainController.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 26..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "MainController.h"
#import "PDFView.h"

@implementation MainController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self pdfTouch:self.btn];
    

    
}

- (IBAction)pdfTouch:(id)sender {
    NSLog(@"Hello. %@ ",@"1234124");
   [self.btn setHidden:YES];
   // [self.navigationController pushViewController:alarmView animated:YES];

}
@end
