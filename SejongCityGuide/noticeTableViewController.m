//
//  noticeTableViewController.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 12..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "noticeTableViewController.h"
#import "DBHandlerNotice.h"
#import "noticeCell.h"

@interface noticeTableViewController ()

- (IBAction)backAction:(id)sender;
@property (nonatomic, strong) DBHandlerNotice *notice;
@property (nonatomic, strong) NSArray *noticeArray;

@end

@implementation noticeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.notice = [[DBHandlerNotice alloc]init];
    self.noticeArray = [self.notice selectNotice:@"notice"];
    selectedIndex = -1;
    cellTag = -1;    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cellHiddenFlag:(NSInteger *)flagNum{
    cellTag = (int)flagNum;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.noticeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    noticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeCell"];
    
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"noticeCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.titleLabel.text = [[self.noticeArray objectAtIndex:indexPath.row] objectForKeyedSubscript:@"contents"];
    cell.subTitleLabel.text = [[self.noticeArray objectAtIndex:indexPath.row]objectForKeyedSubscript:@"contents"];
    NSString *date = [[[self.noticeArray objectAtIndex:indexPath.row]objectForKeyedSubscript:@"date"] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    date = [date substringWithRange:NSMakeRange(2, 8)];
    cell.reTitleLabel.text = [[self.noticeArray objectAtIndex:indexPath.row]objectForKeyedSubscript:@"contents"];
    cell.dateLabel.text = date;
    cell.reTitleLabel.tag = indexPath.row;
    if(cellTag == indexPath.row){
        [cell.subTitleLabel setHidden:NO];
        [cell.reTitleLabel setHidden:NO];
    }else{
        [cell.subTitleLabel setHidden:YES];
        [cell.reTitleLabel setHidden:YES];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedIndex == indexPath.row){
        return 150;
    }else{
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(selectedIndex == indexPath.row){
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return ;
    }
    
    if(selectedIndex != -1) {
        NSIndexPath *prevPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = (int)indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    selectedIndex = (int)indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self cellHiddenFlag:(NSInteger *)indexPath.row];
    [tableView reloadData];

}


- (IBAction)backAction:(id)sender {
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"initialTraffic"];
    [self presentViewController:viewController animated:YES completion:nil];
    
    
}
@end
