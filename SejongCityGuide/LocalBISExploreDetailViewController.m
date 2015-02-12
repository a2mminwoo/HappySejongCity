//
//  LocalBISExploreDetailViewController.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 2. 12..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "LocalBISExploreDetailViewController.h"
#import "ExploreDetailListCell.h"

@interface LocalBISExploreDetailViewController (){
    NSXMLParser *parser;
    NSMutableArray *SROUTENO;
    NSMutableArray *SSTATIONNAME;
    NSMutableArray *ROUTESEQ_A;
    NSMutableArray *TSTATIONNAME;
    NSMutableArray *ROUTESEQ_B;
    NSMutableArray *EROUTENO;
    NSMutableArray *ESTATIONNAME;
    NSMutableArray *DISTANCE;
    NSMutableArray *SEQ;
    
    NSString *SSROUTENO;
    NSString *SSSTATIONNAME;
    NSString *SROUTESEQ_A;
    NSString *STSTATIONNAME;
    NSString *SROUTESEQ_B;
    NSString *SEROUTENO;
    NSString *SESTATIONNAME;
    NSString *SDISTANCE;
    NSString *SSEQ;

    NSString *element;
}
@end

@implementation LocalBISExploreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.startStopName.text =self.SstartStopName;
    self.arriveStopName.text =self.SarriveStopName;
    
    
    
    SROUTENO = [[NSMutableArray alloc] init];
    SSTATIONNAME = [[NSMutableArray alloc] init];
    ROUTESEQ_A = [[NSMutableArray alloc] init];
    TSTATIONNAME = [[NSMutableArray alloc] init];
    ROUTESEQ_B = [[NSMutableArray alloc] init];
    EROUTENO = [[NSMutableArray alloc] init];
    ESTATIONNAME = [[NSMutableArray alloc] init];
    DISTANCE = [[NSMutableArray alloc] init];
    SEQ = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:[[[@"http://14.50.216.131:8081/bbs/bbsrss.do?searchFlag=EXPLORE_LIST&search="stringByAppendingString:self.param1]stringByAppendingString:@"&search2="]stringByAppendingString:self.param2]];

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
    return SROUTENO.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExploreDetailListCell *cell = (ExploreDetailListCell *)[tableView dequeueReusableCellWithIdentifier:@"ExploreDetailListCell"];
    
    NSString* temp1= [@"승차 : " stringByAppendingString:[[SROUTENO objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
                        
    NSString* temp2 =[[temp1 stringByAppendingString:@"("] stringByAppendingString:[[SSTATIONNAME objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    cell.path.text =[NSString stringWithFormat:@"%ld. 경로" ,indexPath.row +1];
    cell.line1.text =  [temp2 stringByAppendingString:@")"];
    cell.line2.text = [[@"하차 : " stringByAppendingString:[[TSTATIONNAME objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] stringByAppendingString:@" 정류장"];

    NSString* temp3 = [@"환승 : " stringByAppendingString:[[EROUTENO objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    NSString* temp4 =[[temp3 stringByAppendingString:@"("] stringByAppendingString:[[TSTATIONNAME objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    if([@"NULL" isEqualToString:[[EROUTENO objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] ){
        [cell.line3 setHidden:YES];
    }else{
    cell.line3.text =  [temp4 stringByAppendingString:@")"];
    }
    cell.line4.text = [[@"도착 : " stringByAppendingString:[[ESTATIONNAME objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] stringByAppendingString:@" 정류장"];
    
    
    NSString* temp5 = [[[SEQ objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]stringByAppendingString:@"개 정류소, "];
    
    int distance = [[[DISTANCE objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] intValue];
 
    NSString* distance_10 = [NSString stringWithFormat:@" %d." ,distance/1000];
    NSString* distace_1 = [NSString stringWithFormat:@"%d(km)" ,distance % 1000];
 
    
    
    NSString* temp6 =[[temp5 stringByAppendingString:[[TSTATIONNAME objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]stringByAppendingString:distance_10];

    
    

    cell.line5.text =  [temp6 stringByAppendingString:distace_1];
    
//    cell.Direction.text =  [[[ED_STOP_NAME objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]stringByAppendingString:@" 방향"];
//    cell.Time.text =  [@"도착예정: "stringByAppendingString:[[PROVIDE_TYPE objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
//    cell.BusNumber.text =  [@"현재위치: "stringByAppendingString:[[ROUTE_NAME objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
//
    
    return cell;
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"SROUTENO"]) {SSROUTENO   = [[NSString alloc] init];}
    if ([element isEqualToString:@"SSTATIONNAME"]) {SSSTATIONNAME   = [[NSString alloc] init];}
    if ([element isEqualToString:@"ROUTESEQ_A"]) {SROUTESEQ_A    = [[NSString alloc] init];}
    if ([element isEqualToString:@"TSTATIONNAME"]) {STSTATIONNAME    = [[NSString alloc] init];}
    if ([element isEqualToString:@"ROUTESEQ_B"]) {SROUTESEQ_B   = [[NSString alloc] init];}
    if ([element isEqualToString:@"EROUTENO"]) {SEROUTENO  = [[NSString alloc] init];}
    if ([element isEqualToString:@"ESTATIONNAME"]) {SESTATIONNAME   = [[NSString alloc] init];}
    if ([element isEqualToString:@"DISTANCE"]) {SDISTANCE   = [[NSString alloc] init];}
    if ([element isEqualToString:@"SEQ"]) {SSEQ   = [[NSString alloc] init];}

    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"SROUTENO"]){  [SROUTENO addObject:SSROUTENO]; }
    if([elementName isEqualToString:@"SSTATIONNAME"]){  [SSTATIONNAME addObject:SSSTATIONNAME]; }
    if([elementName isEqualToString:@"ROUTESEQ_A"]){   [ROUTESEQ_A addObject:SROUTESEQ_A]; }
    if([elementName isEqualToString:@"TSTATIONNAME"]){ [TSTATIONNAME addObject:STSTATIONNAME]; }
    if([elementName isEqualToString:@"ROUTESEQ_B"]){ [ROUTESEQ_B addObject:SROUTESEQ_B]; }
    if([elementName isEqualToString:@"EROUTENO"]){ [EROUTENO addObject:SEROUTENO]; }
    if([elementName isEqualToString:@"ESTATIONNAME"]){ [ESTATIONNAME addObject:SESTATIONNAME]; }
    if([elementName isEqualToString:@"DISTANCE"]){ [DISTANCE addObject:SDISTANCE]; }
    if([elementName isEqualToString:@"SEQ"]){ [SEQ addObject:SSEQ]; }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"SROUTENO"]) { SSROUTENO = string; }
    else if ([element isEqualToString:@"SSTATIONNAME"]) { SSSTATIONNAME = string; }
    else if ([element isEqualToString:@"ROUTESEQ_A"]) { SROUTESEQ_A = string; }
    else if ([element isEqualToString:@"TSTATIONNAME"]) { STSTATIONNAME =string; }
    else if ([element isEqualToString:@"ROUTESEQ_B"]) { SROUTESEQ_B =string; }
    else if ([element isEqualToString:@"EROUTENO"]) { SEROUTENO =string; }
    else if ([element isEqualToString:@"ESTATIONNAME"]) { SESTATIONNAME =string; }
    else if ([element isEqualToString:@"DISTANCE"]) { SDISTANCE =string; }
    else if ([element isEqualToString:@"SEQ"]) { SSEQ =string; }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
    
    
}

@end
