//
//  StopDetailListCell.h
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 2. 12..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StopDetailListCell  : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *BusNumber;
@property (weak, nonatomic) IBOutlet UILabel *Direction;
@property (weak, nonatomic) IBOutlet UILabel *Time;
@property (weak, nonatomic) IBOutlet UILabel *Location;

@end
