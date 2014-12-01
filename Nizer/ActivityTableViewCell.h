//
//  ActivityTableViewCell.h
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 12/1/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (void)loadWebViewImage:(NSString*)stringURL;

@end
