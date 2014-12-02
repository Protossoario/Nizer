//
//  ViewController.m
//  ejemplo_coreplot
//
//  Created by UTVINNOVATEAM03 on 11/20/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "BarGraphViewController.h"

CGFloat const CPDBarWidth = 0.15f;
CGFloat const CPDBarInitialX = 0.15f;

@interface BarGraphViewController () {
    NSDictionary *actividades;
}

@property (nonatomic, strong)  CPTGraphHostingView *hostView;


@end

@implementation BarGraphViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    actividades = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithDouble:15.0],@"Correr", [NSNumber numberWithDouble:20.0],@"Tarea", [NSNumber numberWithDouble:65.1],@"Dormir", nil];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self initPlot];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CPTPlotDataSource methods
-(NSUInteger) numberOfRecordsForPlot:(CPTPlot *)plot {
    return 1;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    switch (fieldEnum) {
        case CPTBarPlotFieldBarLocation:
            return @(index);
            break;
            
        case CPTBarPlotFieldBarTip:
            return [actividades objectForKey:plot.identifier];
            break;
            
        default:
            break;
    }
    return nil;
}

#pragma mark - CPTBarPlotDelegate methods
-(void)barPlot:(CPTBarPlot *)plot barWasSelectedAtRecordIndex:(NSUInteger)index {
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
    
}

-(void)initPlot
{
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}

-(void)configureHost{
    
    // 1 - Create host view
    self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
    self.hostView.allowPinchScaling = NO;
    
    // agrega como subvista al rectángulo del host
    [self.view addSubview:self.hostView];
    
}

-(float) maxTime
{
    NSArray *timeArray = [actividades allValues];
    
    CGFloat maxTime = 0.0f;
    
    for (int i = 0; i < [timeArray count]; i++) {
        if ([(NSNumber*)[timeArray objectAtIndex:i] floatValue] > maxTime) {
            maxTime = [(NSNumber*)[timeArray objectAtIndex:i] floatValue];
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
    NSString *title = @"Historial de actividades";
    graph.title = title;
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, -16.0f);
    
    // 5 - Inicializa el espacio en donde se van a dibujar las barras (plotSpace)
    CGFloat xMin = 0.0f;
    // cantidad de valores a graficar
    CGFloat xMax = [actividades count];  //cantidad de actividades
    CGFloat yMin = 0.0f;
    CGFloat yMax = [self maxTime] + 5.0f;  // should determine dynamically based on activities
    
    //A plot space using a two-dimensional cartesian coordinate system.
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    //The xRange and yRange determine the mapping between data coordinates and the screen coordinates in the plot area.
    // dependiendo de los rangos de valores en x y y se ponen los tick-mark
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xMin) length:CPTDecimalFromFloat(xMax)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yMin) length:CPTDecimalFromFloat(yMax)];
    
    // 6- Inicializa el tema para la gráfica
    [graph applyTheme:[CPTTheme themeNamed:kCPTPlainWhiteTheme]];
    
}

-(void)configurePlots
{
    // 1 - Obtiene la referencia de la gráfica
    CPTGraph *graph = self.hostView.hostedGraph;
    
    CPTMutableLineStyle *barLineStyle = [[CPTMutableLineStyle alloc] init];
    barLineStyle.lineColor = [CPTColor lightGrayColor];
    barLineStyle.lineWidth = 0.5;
    
    CGFloat barX = CPDBarInitialX;
    
    // 2 - Configura el id y color de las 3 barras
    NSArray *nameActivities = [actividades allKeys];
    for (NSString *name in nameActivities) {
        CPTBarPlot *plot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor redColor] horizontalBars:NO];
        plot.identifier = name;
        plot.dataSource = self;
        plot.delegate = self;
        plot.barWidth = CPTDecimalFromDouble(CPDBarWidth);
        plot.barOffset = CPTDecimalFromDouble(barX);
        plot.lineStyle = barLineStyle;
        [graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
        barX += CPDBarWidth;
    }
    
    // 3 - Configura el tipo y grueso de linea para dibujar el contorno de la barra
    
    //NSArray *plots = [NSArray arrayWithObjects:self.aaplPlot, self.googPlot, self.msftPlot, nil];
    
    // agrega cada una de las barras a dibujar
    /*for (CPTBarPlot *plot in plots) {
     
     }*/
    
}

-(NSArray *) stringToAxisLabel {
    NSArray *nameActivities = [actividades allKeys];
    
    NSMutableArray *labelArray = [NSMutableArray array];
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    [textStyle setFontSize:10];
    
    for (int i = 0; i < [nameActivities count]; i++)
    {
        CPTAxisLabel *axisLabel = [[CPTAxisLabel alloc] initWithText:[nameActivities objectAtIndex:i] textStyle:textStyle];
        [axisLabel setTickLocation:CPTDecimalFromInt(i + 1)];
        [axisLabel setRotation:M_PI/4];
        [axisLabel setOffset:0.1];
        [labelArray addObject:axisLabel];
    }
    
    return [NSArray arrayWithArray:labelArray];
}

-(void)configureAxes
{
    // 1 - Configura el estilo de los ejes
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor blueColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 8.0f;
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    axisLineStyle.lineColor = [[CPTColor blackColor] colorWithAlphaComponent:1];
    
    // 2 - Get the graph's axis set
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
    
    // 3 - Configure the x-axis
    axisSet.xAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    axisSet.xAxis.title = @"Actividades";
    axisSet.xAxis.titleTextStyle = axisTitleStyle;
    axisSet.xAxis.titleOffset = 10.0f;
    
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    [textStyle setFontSize:12.0f];
    [textStyle setColor:[CPTColor colorWithCGColor:[[UIColor grayColor] CGColor]]];
    
    [axisSet.xAxis setMinorTickLineStyle:nil];
    [axisSet.xAxis setLabelingPolicy:CPTAxisLabelingPolicyNone];
    [axisSet.xAxis setLabelTextStyle:textStyle];
    [axisSet.xAxis setLabelRotation:M_PI/4];
    
    NSArray *activityArray = [self stringToAxisLabel];
    [axisSet.xAxis setAxisLabels:[NSSet setWithArray:activityArray]];
    //axisSet.xAxis.axisLineStyle = axisLineStyle;
    
    // 4 - Configure the y-axis
    axisSet.yAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    axisSet.yAxis.title = @"Tiempo";
    axisSet.yAxis.titleTextStyle = axisTitleStyle;
    axisSet.yAxis.titleOffset = 5.0f;
    axisSet.yAxis.axisLineStyle = axisLineStyle;
}



@end
