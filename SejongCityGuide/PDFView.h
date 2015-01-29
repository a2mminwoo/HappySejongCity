//
//  PDFView.h
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 27..
//  Copyright (c) 2015년 A2M. All rights reserved.
//
#import <UIKit/UIKit.h>


#import <Foundation/Foundation.h>

@interface PDFView : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;

@property (strong, nonatomic) NSString *pdfName;
@property (nonatomic) Boolean *isSejongMenu;

- (IBAction)goBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@end
