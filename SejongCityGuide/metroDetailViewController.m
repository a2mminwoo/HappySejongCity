//
//  metroDetailViewController.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 3..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "metroDetailViewController.h"
#import "metroTimeCell.h"

@interface metroDetailViewController()
- (void)configureView;
@property (nonatomic, strong) NSArray *timeArray;
@end

@implementation metroDetailViewController

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

-(void)configureView
{
    self.timeArray = self.detailItem;
    self.oneTableView.dataSource = self;
    self.oneTableView.delegate = self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.timeArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    metroTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"metroTimeCell" forIndexPath:indexPath];
    if([self.tmpType isEqualToString:@"고속시외버스"]){
        cell.typeData.text = [[self.timeArray objectAtIndex:indexPath.row]objectForKeyedSubscript:@"bus_type"];
        cell.timeData.text = [NSString stringWithFormat:@"%@\t\t\t%@", [[self.timeArray objectAtIndex:indexPath.row]objectForKeyedSubscript:@"start_time"], [[self.timeArray objectAtIndex:indexPath.row]objectForKeyedSubscript:@"TIME"]];
        cell.feeData.text = [[self.timeArray objectAtIndex:indexPath.row]objectForKeyedSubscript:@"FEE"];
    }else{
        cell.typeData.text = [[self.timeArray objectAtIndex:indexPath.row] objectForKeyedSubscript:@"train_name"];
        cell.startData.text = [[self.timeArray objectAtIndex:indexPath.row] objectForKeyedSubscript:@"start"];
        cell.destData.text = [[self.timeArray objectAtIndex:indexPath.row] objectForKeyedSubscript:@"dest"];
    }
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.typeLabel.text = self.tmpType;
    self.startLabel.text = self.tmpStart;
    self.destLabel.text = self.tmpDest;
    self.naviTitle.title = [NSString stringWithFormat:@"검색결과 > %@", self.tmpType];
    [self configureView];
}

- (IBAction)cancelPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goKorail:(id)sender
{
    NSString *appUrl = @"itms-apps://itunes.apple.com/kr/app/koleiltog/id405461321";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
}

- (IBAction)goBus:(id)sender {
    NSString *appUrl = @"http://m.kobus.co.kr/web/m/main_index/index.jsp";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
}
@end
