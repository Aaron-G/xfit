//
//  MeasurableChartViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 12/14/12.
//
//

#import "MeasurableChartViewController.h"
#import "UIHelper.h"
#import "NavigationBarAutoHideSupport.h"
#import "MeasurableHelper.h"
#import "AppConstants.h"
#import "MeasurableShareDelegate.h"
#import "MeasurableChartShareDelegate.h"

@interface MeasurableChartViewController ()

@property MeasurableShareDelegate* shareDelegate;

@property BOOL listeningToDeviceOrientation;

@property NavigationBarAutoHideSupport* navigationBarAutoHideSupport;
@property IBOutlet UINavigationBar* navigationBar;

@property IBOutlet CPTGraphHostingView* graphView;
@property CPTXYGraph* graph;

- (IBAction) hide:(id)sender;
- (IBAction) share;

@end

@implementation MeasurableChartViewController

static NSDateFormatter* _measurableChartDateFormat;
static CPTMutableTextStyle* _graphDataPointTextStyle;

static NSInteger X_AXIS_TICK_SPACING = 10;
static NSInteger X_AXIS_NUMBER_LABELS = 10;
static NSInteger X_AXIS_LOWER_OFFSET = 30;
static NSInteger Y_AXIS_LOWER_OFFSET = 50;
static NSInteger GRAPH_PADDING = 10;

@synthesize measurable = _measurable;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    // Custom initialization
    self.shareDelegate = [[MeasurableChartShareDelegate alloc]initWithViewController:self withMeasurableProvider:self];
    
  }
  return self;
}

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  //Install the auto hide navigation support
  self.navigationBarAutoHideSupport = [[NavigationBarAutoHideSupport alloc] init];
  [self.navigationBarAutoHideSupport installSupportOnViewController:self withNavigationBar:self.navigationBar];
  
  /////////////////////////////////////////////////////////////
  //Chart
  self.graph = [self createGraphInGraphView:self.graphView];
}

- (void)viewWillAppear:(BOOL)animated {
  
  //Update the graph with measurable specific info
  [self updateMeasurableDetailsInGraph:self.graph];
  
  //Proceed as usual
  [super viewWillAppear:animated];
}

- (void) displayChartForMeasurable:(id<Measurable>) measurable {

  self.measurable = measurable;
  
  [UIHelper showViewController:self asModal:YES withTransitionTitle:@"To Measurable Chart"];
}

- (UIImage*) createChartImageForMeasurable:(id<Measurable>) measurable {
  
  self.measurable = measurable;
  
  return [self imageForChart];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  if(!self.listeningToDeviceOrientation) {
    [self startListeningToDeviceOrientation];
  }
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  
  if(self.listeningToDeviceOrientation) {
    [self stopListeningToDeviceOrientation];
  }
}

- (void) startListeningToDeviceOrientation {
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(orientationChanged:)
                                               name:UIDeviceOrientationDidChangeNotification
                                             object:nil];
  self.listeningToDeviceOrientation = YES;
}

- (void) stopListeningToDeviceOrientation {
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIDeviceOrientationDidChangeNotification
                                                object:nil];
  self.listeningToDeviceOrientation = NO;
}

- (void)orientationChanged:(NSNotification* )notification {
  
  UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
  
  if (UIDeviceOrientationIsPortrait(deviceOrientation)) {
    [self hide:nil];
  }
}

- (NSUInteger)supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft;
}

- (IBAction) hide:(id)sender {
  //When the hiding is animated, this method can be called multiple times
  if(![self isBeingDismissed]) {
    [[UIHelper appViewController] dismissViewControllerAnimated:YES completion:nil];
  }
}

- (NSDateFormatter* )measurableChartDateFormat {
  if(!_measurableChartDateFormat) {
    _measurableChartDateFormat = [[NSDateFormatter alloc] init];
    _measurableChartDateFormat.dateFormat = NSLocalizedString(@"chart-measurable-date-format", @"MMM dd");
  }
  return _measurableChartDateFormat;
}

- (CPTMutableTextStyle*) graphDataPointTextStyle {
  
  if (!_graphDataPointTextStyle) {
    _graphDataPointTextStyle = [[CPTMutableTextStyle alloc] init];
    _graphDataPointTextStyle.color = [CPTColor whiteColor];
  }
  return _graphDataPointTextStyle;
}

///////////////////////////////////////////////////////////
//Charting
///////////////////////////////////////////////////////////

- (NSUInteger)numberOfRecordsForPlot:(CPTPlot* )plot {
  return self.measurable.dataProvider.values.count;
}

