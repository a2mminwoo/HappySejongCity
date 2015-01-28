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
    [self loadRequestFromString:@"http://sejong.a2m.co.kr/pdf/cj_sj.pdf"];
   self.navigationItem.title = @"A custom title";
}

-(void)startPDF{
    
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    CGFloat screenHeight = screenRect.size.height;
    
    //UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, screenWidth, screenHeight)];
//    
//    NSURL *targetURL = [NSURL URLWithString:@"http://sejong.a2m.co.kr/pdf/cj_sj.pdf"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
//    [self.webView loadRequest:request];
//     NSLog(@"Hello. %@ ",@"ttttt");
//    
    
  //  [self.view addSubview:self.webView];
   // [webView loadRequest:request];
    
   // UIWebView *webView = [[UIWebView alloc] initWithFrame:myframe]
   // [self.view addSubview:ewebView];
}

- (void)loadRequestFromString:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}
@end
