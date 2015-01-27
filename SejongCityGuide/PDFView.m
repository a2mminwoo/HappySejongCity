//
//  PDFView.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 27..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "PDFView.h"

@implementation PDFView

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self startPDF];
   
}

-(void)startPDF{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, screenWidth, screenHeight)];
    
    NSURL *targetURL = [NSURL URLWithString:@"http://sejong.a2m.co.kr/pdf/cj_sj.pdf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    [webView loadRequest:request];
}


@end
