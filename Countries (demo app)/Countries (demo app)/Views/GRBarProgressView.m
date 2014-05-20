//
//  COBarProgressView.m
//  Countries (demo app)
//
//  Created by Guilherme Rambo on 20/05/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import "GRBarProgressView.h"

@import QuartzCore;

@interface GRBarProgressView ()

@property (nonatomic, strong) CALayer *progressLayer;

@end

@implementation GRBarProgressView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    // setup background layer
    self.wantsLayer = YES;
    self.layer = [CALayer layer];
    
    // setup foreground layer
    self.progressLayer = [CALayer layer];
    self.progressLayer.frame = CGRectMake(0, 0, 0, NSHeight(self.frame));
    self.progressLayer.autoresizingMask = kCALayerWidthSizable|kCALayerHeightSizable;
    
    [self.layer addSublayer:self.progressLayer];
    
    // default colors
    self.backgroundColor = [NSColor clearColor];
    self.foregroundColor = [NSColor colorWithCalibratedRed:0.081 green:0.302 blue:0.998 alpha:1];
    
    // hidden by default
    [self setAlphaValue:0];
    [self setHidden:YES];
    
    // default is to hide only at 100%
    self.hideThresholdMax = @100;
    
    return self;
}

- (void)setBackgroundColor:(NSColor *)backgroundColor
{
    _backgroundColor = [backgroundColor copy];
    
    self.layer.backgroundColor = [self.backgroundColor CGColor];
}

- (void)setForegroundColor:(NSColor *)foregroundColor
{
    _foregroundColor = [foregroundColor copy];
    
    self.progressLayer.backgroundColor = [self.foregroundColor CGColor];
}

- (void)setProgress:(NSNumber *)progress
{
    _progress = [progress copy];
    
    [self _updateProgressLayer];
}

- (void)_updateProgressLayer
{
    CGRect progressFrame = self.progressLayer.frame;
    progressFrame.size.width = ceil(NSWidth(self.frame)*(self.progress.doubleValue/100));
    
    [CATransaction begin];
    {
        CFTimeInterval duration = 0.4;
        if (progressFrame.size.width < self.progressLayer.frame.size.width) duration = 0;
        
        [CATransaction setAnimationDuration:duration];
        
        self.progressLayer.frame = progressFrame;
    }
    [CATransaction commit];
    
    if (progressFrame.size.width >= NSWidth(self.frame) ||
        progressFrame.size.width <= 0 ||
        self.progress.doubleValue >= self.hideThresholdMax.doubleValue) {
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [self setHidden:YES];
        }];
        [self.animator setAlphaValue:0];
        [CATransaction commit];
    }
    
    if (progressFrame.size.width > 0 &&
        !self.alphaValue &&
        self.progress.doubleValue < self.hideThresholdMax.doubleValue) {
        [self setHidden:NO];
        [self.animator setAlphaValue:1];
    }
}

@end
