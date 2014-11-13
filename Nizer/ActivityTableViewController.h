//
//  ActivityTableViewController.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/6/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewController : UITableViewController
@property (nonatomic, strong) UIActivityViewController *activityViewController;
- (IBAction)share:(id)sender;

@end
