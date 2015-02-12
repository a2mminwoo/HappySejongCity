//
//  LocalBISExploreStartViewController.h
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 2. 12..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalBISExploreStartViewController : UITableViewController <NSXMLParserDelegate,UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end