//
//  DBHandlerNotice.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 12..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "DBHandlerNotice.h"
#import "DBManager.h"
#import <sqlite3.h>

@implementation DBHandlerNotice

static NSString *const ALL_COL = @"idx, type, contents, date";
static NSString *const ALL_COL2 = @"current_v, latest_v";
static NSString *const TABLE_NAME = @"NoticeTable";
static NSString *const DEFAULT_ORDER = @"idx desc";

-(NSArray *)selectNotice:(NSString *)type
{
    DBManager *dbManager = [[DBManager alloc]init];
    NSString *filePath = dbManager.getDbFilePath;
    NSString *defaultWhere = @"";
    if(defaultWhere != nil && ![defaultWhere isEqualToString:@""]){
        defaultWhere = [NSString stringWithFormat:@"type = '%@'",type];
    }
    
    NSString *query = [dbManager getSelectQuery:ALL_COL from:TABLE_NAME
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
                NSString *idx = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
                NSString *type = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
                NSString *contents = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
                NSString *date = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
                
                NSDictionary *record = [NSDictionary dictionaryWithObjectsAndKeys:idx,@"idx",type,@"type",contents,@"contents",date,@"date",nil];
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

-(NSArray *)selectVersion
{
    DBManager *dbManager = [[DBManager alloc]init];
    NSString *filePath = dbManager.getDbFilePath;
    
    NSString *query = [dbManager getSelectQuery:ALL_COL2 from:@"VersionInfo"
                                          where:nil order:nil];
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
                NSString *current_v = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
                NSString *latest_v = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
                
                NSDictionary *record = [NSDictionary dictionaryWithObjectsAndKeys:current_v,@"current_v",latest_v,@"latest_v", nil];
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

@end
