//
//  APPMasterViewController.m
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "LocalBISRouteViewController.h"
#import "LocalBISRouteDetailViewController.h"
#import "RouteListCell.h"

@interface LocalBISRouteViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *ROUTE_ID;
    NSMutableString *ROUTE_NAME;
    NSMutableString *ST_STOP_NAME;
    NSMutableString *ED_STOP_NAME;
    NSMutableString *START_TIME;
    NSMutableString *END_TIME;
    NSMutableString *ALLOC_TIME;
    NSString *element;
}
@end

@implementation LocalBISRouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.searchBar setDelegate:self];
    
    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://14.50.216.131:8081/bbs/bbsrss.do?searchFlag=ROUTE&search="];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    RouteListCell *cell = (RouteListCell *)[tableView dequeueReusableCellWithIdentifier:@"RouteListCell"];
    
    NSString *ROUTE_NAME =[[[feeds objectAtIndex:indexPath.row] objectForKey: @"ROUTE_NAME"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([ROUTE_NAME isEqualToString:@"990"]){
        cell.routeName.text =  [NSString stringWithFormat:@"(세종광역) %@",ROUTE_NAME];
    }else if([ROUTE_NAME isEqualToString:@"751"]){
        cell.routeName.text =[NSString stringWithFormat:@"(청주광역) %@",ROUTE_NAME];
    }else{
        cell.routeName.text = [NSString stringWithFormat:@"(일반) %@",ROUTE_NAME];
    }
    
    NSString *ST_STOP_NAME = [[[feeds objectAtIndex:indexPath.row] objectForKey: @"ST_STOP_NAME"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *ED_STOP_NAME = [[[feeds objectAtIndex:indexPath.row] objectForKey: @"ED_STOP_NAME"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *Path  = [NSString stringWithFormat:@"%@ ↔ %@",ST_STOP_NAME,ED_STOP_NAME];
    cell.routePath.text = Path;
    
    return cell;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        ROUTE_ID   = [[NSMutableString alloc] init];
        ROUTE_NAME   = [[NSMutableString alloc] init];
        ST_STOP_NAME   = [[NSMutableString alloc] init];
        ED_STOP_NAME   = [[NSMutableString alloc] init];
        ALLOC_TIME   = [[NSMutableString alloc] init];
        START_TIME   = [[NSMutableString alloc] init];
        END_TIME   = [[NSMutableString alloc] init];

        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:ROUTE_NAME forKey:@"ROUTE_NAME"];
        [item setObject:ROUTE_ID forKey:@"ROUTE_ID"];
        [item setObject:START_TIME forKey:@"START_TIME"];
        [item setObject:END_TIME forKey:@"END_TIME"];
        [item setObject:ST_STOP_NAME forKey:@"ST_STOP_NAME"];
        [item setObject:ED_STOP_NAME forKey:@"ED_STOP_NAME"];
        [item setObject:ALLOC_TIME forKey:@"ALLOC_TIME"];
        
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"ROUTE_ID"]) {
        [ROUTE_ID appendString:string];
    } else if ([element isEqualToString:@"ROUTE_NAME"]) {
        [ROUTE_NAME appendString:string];
    }else if ([element isEqualToString:@"ST_STOP_NAME"]) {
        [ST_STOP_NAME appendString:string];
    }else if ([element isEqualToString:@"ED_STOP_NAME"]) {
        [ED_STOP_NAME appendString:string];
    }else if ([element isEqualToString:@"START_TIME"]) {
        [START_TIME appendString:string];
    }else if ([element isEqualToString:@"END_TIME"]) {
        [END_TIME appendString:string];
    }else if ([element isEqualToString:@"ALLOC_TIME"]) {
        [ALLOC_TIME appendString:string];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    LocalBISRouteDetailViewController* detailView =[segue destinationViewController];

    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    detailView.param = [[feeds[indexPath.row] objectForKey: @"ROUTE_ID"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *ROUTE_NAME = [[feeds[indexPath.row] objectForKey: @"ROUTE_NAME"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([ROUTE_NAME isEqualToString:@"990"]){
        detailView.SbusNumber=  [NSString stringWithFormat:@"(세종광역) %@",ROUTE_NAME];
    }else if([ROUTE_NAME isEqualToString:@"751"]){
        detailView.SbusNumber =[NSString stringWithFormat:@"(청주광역) %@",ROUTE_NAME];
    }else{
        detailView.SbusNumber = [NSString stringWithFormat:@"(일반) %@",ROUTE_NAME];
    }
    
    detailView.SALLOC_TIME = [[feeds[indexPath.row] objectForKey: @"ALLOC_TIME"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    detailView.SSTART_TIME = [NSString stringWithFormat:@"(첫 차) %@",[[feeds[indexPath.row] objectForKey: @"START_TIME"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    detailView.SEND_TIME = [NSString stringWithFormat:@"(막 차) %@",[[feeds[indexPath.row] objectForKey: @"END_TIME"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    
    
    
//   [[segue destinationViewController] setUrl:string];
    //    [self presentViewController:detailView animated:YES completion:nil];;
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"searchText : %@",searchBar.text);
    
    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:[@"http://14.50.216.131:8081/bbs/bbsrss.do?searchFlag=ROUTE&search="stringByAppendingString:searchBar.text]];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}

- (IBAction)backAction:(id)sender {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"BISHome"];
    
    [self presentViewController:viewController animated:YES completion:nil];

}
@end
