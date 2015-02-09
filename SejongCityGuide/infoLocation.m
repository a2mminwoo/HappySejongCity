//
//  infoLocation.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 2. 5..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "infoLocation.h"
#import "TmapInfoLocation.h"
@interface infoLocation ()

@end

@implementation infoLocation{
     NSArray *tableData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    tableData = [NSArray arrayWithObjects:@"종합안내실", @"국무총리실·국무총리비서실(1동)", @"공정거래위원회(2동)", @"세종청사관리소(3동)", @"기획재정부(4동)", @"해양수산부(5동)", @"농립축산식품부(5동)", @"국토교통부(6동)", @"환경부(6동)", @"행정중심복합도시건설청(6동)", @"법제처(7-1동)", @"국민권익위원회(7-2동)", @"우정사업본부(8동)", @"국가보훈처(9동)", @"보건복지부(10동)", @"고용노동부(11동)", @"산업통상자원부(12동)", @"산업통상자원부(13동)", @"교육부(14동)", @"문화체육관광부(15동)", @"국세청(정부세종2청사)", @"한국정책방송원(정부세종2청사)", nil];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    if([CLLocationManager locationServicesEnabled]){
        
        NSLog(@"Location Services Enabled");
        
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            UIAlertView*  alert = [[UIAlertView alloc] initWithTitle:@"App Permission Denied"
                                                             message:@"To re-enable, please go to Settings and turn on Location Service for this app."
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
            [alert show];
        }
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
  NSLog(@"@@@@@ click %i",indexPath.row);

    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    TmapInfoLocation *viewController = (TmapInfoLocation *)[storyboard instantiateViewControllerWithIdentifier:@"TmapInfoLocation"];
    viewController.locationFlag = indexPath.row;
    
    [self presentViewController:viewController animated:YES completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
