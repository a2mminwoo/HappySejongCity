//
//  lifeInfoTableViewController.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 12..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "lifeInfoTableViewController.h"
#import "DBHandlerLifeInfo.h"
#import "lifeInfoCell.h"
#import "TMapGpsManager.h"


@interface lifeInfoTableViewController ()

@property (nonatomic, strong) DBHandlerLifeInfo *lifeInfo;
@property (nonatomic, strong) NSArray *lifeInfoArray;
@property (nonatomic, strong) NSArray *lifeInfoResult;

@end

@implementation lifeInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.type = @"쇼핑·마트";
    self.lifeInfo = [[DBHandlerLifeInfo alloc]init];
    self.lifeInfoArray = [self.lifeInfo selectLifeInfo:[NSString stringWithFormat:@"%@",self.type]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchThroughData
{
    self.lifeInfoResult = nil;
    NSString *key = @"org_title";
    NSPredicate *resultsPredicate = [NSPredicate predicateWithFormat:@"%K CONTAINS %@", key, self.lifeSearch.text];
    self.lifeInfoResult = [[self.lifeInfoArray filteredArrayUsingPredicate:resultsPredicate] mutableCopy];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchThroughData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(tableView == self.tableView){
        return self.lifeInfoArray.count;
    } else {
        [self searchThroughData];
        return self.lifeInfoResult.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    lifeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lifeCell"];
    
    if(!cell){
        //cell = [[lifeInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"lifeCell"];
        tableView.rowHeight = 60.0f;
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"lifeCell"];
    }
    if(tableView == self.tableView){
        cell.lifeTitle.text = [[self.lifeInfoArray objectAtIndex:indexPath.row] objectForKeyedSubscript:@"org_title"];
        cell.lifeAddr.text = [[self.lifeInfoArray objectAtIndex:indexPath.row]objectForKeyedSubscript:@"org_addr"];
        cell.lifeTel.titleLabel.text = [[self.lifeInfoArray objectAtIndex:indexPath.row]objectForKeyedSubscript:@"org_tel"];
        
        cell.lati =[[self.lifeInfoArray objectAtIndex:indexPath.row] objectForKeyedSubscript:@"org_lati"];
        cell.longi =[[self.lifeInfoArray objectAtIndex:indexPath.row] objectForKeyedSubscript:@"org_longi"];
     
        cell.lifeDist.text = [self getDistace:[[self.lifeInfoArray objectAtIndex:indexPath.row] objectForKeyedSubscript:@"org_lati"] Longi:[[self.lifeInfoArray objectAtIndex:indexPath.row] objectForKeyedSubscript:@"org_longi"]];
     //   [cell.lifeLocation setValue:[[self.lifeInfoArray objectAtIndex:indexPath.row] objectForKeyedSubscript:@"org_longi"]  forKey:@"longi"];
        
        
    }else {
        cell.lifeTitle.text = [[self.lifeInfoResult objectAtIndex:indexPath.row] objectForKeyedSubscript:@"org_title"];
        cell.lifeAddr.text = [[self.lifeInfoResult objectAtIndex:indexPath.row]objectForKeyedSubscript:@"org_addr"];
        cell.lifeTel.titleLabel.text = [[self.lifeInfoResult objectAtIndex:indexPath.row]objectForKeyedSubscript:@"org_tel"];

        cell.lati =[[self.lifeInfoArray objectAtIndex:indexPath.row] objectForKeyedSubscript:@"org_lati"];
        cell.longi =[[self.lifeInfoArray objectAtIndex:indexPath.row] objectForKeyedSubscript:@"org_longi"];
        
        
    }
    
    return cell;
}


- (IBAction)cancelPress:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(NSString* )getDistace:(NSString*)lati Longi:(NSString*) longi{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    //iOS8 대응
    if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        //   [locationManager requestWhenInUseAuthorization];   //앱을 사용하는 동안
        [locationManager requestAlwaysAuthorization];      //항상
    }
    NSLog(@"1111  %f",locationManager.location.coordinate.latitude);      // latitude
    NSLog(@"2222  %f",fabs(locationManager.location.coordinate.longitude) );    // longitude
    
     CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:fabs(locationManager.location.coordinate.latitude) longitude:fabs(locationManager.location.coordinate.longitude)];
    //CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:37.381 longitude:127.134];
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:[lati doubleValue] longitude:[longi doubleValue]];
    CLLocationDistance distance = [startLocation distanceFromLocation:endLocation];
    CLLocationDistance kilometers = distance / 1000.0;
    NSString *distanceString = [NSString stringWithFormat: @"%.02f Km", kilometers];

    
    return distanceString;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
