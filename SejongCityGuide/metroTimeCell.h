//
//  metroTimeCell.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 10..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface metroTimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeData;
@property (weak, nonatomic) IBOutlet UILabel *startData;
@property (weak, nonatomic) IBOutlet UILabel *destData;
@property (weak, nonatomic) IBOutlet UILabel *timeData;
@property (weak, nonatomic) IBOutlet UILabel *feeData;

@end
