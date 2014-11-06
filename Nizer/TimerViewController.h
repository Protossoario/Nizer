//
//  TimerViewController.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/6/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
- (IBAction)start:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *pause;
@property (weak, nonatomic) IBOutlet UIButton *finish;
@property (weak, nonatomic) IBOutlet UIButton *addNote;

@end
