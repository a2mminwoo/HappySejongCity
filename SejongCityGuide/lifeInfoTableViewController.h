//
//  lifeInfoTableViewController.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 12..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lifeInfoTableViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, strong) NSString *type;
@property (strong, nonatomic) IBOutlet UISearchBar *lifeSearch;
- (IBAction)cancelPress:(id)sender;

@end
