//
//  DBHandlerMetroTrain.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 1. 30..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBHandlerMetroTrain : NSObject

-(NSArray *) getStation:(NSString *)train_type;
-(NSArray *) selectTimeTable:(NSString *)train_type startStation:(NSString *)start destStation:(NSString *)dest time:(NSString *)time;

@end
