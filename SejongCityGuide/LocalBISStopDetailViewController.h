//
//  APPDetailViewController.h
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalBISStopDetailViewController : UIViewController<NSXMLParserDelegate,UITableViewDelegate, UITableViewDataSource>
- (IBAction)refleshAction:(id)sender;

@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *param;
@property (strong, nonatomic) IBOutlet UILabel *StopName;
@property (strong, nonatomic) NSString *SStopName;

@end
