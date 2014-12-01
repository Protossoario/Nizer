//
//  LogTableViewController.h
//  Nizer
//
//  Created by Equipo Nizer on 11/6/14.
//  Copyright (c) 2014 Equipo Nizer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiBD.h"
#import "TimeLog.h"
#import "Activity.h"

@interface LogTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ApiBD *bd;

@end
