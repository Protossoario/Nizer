//
//  NewActivityViewController.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/6/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
#import "ApiBD.h"

@interface NewActivityViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UISegmentedControl *repeatControl;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;
- (void)saveActivity;
- (IBAction)tapGestureAction:(id)sender;

@end
