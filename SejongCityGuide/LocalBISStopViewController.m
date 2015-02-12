//
//  APPMasterViewController.m
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "LocalBISStopViewController.h"
#import "LocalBISStopDetailViewController.h"
#import "StopListCell.h"

@interface LocalBISStopViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *STOP_ID;
    NSMutableString *STOP_NAME;
    NSString *element;
}
@end

@implementation LocalBISStopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.searchBar setDelegate:self];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StopListCell *cell = (StopListCell *)[tableView dequeueReusableCellWithIdentifier:@"StopListCell"];
    
    cell.StopList.text = [[[feeds objectAtIndex:indexPath.row] objectForKey: @"STOP_NAME"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return cell;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        item    = [[NSMutableDictionary alloc] init];
        STOP_ID   = [[NSMutableString alloc] init];
        STOP_NAME   = [[NSMutableString alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:STOP_ID forKey:@"STOP_ID"];
        [item setObject:STOP_NAME forKey:@"STOP_NAME"];

        
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"STOP_ID"]) {
        [STOP_ID appendString:string];
    } else if ([element isEqualToString:@"STOP_NAME"]) {
        [STOP_NAME appendString:string];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    LocalBISStopDetailViewController* detailView =[segue destinationViewController];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    detailView.param = [[feeds[indexPath.row] objectForKey: @"STOP_ID"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    detailView.SStopName= [[feeds[indexPath.row] objectForKey: @"STOP_NAME"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    //   [[segue destinationViewController] setUrl:string];
    //    [self presentViewController:detailView animated:YES completion:nil];;
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"searchText : %@",searchBar.text);
    
    feeds = [[NSMutableArray alloc] init];
    
    NSString *original = searchBar.text;
    
    // URL Encode
    NSString *encoded = [original stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:[@"http://14.50.216.131:8081/bbs/bbsrss.do?searchFlag=STOP&search="stringByAppendingString:encoded]];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}

@end
