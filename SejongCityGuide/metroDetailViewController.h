//
//  metroDetailViewController.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 3..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface metroDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSString *tmpType;
@property (strong, nonatomic) NSString *tmpStart;
@property (strong, nonatomic) NSString *tmpDest;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *destLabel;
@property (weak, nonatomic) IBOutlet UINavigationItem *naviTitle;
@property (weak, nonatomic) IBOutlet UITableView *oneTableView;
- (IBAction)cancelPress:(id)sender;
- (IBAction)goKorail:(id)sender;
- (IBAction)goBus:(id)sender;
@end