- (NSNumber* )numberForPlot:(CPTPlot* )plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx {
  
  NSNumber* number = nil;
  
  //Looking for X value
  if(fieldEnum == CPTScatterPlotFieldX) {
    
    //Display it as a major tick
    number = [NSNumber numberWithInt:(idx * X_AXIS_TICK_SPACING)];
  }
  
  //Looking for Y value
  else {
    MeasurableDataEntry* dataEntry = [self.measurable.dataProvider.values objectAtIndex:(self.measurable.dataProvider.values.count - idx) - 1];
    number = [self.measurable.metadataProvider.unit.unitSystemConverter convertFromSystemValue:dataEntry.value];
  }
  
  return number;
}

- (CPTLayer* )dataLabelForPlot:(CPTPlot* )plot recordIndex:(NSUInteger)idx {
  
  MeasurableDataEntry* dataEntry = [self.measurable.dataProvider.values objectAtIndex:(self.measurable.dataProvider.values.count - idx) - 1];
  
  CPTTextLayer* dataPointText = [[CPTTextLayer alloc] initWithText:[self.measurable.metadataProvider.unit.valueFormatter formatValue:dataEntry.value]
                                                        style:self.graphDataPointTextStyle];
  return dataPointText;
}

- (CPTXYGraph*) createGraphInGraphView: (CPTGraphHostingView*) graphView {
  
  CPTXYGraph* graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
  graph.bounds = graphView.bounds;
  
  CPTTheme* theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
  [graph applyTheme:theme];
  graph.plotAreaFrame.cornerRadius = 0.0f;
  
  CPTMutableLineStyle* borderLineStyle = [CPTMutableLineStyle lineStyle];
  borderLineStyle.lineColor = [CPTColor whiteColor];
  borderLineStyle.lineWidth = 2.0f;
  graph.plotAreaFrame.borderLineStyle = borderLineStyle;
  
  //Title
  CPTMutableTextStyle* textStyle = [CPTMutableTextStyle textStyle];
  textStyle.color = [CPTColor lightGrayColor];
  textStyle.fontName = @"Helvetica-Bold";
  textStyle.fontSize = round(graphView.bounds.size.height/(CGFloat)25);
  graph.titleTextStyle = textStyle;
  graph.titleDisplacement = CGPointMake(0.0f, round(graphView.bounds.size.height/(CGFloat)40));
  graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
  
  //Padding
  GRAPH_PADDING = round(graphView.bounds.size.width/(CGFloat)50);
  
  graph.paddingTop = graph.titleDisplacement.y * 2;
  graph.paddingBottom = GRAPH_PADDING;
  graph.paddingLeft = GRAPH_PADDING;
  graph.paddingRight = GRAPH_PADDING;
  
  //X axis
  CPTXYAxisSet* xyAxisSet = (id)graph.axisSet;
  
  CPTXYAxis* xAxis = xyAxisSet.xAxis;
  xAxis.majorIntervalLength = [[NSNumber numberWithInt:X_AXIS_TICK_SPACING] decimalValue];
  xAxis.minorTicksPerInterval = 0;
  xAxis.majorTickLength = 7.0f;
  xAxis.axisConstraints = [CPTConstraints constraintWithLowerOffset:X_AXIS_LOWER_OFFSET];
  xAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
  
  //Y axis
  CPTXYAxis* yAxis = xyAxisSet.yAxis;
  yAxis.minorTicksPerInterval = 4;
  yAxis.minorTickLength = 5.0f;
  yAxis.majorTickLength = 7.0f;
  yAxis.axisConstraints = [CPTConstraints constraintWithLowerOffset:Y_AXIS_LOWER_OFFSET];
  
  //Plot
  CPTScatterPlot* plot = [[CPTScatterPlot alloc] initWithFrame:graph.bounds];
  plot.identifier = @"MeasurableChart";
  plot.dataSource = self;
  plot.cachePrecision = CPTPlotCachePrecisionDouble;
  plot.interpolation = CPTScatterPlotInterpolationCurved;
  
  [graph addPlot:plot];
  
  //Line Style
  CPTMutableLineStyle* plotLineStyle = [CPTMutableLineStyle lineStyle];
  plotLineStyle.lineColor = [CPTColor whiteColor];
  plotLineStyle.lineWidth = 2.0f;
  plotLineStyle.lineJoin = kCGLineJoinRound;
  plot.dataLineStyle = plotLineStyle;
  
  //Plot symbol
  CPTMutableLineStyle* symbolLineStyle = [CPTMutableLineStyle lineStyle];
  symbolLineStyle.lineColor = [CPTColor whiteColor];
  CPTPlotSymbol* plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
  plotSymbol.fill = [CPTFill fillWithColor:[CPTColor grayColor]];
  plotSymbol.lineStyle = symbolLineStyle;
  plotSymbol.size = CGSizeMake(5.0, 5.0);
  plot.plotSymbol = plotSymbol;
  
  CPTColor* areaColor = [CPTColor colorWithComponentRed:1.0 green:1.0 blue:1.0 alpha:0.6];
  CPTGradient* areaGradient = [CPTGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor clearColor]];
  areaGradient.angle = -90.0f;
  CPTFill* areaGradientFill = [CPTFill fillWithGradient:areaGradient];
  plot.areaFill = areaGradientFill;
  
  graphView.hostedGraph = graph;
  
  return graph;
}

