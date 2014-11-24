//
//  Activity.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/23/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TimeLog;

@interface Activity : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * repeat;
@property (nonatomic, retain) NSSet *timeLogs;
@end

@interface Activity (CoreDataGeneratedAccessors)

- (void)addTimeLogsObject:(TimeLog *)value;
- (void)removeTimeLogsObject:(TimeLog *)value;
- (void)addTimeLogs:(NSSet *)values;
- (void)removeTimeLogs:(NSSet *)values;

@end
