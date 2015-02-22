//
//  metroStationTableViewController.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 2..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "metroStationTableViewController.h"

@implementation metroStationTableViewController

- (NSInteger)tableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [[self.tableData objectAtIndex:indexPath.row] objectForKeyedSubscript:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.startDest;
    if ([self.delegate respondsToSelector:@selector(itemSelectedatRow:position:)]){
        [self.delegate itemSelectedatRow:indexPath.row position:title];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)cancelPressed:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
