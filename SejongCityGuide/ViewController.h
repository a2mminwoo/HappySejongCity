//
//  ViewController.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 1. 15..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;

@property (nonatomic, strong) IBOutlet UILabel *pageNumberLabel;

@property (nonatomic, strong) IBOutlet UILabel *numberTitle;
@property (nonatomic, strong) IBOutlet UIImageView *numberImage;

- (id)initWithPageNumber:(NSUInteger)page;

@end

