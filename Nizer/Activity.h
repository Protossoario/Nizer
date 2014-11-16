//
//  Activity.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/15/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) NSInteger repeat;
@property (strong, nonatomic) NSString *category;

@end
