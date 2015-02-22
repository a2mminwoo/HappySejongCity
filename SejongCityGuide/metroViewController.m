//
//  metroViewController.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 1. 30..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "metroViewController.h"
#import "DBHandlerMetroTrain.h"
#import "DBHandlerMetroBus.h"

@interface metroViewController() 

@property (nonatomic, strong) DBHandlerMetroTrain *metroTrain;
@property (nonatomic, strong) DBHandlerMetroBus *metroBus;
@property (nonatomic, strong) NSArray *stationArray;
@property (weak, nonatomic) IBOutlet UIButton *startStation;
@property (weak, nonatomic) IBOutlet UIButton *destStation;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *dateSelect;
@property (strong, nonatomic) NSArray *timeArray;

@end

@implementation metroViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([self.vehicleType isEqualToString:@"KTX"]){
        self.metroTrain = [[DBHandlerMetroTrain alloc]init];
        self.stationArray = [self.metroTrain getStation:@"ktx"];
        self.naviTitle.title = @"KTX > 교통편";
    } else if([self.vehicleType isEqualToString:@"train"]){
        self.metroTrain = [[DBHandlerMetroTrain alloc]init];
        self.stationArray = [self.metroTrain getStation:@"train"];
        self.naviTitle.title = @"기차 > 교통편";
    } else if([self.vehicleType isEqualToString:@"bus"]){
        self.metroBus = [[DBHandlerMetroBus alloc]init];
        self.naviTitle.title = @"고속시외버스 > 교통편";
    }
   
    self.datePicker.hidden = YES;
    self.dateSelect.hidden = YES;
    self.searchBtn.layer.cornerRadius = 10;
    self.searchBtn.layer.borderWidth = 1;
    self.searchBtn.layer.borderColor = [UIColor blackColor].CGColor;

}

- (IBAction)selectStatePressed:(id)sender
{
    if([self.vehicleType isEqualToString:@"bus"]){
        UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"StationBusVC"];
        metroBusViewController *busViewController = (metroBusViewController *)[[navigationController viewControllers]objectAtIndex:0];
        NSString *typeFlag = self.destStation.titleLabel.text;
        if([typeFlag isEqualToString:@"도착지를 선택해주세요"]){
            typeFlag = @"";
        }else if([typeFlag isEqualToString:@"세종남측환승터미널"]){
            typeFlag = @"seoul";
        }else {
            typeFlag = @"";
        }
        self.stationArray = [self.metroBus getStation:typeFlag];
        busViewController.tableData = self.stationArray;
        busViewController.navigationItem.title = @"항목을 선택하세요";
        busViewController.startDest = @"start";
        busViewController.delegate = self;
        [self presentViewController:navigationController animated:YES completion:nil];
    }else{
        UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"StationTableVC"];
        metroStationTableViewController *tableViewController = (metroStationTableViewController *)[[navigationController viewControllers] objectAtIndex:0];
        tableViewController.tableData = self.stationArray;
        tableViewController.navigationItem.title = @"항목을 선택하세요";
        tableViewController.startDest = @"start";
        tableViewController.delegate = self;
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}

