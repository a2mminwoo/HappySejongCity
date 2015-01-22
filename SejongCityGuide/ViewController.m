//
//  ViewController.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 1. 15..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (assign) NSInteger pageNumber;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pageNumberLabel.text = [NSString stringWithFormat:@"Page %ld", (long)self.pageNumber + 1];

}

- (id)initWithPageNumber:(NSUInteger)page
{
    if (self = [super initWithNibName:@"MyView" bundle:nil])
    {
        _pageNumber = page;
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
