//
//  lifeCategoryController.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 12..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lifeCategoryController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *sejongCate;
@property (weak, nonatomic) IBOutlet UIButton *daejeonCate;
@property (weak, nonatomic) IBOutlet UIButton *gongjuCate;
@property (weak, nonatomic) IBOutlet UIButton *chungjuCate;
@property (weak, nonatomic) IBOutlet UIButton *emerCate;
@property (weak, nonatomic) IBOutlet UIButton *hospiCate;
@property (weak, nonatomic) IBOutlet UIButton *parmCate;

-(IBAction)clickCateBtn:(id)sender;
-(IBAction)cancelPress:(id)sender;

@end
