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
   // [self pdfTouch:self.btn];

    [self.btn setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    [singleTap setNumberOfTapsRequired:1];
    
    [self.btn addGestureRecognizer:singleTap];

}

- (IBAction)pdfTouch:(id)sender {
    NSLog(@"Hello. %@ ",@"1234124");
   //[self.btn setHidden:YES];
   // [self.navigationController pushViewController:alarmView animated:YES];

}

- (IBAction)tapAction:(id)sender{
       NSLog(@"Hello. %@ ",@"1234124");
    
  //  PDFView *viewController = [[PDFView alloc] init];
 //  [self presentViewController:viewController animated:YES completion:nil];
  
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"PdfView"];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
