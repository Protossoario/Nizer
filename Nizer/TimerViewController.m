//
//  TimerViewController.m
//  Nizer
//
//  Created by Equipo Nizer on 11/6/14.
//  Copyright (c) 2014 Equipo Nizer. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController () {
    BOOL started;
    BOOL paused;
    BOOL finished;
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
    
    paused = YES;
    if (self.activity.running != nil) {
        NSLog(@"Cargando TimeLog suspendido.");
        self.notes = [[NSMutableSet alloc] initWithSet:self.activity.running.notes];
        TimeLog *runningLog = self.activity.running;
        secondsAlreadyRun = [runningLog.duration doubleValue];
        self.firstStartDate = runningLog.startDate;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yy HH:mm:ss"];
        self.startDateLabel.text = [NSString stringWithFormat:@"Start date: %@", [dateFormatter stringFromDate:self.firstStartDate]];
        
        started = YES;
        
        if (runningLog.suspendDate != nil) {
            secondsAlreadyRun += [[NSDate date] timeIntervalSinceDate:runningLog.suspendDate];
            NSLog(@"Tiempo en el fondo=%@", [[NSNumber numberWithDouble:[[NSDate date] timeIntervalSinceDate:runningLog.suspendDate]] stringValue]);
            [self startStopwatch:nil];
        }
        else {
            NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:secondsAlreadyRun];
            [dateFormatter setDateFormat:@"HH:mm:ss"];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
            NSString *timeString=[dateFormatter stringFromDate:timerDate];
            _stopwatchLabel.text = timeString;
        }
    }
    else {
        self.notes = [[NSMutableSet alloc] init];
        self.stopwatchLabel.text = @"00:00:00";
        secondsAlreadyRun = 0;
        started = NO;
    }
    finished = NO;
    self.navigationItem.title = self.activity.name;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.activity.running != nil && !finished) {
        if (paused) {
            self.activity.running.duration = [NSNumber numberWithDouble:secondsAlreadyRun];
            self.activity.running.suspendDate = nil;
            [self.activity.running addNotes:self.notes];
            [self.bd saveData];
        }
        else {
            [self pauseStopwatch:nil];
            self.activity.running.duration = [NSNumber numberWithDouble:secondsAlreadyRun];
            self.activity.running.suspendDate = [NSDate date];
            [self.activity.running addNotes:self.notes];
            [self.bd saveData];
        }
    }
    else if (started && !finished) {
        if (paused) {
            [self.bd insertRunningTimeLog:[NSNumber numberWithDouble:secondsAlreadyRun] startDate:self.firstStartDate activity:self.activity suspendDate:nil];
            [self.activity.running addNotes:self.notes];
            [self.bd saveData];
        }
        else {
            [self pauseStopwatch:nil];
            [self.bd insertRunningTimeLog:[NSNumber numberWithDouble:secondsAlreadyRun] startDate:self.firstStartDate activity:self.activity suspendDate:[NSDate date]];
            [self.activity.running addNotes:self.notes];
            [self.bd saveData];
        }
    }
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
    if (!started) {
        self.firstStartDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yy HH:mm:ss"];
        self.startDateLabel.text = [NSString stringWithFormat:@"Start date: %@", [dateFormatter stringFromDate:self.firstStartDate]];
        started = YES;
    }
    
    if (paused) {
        _startDate = [NSDate date];
        _stopwatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
        [_stopwatchTimer fire];
        paused = NO;
    }
}

- (IBAction)pauseStopwatch:(id)sender {
    if (!paused) {
        secondsAlreadyRun += [[NSDate date] timeIntervalSinceDate:_startDate];
        [_stopwatchTimer invalidate];
        _stopwatchTimer = nil;
        paused = YES;
    }
}

- (void)saveTimeLog {
    if (started && self.activity.running != nil) {
        self.activity.running.duration = [NSNumber numberWithDouble:secondsAlreadyRun];
        [self.activity.running addNotes:self.notes];
        NSLog(@"Cantidad de notas a guardar: %d", [self.activity.running.notes count]);
        NSLog(@"Cantidad de notas guardadas: %d", [self.notes count]);
        [self.activity addTimeLogsObject:self.activity.running];
        self.activity.running = nil;
        [self.bd saveData];
    }
    else if (started) {
        [self.bd insertTimeLog:[NSNumber numberWithDouble:secondsAlreadyRun] startDate:self.firstStartDate activity:self.activity notes:self.notes];
    }
}

- (void)addNote:(Note *)note {
    [self.notes addObject:note];
}

- (IBAction)fbButton:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *facebookController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        //set initial message
        NSString *mensaje = self.activity.name;
        NSString *men = [NSString stringWithFormat: @"¡Estoy haciendo mi actividad del día: %@ !",mensaje];
        [facebookController setInitialText:men];
        
        //present the controller to the user
        [self presentViewController:facebookController animated:YES completion:nil];
        
        
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Facebook Error" message:@"You may not have set Facebook correctly on your device." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)twButton:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *twitterController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        //set initial message
        NSString *mensaje = self.activity.name;
        NSString *men = [NSString stringWithFormat: @"¡Estoy haciendo mi actividad del día: %@ !",mensaje];
        [twitterController setInitialText:men];
        
        
        //present the controller to the user
        [self presentViewController:twitterController animated:YES completion:nil];
        
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Twitter Error" message:@"You may not have set Twitter correctly on your device." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
}

- (IBAction)share:(id)sender {
    
    NSString *textToPost = @"Estoy usando Nizer.";
    //UIImage *imageToPost = self.imagenDuck.image; //lo que se comparte
    
    NSArray *activityItems = @[textToPost];
    self.activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:self.activityViewController animated:YES completion:nil];
}

- (IBAction)unwindToTimerViewController:(UIStoryboardSegue *)segue {
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"unwindToActivityTableViewController"]) {
        [self pauseStopwatch:nil];
        [self saveTimeLog];
        finished = YES;
    }
    else if ([[segue identifier] isEqualToString:@"addNote"]) {
        Note *note = [self.bd insertNote];
        [(NewNoteViewController *)[segue destinationViewController] setNote:note];
    }
}

@end
