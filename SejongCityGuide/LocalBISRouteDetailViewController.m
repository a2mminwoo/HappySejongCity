//
//  APPDetailViewController.m
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "LocalBISRouteDetailViewController.h"
#import "RouteStopListCell.h"

@interface LocalBISRouteDetailViewController () {
    NSXMLParser *parser;
    NSMutableArray *STOP_NAME;
    NSMutableArray *STOP_ID;
    NSMutableArray *STOP_ID_BUS;
    
    NSString *SSTOP_NAME;
    NSString *SSTOP_ID;
    NSString *SSTOP_ID_BUS;
    NSString *element;
}
@end

@implementation LocalBISRouteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
   self.busNumber.text =self.SbusNumber;
   self.ALLOC_TIME.text =  self.SALLOC_TIME;
   self.START_TIME.text =  self.SSTART_TIME;
   self.END_TIME.text = self.SEND_TIME;

    
    STOP_NAME = [[NSMutableArray alloc] init];
    STOP_ID = [[NSMutableArray alloc] init];
    STOP_ID_BUS = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:[@"http://14.50.216.131:8081/bbs/bbsrss.do?searchFlag=STOP_LIST&search="stringByAppendingString:self.param]];
    
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
    return STOP_NAME.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RouteStopListCell *cell = (RouteStopListCell *)[tableView dequeueReusableCellWithIdentifier:@"RouteStopListCell"];
    
    
    
    cell.stopName.text =  [[STOP_NAME objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
     NSString *stopID =[STOP_ID objectAtIndex:indexPath.row];
    cell.stopIMG.image =[UIImage imageNamed:stopID];
  
 //   if([stopID isEqualToString:@"true"]){
   //             cell.stopIMG.image =[UIImage imageNamed:@"ico_bis_bus"];
    //    }
    

        
 //   NSLog(@"index path : %i",indexPath.row);
//    for (NSInteger i = 0; i<STOP_ID_BUS.count; i++) {
//    NSString *stopIDBUS =[[STOP_ID_BUS objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        if([stopID isEqualToString:stopIDBUS]){
//            cell.stopIMG.image =[UIImage imageNamed:@"ico_bis_bus"];
//    }
//    }

    
    
    return cell;
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"STOP_NAME"]) {
        SSTOP_NAME    = [[NSString alloc] init];
    }
    if ([element isEqualToString:@"STOP_ID"]) {
        SSTOP_ID    = [[NSString alloc] init];
    }

    if ([element isEqualToString:@"STOP_ID_BUS"]) {
        SSTOP_ID_BUS    = [[NSString alloc] init];
    }

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"STOP_NAME"]){
        [STOP_NAME addObject:SSTOP_NAME];
    }
    if([elementName isEqualToString:@"STOP_ID"]){
        [STOP_ID addObject:SSTOP_ID];
    }
    if([elementName isEqualToString:@"STOP_ID_BUS"]){
        [STOP_ID_BUS addObject:SSTOP_ID_BUS];
    }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"STOP_NAME"]) {
        SSTOP_NAME = string;
    }
    else if ([element isEqualToString:@"STOP_ID"]) {
        SSTOP_ID = string;
    }
    else if ([element isEqualToString:@"STOP_ID_BUS"]) {
        SSTOP_ID_BUS =string;
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    NSMutableArray *copy = [STOP_ID_BUS copy];
    NSInteger index = [copy count] - 1;
    for (id object in [copy reverseObjectEnumerator]) {
        if ([STOP_ID_BUS indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [STOP_ID_BUS removeObjectAtIndex:index];
        }
        index--;
    }
    
    for (NSInteger k = 0; k<STOP_ID.count; k++){
    for (NSInteger i = 0; i<STOP_ID_BUS.count; i++) {
        NSString *stopIDBUS =[[STOP_ID_BUS objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if([[[STOP_ID objectAtIndex:k] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:stopIDBUS]){
            [STOP_ID replaceObjectAtIndex:k withObject:@"ico_bis_bus"];
        }
    }
    }
    
    for (NSInteger k = 0; k<STOP_ID.count; k++){
        NSString *temp =[[STOP_ID objectAtIndex:k] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (![temp containsString:@"ico"]) {
            [STOP_ID replaceObjectAtIndex:k withObject:@"ico_bis_line"];
        }
    }
    
}


- (IBAction)refleshAction:(id)sender {

    STOP_NAME = [[NSMutableArray alloc] init];
    STOP_ID = [[NSMutableArray alloc] init];
    STOP_ID_BUS = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:[@"http://14.50.216.131:8081/bbs/bbsrss.do?searchFlag=STOP_LIST&search="stringByAppendingString:self.param]];
    
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
