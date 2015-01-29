//
//  PDFView.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 27..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "PDFView.h"
#import "CommuteSejong.h"
#import "MainController.h"

@implementation PDFView

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self loadRequestFromString:[@"http://sejong.a2m.co.kr/pdf/"stringByAppendingString:self.pdfName]];
      NSLog(@"Hello. %@ ",self.pdfName);
    
    
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
    
     [self.btnBack addGestureRecognizer:singleTap];
}

- (void)loadRequestFromString:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:urlRequest];
    
}
- (IBAction)goBack:(id)sender {

        NSLog(@"back press.");
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    if(self.isSejongMenu == YES){
    CommuteSejong *viewController = (CommuteSejong *)[storyboard instantiateViewControllerWithIdentifier:@"CommuteSejong"];
    [self presentViewController:viewController animated:YES completion:nil];
        self.isSejongMenu =NO;
    }else{
    PDFView *viewController = (PDFView *)[storyboard instantiateViewControllerWithIdentifier:@"mainCommute"];
    [self presentViewController:viewController animated:YES completion:nil];
    }
    
 
  
    
    
  
    
}

@end
