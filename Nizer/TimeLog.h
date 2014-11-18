//
//  TimeLog.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/17/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeLog : NSObject

@property (strong, nonatomic) NSString *activity;
@property (strong, nonatomic) NSDate *startDate;
@property (nonatomic) NSTimeInterval duration;

@end
