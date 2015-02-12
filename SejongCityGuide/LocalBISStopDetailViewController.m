//
//  APPDetailViewController.m
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "LocalBISStopDetailViewController.h"
#import "StopDetailListCell.h"

@interface LocalBISStopDetailViewController () {
    NSXMLParser *parser;
    NSMutableArray *ROUTE_NAME;
    NSMutableArray *PROVIDE_TYPE;
    NSMutableArray *RSTOP;
    NSMutableArray *ED_STOP_NAME;
    
    NSString *SROUTE_NAME;
    NSString *SPROVIDE_TYPE;
    NSString *SRSTOP;
    NSString *SED_STOP_NAME;
    NSString *element;
}
@end

@implementation LocalBISStopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.StopName.text =self.SStopName;

    
    
    ROUTE_NAME = [[NSMutableArray alloc] init];
    PROVIDE_TYPE = [[NSMutableArray alloc] init];
    RSTOP = [[NSMutableArray alloc] init];
    ED_STOP_NAME = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:[@"http://14.50.216.131:8081/bbs/bbsrss.do?searchFlag=STOP_TIME&search="stringByAppendingString:self.param]];
    
    NSLog(@"tqwerqwer %@",url);
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ROUTE_NAME.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StopDetailListCell *cell = (StopDetailListCell *)[tableView dequeueReusableCellWithIdentifier:@"StopDetailListCell"];
    
    
    
    cell.BusNumber.text =  [[ROUTE_NAME objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cell.Direction.text =  [[[ED_STOP_NAME objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]stringByAppendingString:@" 방향"];
    cell.Time.text =  [@"도착예정: "stringByAppendingString:[[PROVIDE_TYPE objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    cell.BusNumber.text =  [@"현재위치: "stringByAppendingString:[[ROUTE_NAME objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    

    
    
    
    
    return cell;
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    
    if ([element isEqualToString:@"ROUTE_NAME"]) {
        SROUTE_NAME    = [[NSString alloc] init];
    }
    if ([element isEqualToString:@"PROVIDE_TYPE"]) {
        SPROVIDE_TYPE    = [[NSString alloc] init];
    }
    
    if ([element isEqualToString:@"RSTOP"]) {
        SRSTOP    = [[NSString alloc] init];
    }
    
    if ([element isEqualToString:@"ED_STOP_NAME"]) {
        SED_STOP_NAME   = [[NSString alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"ROUTE_NAME"]){
        [ROUTE_NAME addObject:SROUTE_NAME];
    }
    if([elementName isEqualToString:@"PROVIDE_TYPE"]){
        [PROVIDE_TYPE addObject:SPROVIDE_TYPE];
    }
    if([elementName isEqualToString:@"RSTOP"]){
        [RSTOP addObject:SRSTOP];
    }
    if([elementName isEqualToString:@"ED_STOP_NAME"]){
        [ED_STOP_NAME addObject:SED_STOP_NAME];
    }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"ROUTE_NAME"]) {
        SROUTE_NAME = string;
    }
    else if ([element isEqualToString:@"PROVIDE_TYPE"]) {
        SPROVIDE_TYPE = string;
    }
    else if ([element isEqualToString:@"RSTOP"]) {
        SRSTOP =string;
    }
    else if ([element isEqualToString:@"ED_STOP_NAME"]) {
        SED_STOP_NAME =string;
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
}


- (IBAction)refleshAction:(id)sender {
    
    ROUTE_NAME = [[NSMutableArray alloc] init];
    PROVIDE_TYPE = [[NSMutableArray alloc] init];
    RSTOP = [[NSMutableArray alloc] init];
    ED_STOP_NAME = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:[@"http://14.50.216.131:8081/bbs/bbsrss.do?searchFlag=STOP_TIME&search="stringByAppendingString:self.param]];
    
    NSLog(@"tqwerqwer %@",url);
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"업데이트 되었습니다."
                                                     message:nil
                                                    delegate:self
                                           cancelButtonTitle:@"확인"
                                           otherButtonTitles: nil];
    
    [alert show];
    
}
@end