- (void) updateMeasurableDetailsInGraph:(CPTGraph*) graph {
  
  //Title
  graph.title = self.measurable.metadataProvider.name;
  
  //Axes
  CPTXYAxisSet* xyAxisSet = (id)graph.axisSet;
  
  //X Axis
  CPTXYAxis* xAxis = xyAxisSet.xAxis;
  
  NSArray* values = self.measurable.dataProvider.values;
  NSInteger dataCount = values.count;
  
  id<UnitSystemConverter> unitSystemConverter = self.measurable.metadataProvider.unit.unitSystemConverter;
  
  //1- Figure out the data range
  NSNumber* dataMin = nil;
  NSNumber* dataMax = nil;
  
  NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"value" ascending:true];
  NSArray* sortedValues = [values sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];

  if(dataCount > 0) {
    dataMin = [unitSystemConverter convertFromSystemValue:((MeasurableDataEntry*)[sortedValues objectAtIndex:0]).value];
    dataMax = [unitSystemConverter convertFromSystemValue:((MeasurableDataEntry*)[sortedValues objectAtIndex:(dataCount-1)]).value];
  }
  
  [self createLabelsForXAxis:xAxis];
  
  //Data "width"
  CGFloat dataWidth = dataMax.floatValue-dataMin.floatValue;
  
  //Y Axis
  CPTXYAxis* yAxis = xyAxisSet.yAxis;
  CGFloat yAxisTickSpacing = [self tickSpacingForDataWidth:dataWidth];
  yAxis.majorIntervalLength = [[NSNumber numberWithInt:yAxisTickSpacing] decimalValue];
  
  //Plot space
  CPTXYPlotSpace* plotSpace = (CPTXYPlotSpace* )graph.defaultPlotSpace;

  CGFloat xRangeLocation = 0 - X_AXIS_TICK_SPACING/2;
  plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xRangeLocation)
                                                  length:CPTDecimalFromFloat(dataCount * X_AXIS_TICK_SPACING)];
  
  CGFloat yRangeLocation = dataMin.floatValue - yAxisTickSpacing/2;
  plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yRangeLocation)
                                                  length:CPTDecimalFromFloat(dataWidth + yAxisTickSpacing)];

  //CXB_TODO - this use this only if the code below is not used
  //Do not display negative numbers
  yAxis.labelingOrigin = CPTDecimalFromUnsignedInteger(0);

  
  //Change the axis visual range to hide the negative numbers/axis
  //CXB_TODO Enable this when proper alignment between y axis and x point zero is fixed 
//  xAxis.visibleRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0)
//                                                    length:CPTDecimalFromFloat(dataCount * X_AXIS_TICK_SPACING)];
//
//  yAxis.visibleRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(dataMin.floatValue - yAxisTickSpacing/4)
//                                                    length:CPTDecimalFromFloat(dataWidth + yAxisTickSpacing)];

  //Plot
  CPTScatterPlot* plot = (CPTScatterPlot*)[graph plotAtIndex:0];
  plot.areaBaseValue = CPTDecimalFromDouble(yRangeLocation);;
  
  //plotSpace.allowsUserInteraction = YES;
  
  //Reload the data
  [graph reloadData];
}

