//
//  DBHandlerMetroTrain.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 1. 30..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "DBHandlerMetroTrain.h"
#import "DBManager.h"
#import <sqlite3.h>

@implementation DBHandlerMetroTrain

static NSString *const STATION_ALL_COL = @"idx, name, latitude, longitude";
static NSString *const STATION_TABLE_NAME = @"MetroTrainStation";
static NSString *const KTX_TIME_TABLE_NAME = @"MetroKTX";
static NSString *const TRAIN_TIME_TABLE_NAME = @"MetroTrain";
static NSString *const DEFAULT_ORDER = @"idx";

-(NSArray *) getStation:(NSString *)train_type {
    DBManager *dbManager = [[DBManager alloc]init];
    NSString *filePath = dbManager.getDbFilePath;
    NSString *query = [dbManager getSelectQuery:STATION_ALL_COL from:STATION_TABLE_NAME
                                          where:[NSString stringWithFormat:@"type = '%@' or type ='all'",train_type] order:DEFAULT_ORDER];
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

-(NSArray *) selectTimeTable:(NSString *)train_type startStation:(NSString *)start destStation:(NSString *)dest time:(NSString *)time{
    
    DBManager *dbManager = [[DBManager alloc]init];
    NSString *filePath = dbManager.getDbFilePath;
    NSString *tableName = nil;
    NSString *defaultWhere = nil;
    
    if([train_type isEqualToString:@"KTX"]){
        tableName = [NSString stringWithFormat:@"%@", KTX_TIME_TABLE_NAME];
    }else{
        tableName = [NSString stringWithFormat:@"%@", TRAIN_TIME_TABLE_NAME];
    }
    defaultWhere = [NSString stringWithFormat:@"time(%@) >= time('%@') AND time(%@) < time(%@) AND %@ is NOT NULL AND %@ is NOT NULL", start, time, start, dest, start, dest];
    NSString *query = [dbManager getSelectQuery:[NSString stringWithFormat:@"train_name, %@, %@",start, dest] from:tableName
                                          where:[NSString stringWithFormat:@"%@",defaultWhere] order:[NSString stringWithFormat:@"time('%@')",start]];
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
                NSString *train_name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
                NSString *start = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
                NSString *dest = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
                
                NSDictionary *record = [NSDictionary dictionaryWithObjectsAndKeys:train_name,@"train_name",start,@"start",dest,@"dest", nil];
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
