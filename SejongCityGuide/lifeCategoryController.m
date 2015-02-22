//
//  lifeCategoryController.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 12..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "lifeCategoryController.h"
#import "lifeInfoTableViewController.h"

@interface lifeCategoryController ()

@end

@implementation lifeCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBtnLayer:self.sejongCate];
    [self setBtnLayer:self.daejeonCate];
    [self setBtnLayer:self.gongjuCate];
    [self setBtnLayer:self.chungjuCate];
    [self setBtnLayer:self.emerCate];
    [self setBtnLayer:self.hospiCate];
    [self setBtnLayer:self.parmCate];
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

-(IBAction)clickCateBtn:(id)sender
{
    NSString * title = @"";
    
    switch ([sender tag]) {
        case 0:
            title = self.sejongCate.titleLabel.text;
            break;
        case 1:
            title = self.daejeonCate.titleLabel.text;
            break;
        case 2:
            title = self.gongjuCate.titleLabel.text;
            break;
        case 3:
            title = self.chungjuCate.titleLabel.text;
            break;
        case 4:
            title = self.emerCate.titleLabel.text;
            break;
        case 5:
            title = self.hospiCate.titleLabel.text;
            break;
        case 6:
            title = self.parmCate.titleLabel.text;
            break;
    }
    UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LifeInfoVC"];
    lifeInfoTableViewController *tableViewController = (lifeInfoTableViewController *)[[navigationController viewControllers] objectAtIndex:0];
    tableViewController.navigationItem.title = [NSString stringWithFormat:@"%@ > 생활정보", title];
    tableViewController.type = title;
    [self presentViewController:navigationController animated:YES completion:nil];
}

-(IBAction)cancelPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
