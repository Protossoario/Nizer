//
//  NewActivityViewController.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/6/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewActivityViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;
@property (weak, nonatomic) IBOutlet UITextField *hour;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dayOfTheWeek;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;

@end
