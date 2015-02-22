//
//  DBManager.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 1. 30..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

-(NSString *) getDbFilePath;
-(NSString *) getSelectQuery:(NSString *)col from:(NSString *)fm where:(NSString *)whereStmt order:(NSString *)orderSql;
-(NSString *) getSelectOneQuery:(NSString *)col from:(NSString *)fm where:(NSString *)whereStmt order:(NSString *)orderSql;

@end
