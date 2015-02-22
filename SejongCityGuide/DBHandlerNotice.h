//
//  DBHandlerNotice.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 12..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBHandlerNotice : NSObject

-(NSArray *) selectNotice:(NSString *)type;
-(NSArray *) selectVersion;

@end
