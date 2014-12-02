//
//  Note.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 12/1/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TimeLog;

@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * voice;
@property (nonatomic, retain) TimeLog *timelog;

@end
