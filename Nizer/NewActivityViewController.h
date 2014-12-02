//
//  NewActivityViewController.h
//  Nizer
//
//  Created by Equipo Nizer on 11/6/14.
//  Copyright (c) 2014 Equipo Nizer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
#import "ApiBD.h"

@interface NewActivityViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UISegmentedControl *repeatControl;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIPickerView *categoryPicker;
- (void)saveActivity;
- (IBAction)tapGestureAction:(id)sender;

@end
