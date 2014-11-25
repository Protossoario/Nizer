//
//  NewActivityViewController.m
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/6/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import "NewActivityViewController.h"

@interface NewActivityViewController () {
    NSArray *categories;
    ApiBD *bd;
}

@end

@implementation NewActivityViewController

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
    categories = [[NSArray alloc] initWithObjects:@"Work", @"School", @"Athletic", @"Fun", @"Read", nil];
    bd = [ApiBD getSharedInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)validateFields {
    if ([[self.nameText text] isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (void)saveActivity {
    [bd insertActivity:self.nameText.text startDate:self.datePicker.date repeatNumber:[NSNumber numberWithInteger:self.repeatControl.selectedSegmentIndex] category:categories[[self.categoryPicker selectedRowInComponent:0]]];
    
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = _datePicker.date;
    NSString *act = _nameText.text;
    localNotification.alertBody = [NSString stringWithFormat:@"Actividad %@ pendiente!", act];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1;
    
    //never daily weekly monthly
    
    NSInteger index = [_repeatControl selectedSegmentIndex];
    
    switch (index) {
        case 1:
            localNotification.repeatInterval = NSDayCalendarUnit;
            break;
        case 2:
            localNotification.repeatInterval = NSWeekCalendarUnit;
            break;
        case 3:
           localNotification.repeatInterval = NSMonthCalendarUnit;
            break;
        default:
            localNotification.repeatInterval = 0;
            break;
    }
    
    localNotification.repeatInterval=NSMinuteCalendarUnit;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

    
}

- (IBAction)tapGestureAction:(id)sender {
    [self.nameText resignFirstResponder];
}

#pragma mark – UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [categories count];
}

#pragma mark – UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return categories[row];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"unwindToActivityTableViewController"]) {
        if ([self validateFields]) {
            [self saveActivity];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Must input a name for the activity" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
}

@end
