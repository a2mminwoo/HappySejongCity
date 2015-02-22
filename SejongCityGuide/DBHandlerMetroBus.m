//
//  DBHandlerMetroBus.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 11..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "DBHandlerMetroBus.h"
#import "DBManager.h"
#import <sqlite3.h>

@implementation DBHandlerMetroBus

static NSString *const STATION_TABLE_NAME = @"MetroBusStation";
static NSString *const TIME_TABLE_NAME = @"MetroBusTimeTable";
static NSString *const STATION_ALL_COL = @"idx, name, type, latitude, longitude";
static NSString *const TIME_TABLE_ALL_COL = @"bus_type, destination, start_station, dest_station, start_time, FEE, TIME, comment";
static NSString *const DEFAULT_ORDER = @"idx";

-(NSArray *) getStation:(NSString *)bus_type {
    DBManager *dbManager = [[DBManager alloc]init];
    NSString *filePath = dbManager.getDbFilePath;
    NSString *defaultWhere =@"";
    if([bus_type isEqualToString:@""]){
        defaultWhere = nil;
    }else{
        defaultWhere = [NSString stringWithFormat:@"type = '%@'",bus_type];
    }
    NSString *query = [dbManager getSelectQuery:STATION_ALL_COL from:STATION_TABLE_NAME
                                          where:defaultWhere order:DEFAULT_ORDER];
    //NSLog(@"query is %@",query);
    NSMutableArray *records = [[NSMutableArray alloc] init];
    sqlite3* db = NULL;
    sqlite3_stmt* stmt = NULL;
    int rc = 0;
    rc = sqlite3_open_v2([filePath UTF8String], &db, SQLITE_OPEN_READONLY, NULL);
    if(SQLITE_OK != rc){
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }else{
        rc = sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, NULL);
        if(rc == SQLITE_OK){
            while(sqlite3_step(stmt) == SQLITE_ROW){
                NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
                
                NSDictionary *record = [NSDictionary dictionaryWithObjectsAndKeys:name,@"name", nil];
                [records addObject:record];
                //NSLog(@"name: %@", name);
            }
            NSLog(@"Done");
            sqlite3_finalize(stmt);
        }else{
            NSLog(@"Failed to prepare statment with rc:%d",rc);
        }
        sqlite3_close(db);
    }
    return records;
}

-(NSArray *) selectTimeTable:(NSString *)start destStation:(NSString *)dest time:(NSString *)time{
    
    DBManager *dbManager = [[DBManager alloc]init];
    NSString *filePath = dbManager.getDbFilePath;
    NSString *defaultWhere = nil;
    
    defaultWhere = [NSString stringWithFormat:@"start_station = '%@' AND dest_station = '%@' AND time(start_time) >= time('%@')", start, dest, time];
    NSString *query = [dbManager getSelectQuery:TIME_TABLE_ALL_COL from:TIME_TABLE_NAME
                                          where:[NSString stringWithFormat:@"%@",defaultWhere] order:@"time(start_time)"];
    //NSLog(@"query is %@",query);
    NSMutableArray *records = [[NSMutableArray alloc] init];
    sqlite3* db = NULL;
    sqlite3_stmt* stmt = NULL;
    int rc = 0;
    rc = sqlite3_open_v2([filePath UTF8String], &db, SQLITE_OPEN_READONLY, NULL);
    if(SQLITE_OK != rc){
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }else{
        rc = sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, NULL);
        if(rc == SQLITE_OK){
            while(sqlite3_step(stmt) == SQLITE_ROW){
                NSString *bus_type = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
                NSString *destination = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
                NSString *start_station = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
                NSString *dest_station = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
                NSString *start_time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
                NSString *FEE = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
                NSString *TIME = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
                
                NSDictionary *record = [NSDictionary dictionaryWithObjectsAndKeys:bus_type,@"bus_type",destination,@"destination",start_station,@"start_station",dest_station,@"dest_station",start_time,@"start_time",FEE,@"FEE",TIME,@"TIME", nil];
                [records addObject:record];
                //NSLog(@"train_name: %@, start: %@, dest: %@", train_name, start, dest);
            }
            NSLog(@"Done");
            sqlite3_finalize(stmt);
        }else{
            NSLog(@"Failed to prepare statment with rc:%d",rc);
        }
        sqlite3_close(db);
    }
    return records;
}

@end
