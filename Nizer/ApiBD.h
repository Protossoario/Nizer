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

@interface ApiBD : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)insertActivity:(Activity*)activity;
+ (ApiBD*)getSharedInstance;

@end
