//
//  TimeLog.h
//  Nizer
//
//  Created by Equipo Nizer on 11/26/14.
//  Copyright (c) 2014 Equipo Nizer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity, Note;

@interface TimeLog : NSManagedObject

@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * suspendDate;
@property (nonatomic, retain) Activity *activity;
@property (nonatomic, retain) Activity *running;
@property (nonatomic, retain) NSSet *notes;
@end

@interface TimeLog (CoreDataGeneratedAccessors)

- (void)addNotesObject:(Note *)value;
- (void)removeNotesObject:(Note *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

@end
