//
//  Activity.m
//  Nizer
//
//  Created by Equipo Nizer on 11/26/14.
//  Copyright (c) 2014 Equipo Nizer. All rights reserved.
//

#import "Activity.h"
#import "TimeLog.h"


@implementation Activity {
    NSNumber *totalTime;
}

@dynamic category;
@dynamic date;
@dynamic name;
@dynamic repeat;
@dynamic running;
@dynamic timeLogs;

- (NSNumber*)getTotalTime {
    if (totalTime) {
        return totalTime;
    }
    double sum = 0.0;
    for (TimeLog *t in self.timeLogs) {
        sum += [t.duration doubleValue];
    }
    totalTime = [NSNumber numberWithDouble:sum];
    return totalTime;
}

@end
