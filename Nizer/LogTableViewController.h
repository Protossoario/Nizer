//
//  LogTableViewController.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/6/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiBD.h"
#import "TimeLog.h"

@interface LogTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ApiBD *bd;

@end
