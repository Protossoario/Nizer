//
//  TimerViewController.h
//  Nizer
//
//  Created by Equipo Nizer on 11/6/14.
//  Copyright (c) 2014 Equipo Nizer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

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
@property (strong, nonatomic) NSDate *firstStartDate;

- (IBAction)startStopwatch:(id)sender;
- (IBAction)pauseStopwatch:(id)sender;
- (void)saveTimeLog;

@property (nonatomic, strong) UIActivityViewController *activityViewController;
- (IBAction)fbButton:(id)sender;
- (IBAction)twButton:(id)sender;
- (IBAction)share:(id)sender;

@end
