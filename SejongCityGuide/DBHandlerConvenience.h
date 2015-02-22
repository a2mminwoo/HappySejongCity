//
//  DBHandlerConvenience.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 5..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBHandlerConvenience : NSObject

-(NSArray *) selectConvenience:(NSString *)category;
-(NSArray *) selectConvenienceOne:(NSString *)title;

@end
