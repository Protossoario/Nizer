//
//  NewNoteViewController.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 12/1/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Note.h"
#import "TimerViewController.h"

@interface NewNoteViewController : UIViewController <AVAudioPlayerDelegate, AVAudioRecorderDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) Note *note;

- (IBAction)recordButton:(id)sender;
- (IBAction)playButton:(id)sender;
- (IBAction)stopButton:(id)sender;
- (IBAction)tapGestureAction:(id)sender;

@end
