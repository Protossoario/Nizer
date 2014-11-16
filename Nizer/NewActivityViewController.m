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
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Must input a name for the activity" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (IBAction)saveActivity:(id)sender {
    if ([self validateFields]) {
        Activity *newActivity = [[Activity alloc] init];
        newActivity.name = [self.nameText text];
        newActivity.repeat = [self.repeatControl selectedSegmentIndex];
        newActivity.date = [self.datePicker date];
        newActivity.category = categories[[self.categoryPicker selectedRowInComponent:0]];
        [bd insertActivity:newActivity];
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
