//
//  lifeInfoCell.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 12..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lifeInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lifeTitle;
@property (weak, nonatomic) IBOutlet UILabel *lifeAddr;
@property (weak, nonatomic) IBOutlet UILabel *lifeDist;
- (IBAction)phoneCall:(id)sender;
- (IBAction)locationFind:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *lifeTel;
@property (weak, nonatomic) IBOutlet UIButton *lifeLocation;
@property (weak) NSString *lati;
@property (weak) NSString *longi;

@end
