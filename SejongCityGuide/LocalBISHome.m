//
//  LocalBISHome.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 2. 12..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "LocalBISHome.h"

@interface LocalBISHome ()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@end

@implementation LocalBISHome

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBtnLayer:self.btn1];
    [self setBtnLayer:self.btn2];
    [self setBtnLayer:self.btn3];
}

-(void)setBtnLayer:(UIButton*) btn{
    btn.layer.cornerRadius = 10;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
