//
//  officeCommuePdf.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 29..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "officeCommuePdf.h"

@interface officeCommuePdf ()

@end

@implementation officeCommuePdf

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRequestFromString:self.url];

    self.menuTitle.title = self.title;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadRequestFromString:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:urlRequest];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
