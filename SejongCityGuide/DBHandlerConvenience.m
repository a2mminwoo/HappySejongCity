//
//  DBHandlerConvenience.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 5..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "DBHandlerConvenience.h"
#import "DBManager.h"
#import <sqlite3.h>

@implementation DBHandlerConvenience

static NSString *const ALL_COL = @"idx, org_part, org_title, org_addr, org_tel, org_web, org_info, org_lati, org_longi, org_image, org_time";
static NSString *const TABLE_NAME = @"Convenience";
static NSString *const DEFAULT_ORDER = @"idx";

-(NSArray *) selectConvenience:(NSString *)category{
    DBManager *dbManager = [[DBManager alloc]init];
    NSString *filePath = dbManager.getDbFilePath;
    NSString *query = [dbManager getSelectQuery:ALL_COL from:TABLE_NAME
                                          where:[NSString stringWithFormat:@"org_part = '%@'",category] order:DEFAULT_ORDER];
    NSLog(@"query is %@",query);
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
                NSString *org_part = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
                NSString *org_title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
                NSString *org_addr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
                NSString *org_tel = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
                NSString *org_web = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
                NSString *org_info = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
                NSString *org_lati = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
                NSString *org_longi = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 8)];
                NSString *org_image = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 9)];
                NSString *org_time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 10)];
                
                NSDictionary *record = [NSDictionary dictionaryWithObjectsAndKeys:idx,@"idx",org_part,@"org_part",org_title,@"org_title",
                                        org_addr,@"org_addr",org_tel,@"org_tel",org_web,@"org_web",
                                        org_info,@"org_info",org_lati,@"org_lati",org_longi,@"org_longi",org_image,@"org_image",org_time,@"org_time", nil];
                [records addObject:record];
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

-(NSArray *) selectConvenienceOne:(NSString *)title {
    DBManager *dbManager = [[DBManager alloc]init];
    NSString *filePath = dbManager.getDbFilePath;
    NSString *query = [dbManager getSelectQuery:ALL_COL from:TABLE_NAME
                                          where:[NSString stringWithFormat:@"org_title = '%@'",title] order:DEFAULT_ORDER];
    NSLog(@"query is %@",query);
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
                NSString *org_title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
                
                NSDictionary *record = [NSDictionary dictionaryWithObjectsAndKeys:org_title,@"org_title", nil];
                [records addObject:record];
                NSLog(@"name: %@", org_title);
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
