//
//  ViewController.m
//  ejemplo_coreplot
//
//  Created by UTVINNOVATEAM03 on 11/20/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "BarGraphViewController.h"

@interface BarGraphViewController () {
    NSArray *activities;
}

@property (nonatomic, strong)  CPTGraphHostingView *hostView;


@end

@implementation BarGraphViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    activities = [[ApiBD getSharedInstance] getActivities];
    
    [self initPlot];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CPTPlotDataSource methods
-(NSUInteger) numberOfRecordsForPlot:(CPTPlot *)plot {
    return [activities count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    Activity *activity = [activities objectAtIndex:index];
    switch (fieldEnum) {
        case CPTBarPlotFieldBarLocation:
            return [NSNumber numberWithFloat:(index * ([self calculateBarWidth] + [self calculateBarOffset]))];
            break;
            
        case CPTBarPlotFieldBarTip:
            return [activity getTotalTime];
            break;
            
        default:
            break;
    }
    return nil;
}

- (CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)idx {
    CPTMutableTextStyle *textStyle = [[CPTMutableTextStyle alloc] init];
    textStyle.fontName = @"Helvetica";
    textStyle.fontSize = 8.0f;
    textStyle.color = [CPTColor blackColor];
    
    Activity *activity = [activities objectAtIndex:idx];
    CPTTextLayer *label = [[CPTTextLayer alloc] initWithText:activity.name];
    label.textStyle = textStyle;
    
    return label;
}

- (CPTFill *)barFillForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)idx {
    return [CPTFill fillWithColor:[self colorForIndex:idx]];
}

- (CPTColor *)colorForIndex:(NSUInteger)index {
    switch (index % 7) {
        case 0:
            return [CPTColor blueColor];
        case 1:
            return [CPTColor greenColor];
        case 2:
            return [CPTColor redColor];
        case 3:
            return [CPTColor cyanColor];
        case 4:
            return [CPTColor purpleColor];
        case 5:
            return [CPTColor orangeColor];
        case 6:
            return [CPTColor magentaColor];
        default:
            return [CPTColor blackColor];
    }
}

#pragma mark - CPTBarPlotDelegate methods
/*-(void)barPlot:(CPTBarPlot *)plot barWasSelectedAtRecordIndex:(NSUInteger)index {
    //1- Crear estilo
    CPTMutableTextStyle *style = [CPTMutableTextStyle textStyle];
    style.color = [CPTColor blueColor];
    style.fontSize = 8.0f;
    style.fontName = @"Helvetica-Bold";
    
    //2- Crear la anotacion
    NSNumber *time = [self numberForPlot:plot field:CPTBarPlotFieldBarTip recordIndex:index];
    if (!self.timeAnnotation) {
        NSNumber *x = [NSNumber numberWithInt:0];
        NSNumber *y = [NSNumber numberWithInt:0];
        NSArray *anchorPoint = [NSArray arrayWithObjects:x, y, nil];
        self.timeAnnotation = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:plot.plotSpace anchorPlotPoint:anchorPoint];
    }
    
    //3- crear numero y formato si es necesario
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];
    
    //4- crear text layer
    NSString *timeValue = [formatter stringFromNumber:time];
    CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:timeValue style:style];
    self.timeAnnotation.contentLayer = textLayer;
    
    //5- get plot index
    NSInteger plotIndex = 0;
    
    //6- get anchor point
    CGFloat x = index + CPDBarInitialX + (plotIndex * CPDBarWidth);
    NSNumber *anchorX = [NSNumber numberWithFloat:x];
    CGFloat y = [time floatValue] + 40.0f;
    NSNumber *anchorY = [NSNumber numberWithFloat:y];
    self.timeAnnotation.anchorPlotPoint = [NSArray arrayWithObjects:anchorX, anchorY, nil];
    
    //8 add annotation
    [plot.graph.plotAreaFrame.plotArea addAnnotation:self.timeAnnotation];
}*/

-(void)initPlot
{
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}

-(void)configureHost {
    // 1 - Create host view
    self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
    self.hostView.allowPinchScaling = NO;
    
    // agrega como subvista al rectángulo del host
    [self.view addSubview:self.hostView];
    
}

-(float) maxTime
{
    float maxTime = 0.0f;
    
    for (Activity *activity in activities) {
        float totalTime = [[activity getTotalTime] floatValue];
        if (totalTime > maxTime) {
            maxTime = totalTime;
        }
    }
    
    return maxTime;
}

