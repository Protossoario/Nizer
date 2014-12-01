//
//  ActivityTableViewCell.h
//  Nizer
//
//  Created by Equipo Nizer on 12/1/14.
//  Copyright (c) 2014 Equipo Nizer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (void)loadWebViewImage:(NSString*)stringURL;

@end
