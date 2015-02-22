//
//  conveniTableViewController.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 5..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "conveniTableViewController.h"
#import "conveniTableViewCell.h"
#import "DBHandlerConvenience.h"
#import "conveniDetailViewController.h"

@interface conveniTableViewController ()

@property (nonatomic, strong) DBHandlerConvenience *convenience;
@property (nonatomic, strong) NSArray *conveniArray;

@end

@implementation conveniTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.convenience = [[DBHandlerConvenience alloc]init];
    self.conveniArray = [self.convenience selectConvenience:[NSString stringWithFormat:@"%@",self.category]];
    //NSLog(@"%@", self.conveniArray);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.conveniArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    conveniTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"conveniCell" forIndexPath:indexPath];
    cell.Rounding.layer.cornerRadius = 10;
    cell.Rounding.layer.borderWidth = 1;
    cell.Rounding.layer.borderColor = [UIColor blackColor].CGColor;
    cell.conveniTitle.text = [[self.conveniArray objectAtIndex:indexPath.row] objectForKeyedSubscript:@"org_title"];
    
    return cell;
}

- (IBAction)cancelPressed:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *flag = [[self.conveniArray objectAtIndex:indexPath.row] objectForKeyedSubscript:@"org_image"];
    if([flag isEqualToString:@""]){
        [self performSegueWithIdentifier:@"showDetail2" sender:self];
    }else{
        [self performSegueWithIdentifier:@"showDetail" sender:self];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"showDetail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] setDetailItem:[self.conveniArray objectAtIndex:indexPath.row]];
    }else if([[segue identifier] isEqualToString:@"showDetail2"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] setDetailItem:[self.conveniArray objectAtIndex:indexPath.row]];
    }
}
@end
