//
//  DBHandlerMetroBus.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 11..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBHandlerMetroBus : NSObject

-(NSArray *) getStation:(NSString *)bus_type;
-(NSArray *) selectTimeTable:(NSString *)start destStation:(NSString *)dest time:(NSString *)time;

@end
