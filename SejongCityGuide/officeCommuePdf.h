//
//  officeCommuePdf.h
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 29..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface officeCommuePdf : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UINavigationItem *menuTitle;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;
@end
