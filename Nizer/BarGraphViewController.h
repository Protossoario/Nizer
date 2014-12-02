//
//  ViewController.h
//  ejemplo_coreplot
//
//  Created by UTVINNOVATEAM03 on 11/20/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlotHeaders/CorePlot-CocoaTouch.h"
#import "ApiBD.h"
#import "Activity.h"
#import "TimeLog.h"

@interface BarGraphViewController : UIViewController <CPTBarPlotDataSource, CPTBarPlotDelegate>

@property (nonatomic, strong) CPTBarPlot *actividad;
@property (nonatomic, strong) CPTPlotSpaceAnnotation *timeAnnotation;

@end
