//
//  TimerViewController.m
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/6/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController () {
    BOOL paused;
    BOOL started;
    NSTimeInterval secondsAlreadyRun;
}

@end

@implementation TimerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bd = [ApiBD getSharedInstance];
    self.stopwatchLabel.text = @"00:00:00";
    self.navigationItem.title = self.activity.name;
    secondsAlreadyRun = 0;
    paused = NO;
    started = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTimer
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:_startDate];
    timeInterval += secondsAlreadyRun;
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    _stopwatchLabel.text = timeString;
}

- (IBAction)startStopwatch:(id)sender {
    _startDate = [[NSDate alloc] init];
    if (!started) {
        self.firstStartDate = self.startDate;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yy HH:mm:ss"];
        self.startDateLabel.text = [NSString stringWithFormat:@"Start date: %@", [dateFormatter stringFromDate:_startDate]];
        started = YES;
    }
    _stopwatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                       target:self
                                                     selector:@selector(updateTimer)
                                                     userInfo:nil
                                                      repeats:YES];
    [_stopwatchTimer fire];
}

- (IBAction)pauseStopwatch:(id)sender {
    secondsAlreadyRun += [[NSDate date] timeIntervalSinceDate:_startDate];
    [_stopwatchTimer invalidate];
    _stopwatchTimer = nil;
    paused = YES;
}

- (void)saveTimeLog {
    if (started) {
        [self.bd insertTimeLog:[NSNumber numberWithDouble:secondsAlreadyRun] startDate:self.firstStartDate activity:self.activity];
        //secondsAlreadyRun = 0;
        //self.stopwatchLabel.text = @"00:00:00";
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"unwindToActivityTableViewController"]) {
        [self saveTimeLog];
    }
}

@end
