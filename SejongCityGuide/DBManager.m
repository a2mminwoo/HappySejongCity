//
//  DBManager.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 1. 30..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

-(NSString *)getDbFilePath
{
    NSString *defaultDBPath = [[NSBundle mainBundle] resourcePath];
    NSLog(@"defaultDBPath is %@", defaultDBPath);
    
    return [defaultDBPath stringByAppendingPathComponent:@"sejong_e.db"];
}

-(NSString *) getSelectQuery:(NSString *)col from:(NSString *)fm where:(NSString *)whereStmt order:(NSString *)orderSql
{
    NSString *query = @"SELECT ";
    query = [query stringByAppendingFormat:@"%@ FROM %@", col, fm];
    
    if (whereStmt != nil && ![whereStmt isEqualToString:@""]) {
        query = [query stringByAppendingFormat:@" WHERE %@", whereStmt];
    }
    if (orderSql != nil && ![orderSql isEqualToString:@""]){
        query = [query stringByAppendingFormat:@" ORDER BY %@", orderSql];
    }
    
    return query;
}

-(NSString *) getSelectOneQuery:(NSString *)col from:(NSString *)fm where:(NSString *)whereStmt order:(NSString *)orderSql
{
    NSString *query = @"SELECT ";
    query = [query stringByAppendingFormat:@"%@ FROM %@", col, fm];
    
    if (whereStmt != nil && ![whereStmt isEqualToString:@""]) {
        query = [query stringByAppendingFormat:@" WHERE %@", whereStmt];
    }
    if (orderSql != nil && ![orderSql isEqualToString:@""]){
        query = [query stringByAppendingFormat:@" ORDER BY %@", orderSql];
    }
    query = [query stringByAppendingString:@" limit 1"];
    
    return query;
}

@end
