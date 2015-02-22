//
//  conveniDetailViewController.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 6..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "conveniDetailViewController.h"

@interface conveniDetailViewController ()
- (void)configureView;
@end

@implementation conveniDetailViewController

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.navigationItem.title = [self.detailItem objectForKeyedSubscript:@"org_title"];
        NSString *imageStr = [self.detailItem objectForKeyedSubscript:@"org_image"];
        if([imageStr isEqualToString:@""]){
        }else{
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [self.detailItem objectForKeyedSubscript:@"org_image"]]];
            [self.imageItem setImage:image];
        }
        self.locationItem.text = [self.detailItem objectForKeyedSubscript:@"org_addr"];
        self.telItem.text = [self.detailItem objectForKeyedSubscript:@"org_tel"];
        unichar chr[1] = {'\n'};
        NSString *singleCR = [NSString stringWithCharacters:(const unichar *)chr length:1];
        self.timeItem.text = [self.detailItem objectForKeyedSubscript:@"org_time"];
        self.timeItem.text = [self.timeItem.text stringByReplacingOccurrencesOfString:@"\\n" withString:singleCR];
        self.etcItem.text = [self.detailItem objectForKeyedSubscript:@"org_info"];
        self.etcItem.text = [self.etcItem.text stringByReplacingOccurrencesOfString:@"\\n" withString:singleCR];
        
        self.callBtn.layer.cornerRadius = 10;
        self.callBtn.layer.borderWidth = 1;
        self.callBtn.layer.borderColor = [UIColor blackColor].CGColor;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureView];
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

- (IBAction)clickCall:(id)sender {
    NSString *telNum = [self.telItem.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    telNum = [NSString stringWithFormat:@"telprompt://%@", telNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telNum]];
}
@end
