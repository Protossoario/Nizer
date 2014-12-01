//
//  ApiBD.m
//  Nizer
//
//  Created by Equipo Nizer on 11/15/14.
//  Copyright (c) 2014 Equipo Nizer. All rights reserved.
//

#import "ApiBD.h"

@implementation ApiBD

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (void)saveData {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSError *error = nil;
    
    if (![context save:&error]) {
        NSLog(@"Error al guardar los datos %@, %@", error, [error userInfo]);
    }
    else {
        NSLog(@"Datos guardados");
    }
}

- (void)insertActivity:(Activity *)activity {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:context];
    
    [newManagedObject setValue:activity.name forKey:@"name"];
    [newManagedObject setValue:activity.date forKey:@"date"];
    [newManagedObject setValue:activity.category forKey:@"category"];
    [newManagedObject setValue:activity.repeat forKey:@"repeat"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    else {
        NSLog(@"Nueva actividad guardada con exito");
    }
}

- (void)insertActivity:(NSString *)name startDate:(NSDate *)date repeatNumber:(NSNumber *)repeat category:(NSString *)category {
    NSManagedObjectContext *context = self.managedObjectContext;
    Activity *newActivity = [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:context];
    newActivity.name = name;
    newActivity.date = date;
    newActivity.category = category;
    newActivity.repeat = repeat;
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    else {
        NSLog(@"Nueva actividad guardada con exito");
    }
}

- (void)insertTimeLog:(TimeLog *)timelog {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"TimeLog" inManagedObjectContext:context];
    
    [newManagedObject setValue:timelog.activity forKey:@"activity"];
    [newManagedObject setValue:timelog.startDate forKey:@"startDate"];
    [newManagedObject setValue:timelog.duration forKey:@"duration"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    else {
        NSLog(@"Registro de TimeLog guardado con exito");
    }
}

- (void)insertTimeLog:(NSNumber *)interval startDate:(NSDate *)date activity:(Activity *)activity {
    NSManagedObjectContext *context = self.managedObjectContext;
    TimeLog *newTimeLog = [NSEntityDescription insertNewObjectForEntityForName:@"TimeLog" inManagedObjectContext:context];
    
    newTimeLog.startDate = date;
    newTimeLog.duration = interval;
    newTimeLog.activity = activity;
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    else {
        NSLog(@"Registro de TimeLog guardado con exito");
    }
}

- (void)insertRunningTimeLog:(NSNumber *)interval startDate:(NSDate *)startDate activity:(Activity *)activity suspendDate:(NSDate *)suspendDate {
    NSManagedObjectContext *context = self.managedObjectContext;
    TimeLog *newRunningTimeLog = [NSEntityDescription insertNewObjectForEntityForName:@"TimeLog" inManagedObjectContext:context];
    
    newRunningTimeLog.startDate = startDate;
    newRunningTimeLog.duration = interval;
    newRunningTimeLog.running = activity;
    newRunningTimeLog.suspendDate = suspendDate;
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    else {
        NSLog(@"Registro de TimeLog suspendido guardado con exito");
    }
}

- (NSArray*)getActivities {
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Activity" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 0) {
        NSLog(@"No existen actividades que cargar");
    }
    return objects;
}

- (NSArray*)getTimeLogs {
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"TimeLog" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"activity <> nil"];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 0) {
        NSLog(@"No existen actividades que cargar");
    }
    return objects;
}

-(void) deleteActivity:(Activity *)activity
{
    
    NSManagedObjectContext *context = self.managedObjectContext;
    [context deleteObject:activity];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    else {
        NSLog(@"Actividad borrada con éxito");
    }
    
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Nizer.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

+ (ApiBD*)getSharedInstance {
    static ApiBD *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[ApiBD alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
