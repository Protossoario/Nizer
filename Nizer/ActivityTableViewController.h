//
//  ActivityTableViewController.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/6/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiBD.h"
#import "Activity.h"
#import "TimerViewController.h"
#import "ActivityTableViewCell.h"

@interface ActivityTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>


- (IBAction)unwindToActivityTableViewController:(UIStoryboardSegue *)segue;


@end