- (void)itemSelectedatRow:(NSInteger)row position:(NSString *)pos
{
    if([pos isEqualToString:@"start"]){
        [self.startStation setTitle:[[self.stationArray objectAtIndex:row] objectForKey:@"name"] forState:UIControlStateNormal];
        
    }else{
        [self.destStation setTitle:[[self.stationArray objectAtIndex:row] objectForKey:@"name"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)selectStatePressed2:(id)sender
{
    if([self.vehicleType isEqualToString:@"bus"]){
        UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"StationBusVC"];
        metroBusViewController *busViewController = (metroBusViewController *)[[navigationController viewControllers]objectAtIndex:0];
        NSString *typeFlag = self.startStation.titleLabel.text;
        if([typeFlag isEqualToString:@"출발지를 선택해주세요"]){
            typeFlag = @"";
        }else if([typeFlag isEqualToString:@"세종남측환승터미널"]){
            typeFlag = @"seoul";
        }else {
            typeFlag = @"sejong";
        }
        self.stationArray = [self.metroBus getStation:typeFlag];
        busViewController.tableData = self.stationArray;
        busViewController.navigationItem.title = @"항목을 선택하세요";
        busViewController.startDest = @"dest";
        busViewController.delegate = self;
        [self presentViewController:navigationController animated:YES completion:nil];
    }else{
        UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"StationTableVC"];
        metroStationTableViewController *tableViewController = (metroStationTableViewController *)[[navigationController viewControllers] objectAtIndex:0];
        tableViewController.tableData = self.stationArray;
        tableViewController.navigationItem.title = @"항목을 선택하세요";
        tableViewController.startDest = @"dest";
        tableViewController.delegate = self;
    [self presentViewController:navigationController animated:YES completion:nil];
    }
}

- (IBAction)clickDate:(id)sender {
    
    self.datePicker.hidden = NO;
    self.dateSelect.hidden = NO;
    self.searchBtn.hidden = YES;
    self.searchIco.hidden = YES;
    self.datePicker.datePickerMode = UIDatePickerModeTime;
    [self.datePicker addTarget:self action:@selector(pickerChanged:)               forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.datePicker];

}

- (IBAction)clickStartTime:(id)sender {
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"HH:mm"];
     NSLog(@"value: %@",self.datePicker.date);
    self.datePicker.hidden = YES;
    self.dateSelect.hidden = YES;
    self.searchBtn.hidden = NO;
    self.searchIco.hidden = NO;
    [self.dateBtn setTitle:[NSString stringWithFormat:@"%@", [format stringFromDate:self.datePicker.date]] forState:UIControlStateNormal];
}

- (IBAction)clickSearch:(id)sender {
    NSString *start = [NSString stringWithFormat:@"%@",self.startStation.titleLabel.text];
    NSString *dest = [NSString stringWithFormat:@"%@",self.destStation.titleLabel.text];
    NSString *time = [NSString stringWithFormat:@"%@",self.dateBtn.titleLabel.text];
    if([start isEqualToString:@"출발지를 선택하세요"]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"주의" message:@"출발지를 선택해주세요" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return ;
    }
    if([dest isEqualToString:@"도착지를 선택하세요"]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"주의" message:@"도착지를 선택해주세요" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return ;
    }
    if([dest isEqualToString:start]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"주의" message:@"출발지와 도착지가 같습니다" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return ;
    }
    if([time isEqualToString:@"시간을 선택하세요"]){
        time = @"00:00";
    }
    
    if([self.vehicleType isEqualToString:@"KTX"]){
        self.timeArray = [self.metroTrain selectTimeTable:@"KTX" startStation:[NSString stringWithFormat:@"%@", start] destStation:[NSString stringWithFormat:@"%@", dest] time:[NSString stringWithFormat:@"%@", time]];
        [self performSegueWithIdentifier:@"showMetro" sender:self];
    } else if([self.vehicleType isEqualToString:@"train"]){
        self.timeArray = [self.metroTrain selectTimeTable:@"train" startStation:[NSString stringWithFormat:@"%@", start] destStation:[NSString stringWithFormat:@"%@", dest] time:[NSString stringWithFormat:@"%@", time]];
        [self performSegueWithIdentifier:@"showMetro" sender:self];
    } else if([self.vehicleType isEqualToString:@"bus"]){
        // bus 관련 코드
        self.timeArray = [self.metroBus selectTimeTable:[NSString stringWithFormat:@"%@", start] destStation:[NSString stringWithFormat:@"%@", dest] time:[NSString stringWithFormat:@"%@", time]];
        [self performSegueWithIdentifier:@"showMetroBus" sender:self];
        //NSLog(@"%@",self.timeArray);
    }
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pickerChanged:(id)sender
{
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"showMetro"]){
        [[segue destinationViewController] setDetailItem:self.timeArray];
        metroDetailViewController *metroDetail = (metroDetailViewController *)[segue destinationViewController];
        metroDetail.tmpStart = self.startStation.titleLabel.text;
        metroDetail.tmpDest = self.destStation.titleLabel.text;
        if([self.vehicleType isEqualToString:@"train"]){
            metroDetail.tmpType = @"기차";
        } else {
            metroDetail.tmpType = self.vehicleType;
        }
    } else if([[segue identifier] isEqualToString:@"showMetroBus"]){
        [[segue destinationViewController] setDetailItem:self.timeArray];
        metroDetailViewController *metroDetail = (metroDetailViewController *)[segue destinationViewController];
        metroDetail.tmpStart = self.startStation.titleLabel.text;
        metroDetail.tmpDest = self.destStation.titleLabel.text;
        metroDetail.tmpType = @"고속시외버스";
    }
}
@end
