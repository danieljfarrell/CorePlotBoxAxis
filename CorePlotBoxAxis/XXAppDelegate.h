//
//  XXAppDelegate.h
//  CorePlotBoxAxis
//
//  Created by Daniel J Farrell on 21/02/2014.
//  Copyright (c) 2014 Daniel J Farrell. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CorePlot/CorePlot.h>

@interface XXAppDelegate : NSObject <NSApplicationDelegate, CPTPlotDataSource>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet CPTGraphHostingView *graphHostingView;
@property (strong) CPTXYGraph *graph;

@end
