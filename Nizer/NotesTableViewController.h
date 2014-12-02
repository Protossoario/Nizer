//
//  NotesTableViewController.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 12/1/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TimeLog.h"
#import "Note.h"

@interface NotesTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, AVAudioPlayerDelegate>

@property (strong, nonatomic) TimeLog *timelog;

@end
