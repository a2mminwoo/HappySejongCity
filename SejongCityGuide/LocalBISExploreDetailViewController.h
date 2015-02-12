//
//  LocalBISExploreDetailViewController.h
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 2. 12..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalBISExploreDetailViewController  : UIViewController<NSXMLParserDelegate,UITableViewDelegate, UITableViewDataSource>
@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString *param1;
@property (strong, nonatomic) NSString *param2;

@property (strong, nonatomic) IBOutlet UILabel *startStopName;
@property (strong, nonatomic) IBOutlet UILabel *arriveStopName;


@property (strong, nonatomic) NSString *SstartStopName;
@property (strong, nonatomic) NSString *SarriveStopName;

@end
