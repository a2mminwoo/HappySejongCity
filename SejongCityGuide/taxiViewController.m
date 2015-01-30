//
//  taxiViewController.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 29..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "taxiViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface taxiViewController ()

@end

@implementation taxiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBtnLayer:self.btnCall01];
    [self setBtnLayer:self.btnCall02];
    [self setBtnLayer:self.btnCall03];
    [self setBtnLayer:self.btnCall04];
    

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)CallAction:(id)sender {
    
    switch ([sender tag]) {
        case 0:
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://15880600"]];
        break;
        case 1:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://0448658282"]];
            break;
        case 2:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://0448688253"]];
        break;
        case 3:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://0448650123"]];
        break;

    }
    
}

- (IBAction)BackBtn:(id)sender {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    taxiViewController *viewController = (taxiViewController *)[storyboard instantiateViewControllerWithIdentifier:@"mainTraffic"];
    [self presentViewController:viewController animated:YES completion:nil];
    

}
@end
