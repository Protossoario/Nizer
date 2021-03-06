//
//  ActivityTableViewCell.m
//  Nizer
//
//  Created by Equipo Nizer on 12/1/14.
//  Copyright (c) 2014 Equipo Nizer. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadWebViewImage:(NSString*)stringURL {
    [self.loadingIndicator startAnimating];
    NSURL *url = [NSURL URLWithString:stringURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark – UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize contentSize = webView.scrollView.contentSize;
    CGSize viewSize = self.webView.bounds.size;
    float scale = viewSize.width / contentSize.width;
    webView.scrollView.minimumZoomScale = scale;
    webView.scrollView.maximumZoomScale = scale;
    webView.scrollView.zoomScale = scale;
    [self.loadingIndicator stopAnimating];
}

@end