-(void)configureGraph
{
    // 1 - Crea e inicializa la gráfica con los límites de la vista
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    self.hostView.hostedGraph = graph;
    
    // 2 - Inicializa los márgenes de la gráfica
    graph.paddingBottom = 100.0f;
    graph.paddingLeft  = 20.0f;
    graph.paddingTop    = 25.0f;
    graph.paddingRight  = 20.0f;
    
    // 3 - Inicializa el estilo, tamaño y color de letra
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor blackColor];
    titleStyle.fontName = @"Helvetica-Bold";
    titleStyle.fontSize = 16.0f;
    
    // 4 - Inicializa el título de la gráfica
    NSString *title = @"Total Time by Activity";
    graph.title = title;
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, -16.0f);
    
    // 5 - Inicializa el espacio en donde se van a dibujar las barras (plotSpace)
    CGFloat xMin = 0.0f;
    CGFloat xMax = 100.0f;
    CGFloat yMin = 0.0f;
    CGFloat yMax = [self maxTime];  // should determine dynamically based on activities
    
    //A plot space using a two-dimensional cartesian coordinate system.
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    //The xRange and yRange determine the mapping between data coordinates and the screen coordinates in the plot area.
    // dependiendo de los rangos de valores en x y y se ponen los tick-mark
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xMin) length:CPTDecimalFromFloat(xMax - xMin + 5)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yMin) length:CPTDecimalFromFloat(yMax - yMin + (yMax / 5.0))];
    
    // 6- Inicializa el tema para la gráfica
    [graph applyTheme:[CPTTheme themeNamed:kCPTPlainWhiteTheme]];
    
}

-(void)configurePlots
{
    // 1 - Obtiene la referencia de la gráfica
    CPTGraph *graph = self.hostView.hostedGraph;
    
    CPTMutableLineStyle *borderLineStyle = [CPTMutableLineStyle lineStyle];
    borderLineStyle.lineColor = [CPTColor clearColor];
    
    CPTBarPlot *plot = [[CPTBarPlot alloc] init];
    plot.dataSource = self;
    plot.delegate = self;
    plot.barWidth = [[NSNumber numberWithFloat:[self calculateBarWidth]] decimalValue];
    plot.barOffset = [[NSNumber numberWithFloat:[self calculateBarOffset]] decimalValue];
    plot.barCornerRadius = 5.0;
    plot.lineStyle = borderLineStyle;
    [graph addPlot:plot];
}

- (CGFloat)calculateBarWidth {
    int numberOfActivities = [activities count];
    return (100.0 - numberOfActivities * [self calculateBarOffset]) / numberOfActivities;
}

- (CGFloat)calculateBarOffset {
    return 10.0f;
}

-(void)configureAxes
{
    // 1 - Configura el estilo de los ejes
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor blackColor];
    axisTitleStyle.fontName = @"Helvetica";
    axisTitleStyle.fontSize = 14.0f;
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 1.0f;
    axisLineStyle.lineColor = [CPTColor blackColor];
    
    // 2 - Get the graph's axis set
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
    
    axisSet.xAxis.title = @"Activities";
    axisSet.xAxis.titleTextStyle = axisTitleStyle;
    axisSet.xAxis.titleOffset = 5.0f;
    axisSet.xAxis.labelTextStyle = axisTitleStyle;
    axisSet.xAxis.labelOffset = 3.0f;
    
    axisSet.xAxis.axisLineStyle = axisLineStyle;
    /*axisSet.xAxis.majorTickLineStyle = axisLineStyle;
    axisSet.xAxis.majorIntervalLength = CPTDecimalFromFloat(5.0f);
    axisSet.xAxis.majorTickLength = 7.0f;
    axisSet.xAxis.minorTickLineStyle = axisLineStyle;
    axisSet.xAxis.minorTicksPerInterval = 1;
    axisSet.xAxis.minorTickLength = 5.0f;*/

    axisSet.yAxis.title = @"Time";
    axisSet.yAxis.titleTextStyle = axisTitleStyle;
    axisSet.yAxis.titleOffset = 5.0f;
    axisSet.yAxis.labelTextStyle = axisTitleStyle;
    axisSet.yAxis.labelOffset = 3.0f;
    
    
    axisSet.yAxis.axisLineStyle = axisLineStyle;
    axisSet.yAxis.majorTickLineStyle = axisLineStyle;
    axisSet.yAxis.majorIntervalLength = CPTDecimalFromFloat(60.0f);
    axisSet.yAxis.majorTickLength = 5.0f;
    axisSet.yAxis.minorTickLineStyle = axisLineStyle;
    axisSet.yAxis.minorTicksPerInterval = 1;
    axisSet.yAxis.minorTickLength = 3.0f;
}

@end
