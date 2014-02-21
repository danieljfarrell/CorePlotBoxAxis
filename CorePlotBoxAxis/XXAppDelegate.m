//
//  XXAppDelegate.m
//  CorePlotBoxAxis
//
//  Created by Daniel J Farrell on 21/02/2014.
//  Copyright (c) 2014 Daniel J Farrell. All rights reserved.
//

#import "XXAppDelegate.h"

@implementation XXAppDelegate

-(CPTXYAxis*) _makeDefaultAxis
{

    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace*)self.graph.defaultPlotSpace;
    
    CPTMutableLineStyle *line;
    line = [CPTMutableLineStyle lineStyle];
    line.lineWidth = 0.5;
    line.lineColor = [CPTColor blackColor];
    line.miterLimit = 2.2;
    line.lineCap = kCGLineCapButt;
    line.lineJoin = kCGLineJoinMiter;
    
    CPTMutableTextStyle *text = [[CPTMutableTextStyle alloc] init];
    text.color = [CPTColor blackColor];
    
    
    CPTXYAxis *x = [[CPTXYAxis alloc] init];
    x.coordinate                  = CPTCoordinateX;
    x.plotSpace                   = plotSpace;
    x.labelingPolicy              = CPTAxisLabelingPolicyAutomatic;
    x.labelTextStyle              = text;
    x.separateLayers              = NO;
    x.axisLineStyle               = line;
    x.majorTickLineStyle          = line;
    x.minorTickLineStyle          = line;
    x.majorTickLength             = 7.0;
    x.minorTickLength             = 3.5;
    return x;
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    // Create graph from theme
    _graph = [(CPTXYGraph *)[CPTXYGraph alloc] initWithFrame:CGRectZero];
    CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    [_graph applyTheme:theme];
    _graphHostingView.hostedGraph = _graph;
    
    _graph.paddingLeft   = 0.0;
    _graph.paddingTop    = 0.0;
    _graph.paddingRight  = 0.0;
    _graph.paddingBottom = 0.0;
    
    _graph.plotAreaFrame.paddingLeft   = 55.0;
    _graph.plotAreaFrame.paddingTop    = 40.0;
    _graph.plotAreaFrame.paddingRight  = 40.0;
    _graph.plotAreaFrame.paddingBottom = 35.0;
    
    _graph.plotAreaFrame.plotArea.fill = _graph.plotAreaFrame.fill;
    _graph.plotAreaFrame.fill          = nil;
    
    _graph.plotAreaFrame.borderLineStyle = nil;
    _graph.plotAreaFrame.cornerRadius    = 0.0;
    
    // Setup plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)self.graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0)
                                                    length:CPTDecimalFromDouble(1)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0)
                                                    length:CPTDecimalFromDouble(1)];
    
    CPTXYAxis *x = [self _makeDefaultAxis];
    x.coordinate = CPTCoordinateX;
    x.labelOffset = -35;
    x.axisConstraints = [CPTConstraints constraintWithLowerOffset:0.0];
    x.tickDirection = CPTSignPositive;
    
    CPTXYAxis *y = [self _makeDefaultAxis];
    y.coordinate = CPTCoordinateY;
    y.labelOffset = -50.0;
    y.axisConstraints = [CPTConstraints constraintWithLowerOffset:0.0];
    y.tickDirection = CPTSignPositive;
    
    
    // Problem here
    CPTXYAxis *y2 = [self _makeDefaultAxis];
    y2.coordinate = CPTCoordinateY;
    //y2.axisConstraints = [CPTConstraints constraintWithUpperOffset:0.0];
    y2.axisConstraints = [CPTConstraints constraintWithUpperOffset:0.0];
    y2.tickDirection = CPTSignNegative;
    y2.labelFormatter = nil;
    
    // Problem here ...
    CPTXYAxis *x2 = [self _makeDefaultAxis];
    x2.coordinate = CPTCoordinateX;
    // Try uncommenting this line, it causes a 1 pixel shift in the y2 axis?
    //y2.axisConstraints = [CPTConstraints constraintWithUpperOffset:1.0];
    y2.axisConstraints = [CPTConstraints constraintWithUpperOffset:0.0];
    x2.tickDirection = CPTSignPositive;
    x2.labelFormatter = nil;
    
    self.graph.axisSet.axes = @[x, y, x2, y2];
    
    // Create the main plot for the delimited data
    CPTScatterPlot *plot = [(CPTScatterPlot *)[CPTScatterPlot alloc] initWithFrame:NSZeroRect];
    plot.identifier = @"Plot";
    
    CPTMutableLineStyle *line;
    line = [CPTMutableLineStyle lineStyle];
    line.lineWidth = 0.5;
    line.lineColor = [CPTColor blackColor];
    line.miterLimit = 2.2;
    line.lineCap = kCGLineCapButt;
    line.lineJoin = kCGLineJoinMiter;
    plot.dataLineStyle = line;
    
    plot.dataSource = self;
    [_graph addPlot:plot];
    [plotSpace scaleToFitPlots:@[plot]];
    
    
}

-(NSUInteger) numberOfRecordsForPlot:(CPTPlot *)plot {
    return 2;
}

-(double) doubleForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx {
    
    if (fieldEnum == CPTScatterPlotFieldX) {
        return idx;
    }
    
    if (fieldEnum == CPTScatterPlotFieldY) {
        return idx;
    }
    
    return NAN;
}

@end
