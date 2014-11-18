//
//  TimerViewController.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/6/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiBD.h"
#import "Activity.h"
#import "TimeLog.h"

@interface TimerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *stopwatchLabel;
@property (strong, nonatomic) IBOutlet UILabel *startDateLabel;
@property (strong, nonatomic) Activity *activity;
@property (strong, nonatomic) ApiBD *bd;
@property (strong, nonatomic) NSTimer *stopwatchTimer;  //store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate;  //the date of the click of the start button

- (IBAction)startStopwatch:(id)sender;
- (IBAction)pauseStopwatch:(id)sender;
- (void)endStopwatch;

@end
