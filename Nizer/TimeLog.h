//
//  TimeLog.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/26/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity;

@interface TimeLog : NSManagedObject

@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * suspendDate;
@property (nonatomic, retain) Activity *activity;
@property (nonatomic, retain) Activity *running;

@end
