//
//  ApiBD.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/15/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Activity.h"
#import "TimeLog.h"

@interface ApiBD : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveData;
- (NSURL *)applicationDocumentsDirectory;
- (NSManagedObjectContext*)managedObjectContext;
- (void)insertActivity:(Activity *)activity;
- (void)insertActivity:(NSString*)name startDate:(NSDate*)date repeatNumber:(NSNumber*)repeat category:(NSString*)category;
- (void)insertTimeLog:(TimeLog *)timelog;
- (void)insertTimeLog:(NSNumber*)interval startDate:(NSDate*)date activity:(Activity*)activity;
- (void)insertRunningTimeLog:(NSNumber*)interval startDate:(NSDate*)startDate activity:(Activity*)activity suspendDate:(NSDate*)suspendDate;
- (NSArray*)getActivities;
- (NSArray*)getTimeLogs;
+ (ApiBD*)getSharedInstance;

@end
