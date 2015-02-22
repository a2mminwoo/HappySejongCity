//
//  metroStationTableViewController.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 2..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol metroStationTableViewControllerDelegate <NSObject>

@required
- (void)itemSelectedatRow:(NSInteger)row position:(NSString *)pos;

@end

@interface metroStationTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) NSString *startDest;
@property (nonatomic, assign) id<metroStationTableViewControllerDelegate> delegate;

@end