-(void)createLabelsForXAxis:(CPTAxis*) xAxis {

  NSArray* values = self.measurable.dataProvider.values;
  NSInteger dataCount = values.count;
  CGFloat labelOffset = xAxis.labelOffset + xAxis.majorTickLength / 2.0;

  NSMutableSet* xAxisLabels = [NSMutableSet set];
  NSMutableSet* xAxisTickLocations = [NSMutableSet set];
  
  NSInteger tickLocation = 0;
  BOOL shouldCreateLabel = NO;
  BOOL shouldCreateLabelForAllDataPoints = YES;
  NSInteger indexOffset = 1;
  NSInteger labelCount = 0;
  
  indexOffset = [self labelOffsetForDataCount:dataCount];
  
  if(dataCount > X_AXIS_NUMBER_LABELS) {
    shouldCreateLabelForAllDataPoints = NO;
  }
  
  for (NSUInteger i = 0; i < dataCount; i++) {
    
    if((shouldCreateLabelForAllDataPoints) ||
       ((labelCount < X_AXIS_NUMBER_LABELS) && (i%indexOffset == 0))) {
      shouldCreateLabel = YES;
    } else {
      shouldCreateLabel = NO;
    }
    
    tickLocation = ((dataCount - i) - 1) * X_AXIS_TICK_SPACING;
  
    //X axis label
    if(shouldCreateLabel) {
      MeasurableDataEntry* dataEntry = [values objectAtIndex:i];
      NSString* dateString = [self.measurableChartDateFormat stringFromDate:dataEntry.date];
      CPTAxisLabel* newLabel = [[CPTAxisLabel alloc] initWithText:dateString textStyle:xAxis.labelTextStyle];
      newLabel.offset = labelOffset;
      newLabel.tickLocation = CPTDecimalFromUnsignedInteger(tickLocation);
      [xAxisLabels addObject:newLabel];
      labelCount++;
    }
    
    //X axis ticks
    [xAxisTickLocations addObject:[NSDecimalNumber numberWithUnsignedInteger:(tickLocation)]];
  }
  
  xAxis.axisLabels = xAxisLabels;
  xAxis.majorTickLocations = xAxisTickLocations;
}

- (NSInteger) labelOffsetForDataCount:(NSInteger) dataCount {
  
  //Yes, this is pretty much 10 labels at a time, but this makes transitions better
  if(dataCount < X_AXIS_NUMBER_LABELS) {
    return 1;
  } else if (dataCount < 20) {
    return 2;
  } else if (dataCount < 30) {
    return 3;
  } else if (dataCount < 50) {
    return 5;
  } else if (dataCount < 100) {
    return 10;
  } else {
    return 100;
  }
}

- (CGFloat) tickSpacingForDataWidth:(CGFloat) dataWidth {
  
  if(dataWidth < 5) {
    return 1;
  } else if (dataWidth < 25) {
    return 5;
  } else if (dataWidth < 50) {
    return 10;
  } else if (dataWidth < 125) {
    return 25;
  } else if (dataWidth < 250) {
    return 50;
  } else {
    return 100;
  }
}

- (void)share {
  [self.shareDelegate share];
}

- (void)exportImage {
  [self imageForChart];
}

- (UIImage*) imageForChart {
  
  CGSize screenSize = [[UIScreen mainScreen] bounds].size;
  
  CGRect imageBounds = CGRectMake(0, 0, screenSize.height, screenSize.width);
  UIView* imageView = [[UIView alloc] initWithFrame:imageBounds];
  [imageView setOpaque:YES];
  [imageView setUserInteractionEnabled:NO];
  
  [self renderInView:imageView withTheme:nil];
  
  CGSize boundsSize = imageView.bounds.size;
  
  if ( UIGraphicsBeginImageContextWithOptions ) {
    UIGraphicsBeginImageContextWithOptions(boundsSize, YES, 0.0);
  }
  else {
    UIGraphicsBeginImageContext(boundsSize);
  }
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetAllowsAntialiasing(context, true);
  
  for ( UIView* subView in imageView.subviews ) {
    if ( [subView isKindOfClass:[CPTGraphHostingView class]] ) {
      CPTGraphHostingView* hostingView = (CPTGraphHostingView* )subView;
      CGRect bounds = hostingView.bounds;
      
      CGContextSaveGState(context);
      
      CGContextTranslateCTM(context, bounds.origin.x, bounds.origin.y + bounds.size.height);
      CGContextScaleCTM(context, 1.0, -1.0);
      [hostingView.hostedGraph layoutAndRenderInContext:context];
      
      CGContextRestoreGState(context);
    }
  }
  
  CGContextSetAllowsAntialiasing(context, false);
  
  CPTNativeImage* cachedImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return cachedImage;
}

-(void)renderInView:(UIView* )view withTheme:(CPTTheme* )theme {
  
  CPTGraphHostingView* graphView = [(CPTGraphHostingView* )[CPTGraphHostingView alloc] initWithFrame:view.bounds];
  
  graphView.collapsesLayers = NO;
  [graphView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
  [graphView setAutoresizesSubviews:YES];
  
  [view addSubview:graphView];
  
  //Create the graph
  CPTGraph* graph = [self createGraphInGraphView:graphView];
  
  //Update the graph with measurable info
  [self updateMeasurableDetailsInGraph:graph];
  
}

@end
