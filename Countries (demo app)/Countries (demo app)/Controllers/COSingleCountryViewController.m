//
//  COSingleCountryViewController.m
//  Countries (demo app)
//
//  Created by Guilherme Rambo on 20/05/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "COSingleCountryViewController.h"
#import "GRBarProgressView.h"

#define kWikipediaURLFormat @"http://en.m.wikipedia.org/wiki/%@"

@import WebKit;

@interface COSingleCountryViewController ()

@property (weak) IBOutlet WebView *webView;
@property (weak) IBOutlet GRBarProgressView *progressBar;

@end

@implementation COSingleCountryViewController

- (void)viewWillAppear:(BOOL)animated
{
    // hide the progressbar at 90%
    self.progressBar.hideThresholdMax = @90;
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    self.webView.frameLoadDelegate = self;
    
    self.title = self.country[@"name"];
    self.webView.mainFrameURL = [NSString stringWithFormat:kWikipediaURLFormat, self.country[@"name"]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![keyPath isEqualToString:@"estimatedProgress"]) return;
    
    self.progressBar.progress = @(self.webView.estimatedProgress*100);
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    if (frame != self.webView.mainFrame) return;
    
    [frame.frameView.enclosingScrollView setVerticalScrollElasticity:NSScrollElasticityAllowed];
}

@end
