//
//  conveniController.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 5..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "conveniController.h"

@interface conveniController ()
- (IBAction)backAction:(id)sender;

@end

@implementation conveniController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setBtnLayer:self.conveniBtn1];
    [self setBtnLayer:self.conveniBtn2];
    [self setBtnLayer:self.conveniBtn3];
    [self setBtnLayer:self.conveniBtn4];
    [self setBtnLayer:self.conveniBtn5];
    [self setBtnLayer:self.conveniBtn6];
    [self setBtnLayer:self.conveniBtn7];
    [self setBtnLayer:self.conveniBtn8];
    [self setBtnLayer:self.conveniBtn9];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBtnLayer:(UIButton*) btn{
    btn.layer.cornerRadius = 10;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
}
- (IBAction)clickConvBtn:(id)sender {
    NSString * title = @"";
    
    switch ([sender tag]) {
        case 0:
            title = self.conveniBtn1.titleLabel.text;
            break;
        case 1:
            title = self.conveniBtn2.titleLabel.text;
            break;
        case 2:
            title = self.conveniBtn3.titleLabel.text;
            break;
        case 3:
            title = self.conveniBtn4.titleLabel.text;
            break;
        case 4:
            title = self.conveniBtn5.titleLabel.text;
            break;
        case 5:
            title = self.conveniBtn6.titleLabel.text;
            break;
        case 6:
            title = self.conveniBtn7.titleLabel.text;
            break;
        case 7:
            title = self.conveniBtn8.titleLabel.text;
            break;
        case 8:
            title = self.conveniBtn9.titleLabel.text;
            break;
    }
    UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ConveniTableVC"];
    conveniTableViewController *tableViewController = (conveniTableViewController *)[[navigationController viewControllers] objectAtIndex:0];
    tableViewController.navigationItem.title = [NSString stringWithFormat:@"%@ > 편의시설 안내", title];
    tableViewController.category = title;
    [self presentViewController:navigationController animated:YES completion:nil];
}
- (IBAction)backAction:(id)sender {
       [self dismissViewControllerAnimated:YES completion:nil];
}
@end
