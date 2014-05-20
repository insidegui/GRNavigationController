//
//  COBarProgressView.h
//  Countries (demo app)
//
//  Created by Guilherme Rambo on 20/05/14.
//  Copyright (c) 2014 Guilherme Rambo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GRBarProgressView : NSView

@property (nonatomic, copy) NSColor *foregroundColor;
@property (nonatomic, copy) NSColor *backgroundColor;

/**
 Current progress, value between 0 and 100
 */
@property (nonatomic, copy) NSNumber *progress;

/**
 The point at which the progress bar disappears
 Default is 100
 */
@property (nonatomic, copy) NSNumber *hideThresholdMax;

@end
