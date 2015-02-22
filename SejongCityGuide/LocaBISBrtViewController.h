//
//  APPDetailViewController.h
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocaBISBrtViewController : UIViewController<NSXMLParserDelegate,UITableViewDelegate, UITableViewDataSource>
- (IBAction)refleshAction:(id)sender;

@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *param;
@property (strong, nonatomic) IBOutlet UILabel *busNumber;
@property (strong, nonatomic) IBOutlet UILabel *ALLOC_TIME;
@property (strong, nonatomic) IBOutlet UILabel *START_TIME;
@property (strong, nonatomic) IBOutlet UILabel *END_TIME;

@property (strong, nonatomic) NSString *SbusNumber;
@property (strong, nonatomic) NSString *SALLOC_TIME;
@property (strong, nonatomic) NSString *SSTART_TIME;
@property (strong, nonatomic) NSString *SEND_TIME;
@end
