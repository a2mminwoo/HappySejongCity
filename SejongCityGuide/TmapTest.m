//
//  TmapTest.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 30..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "TmapTest.h"
#import <QuartzCore/QuartzCore.h>
#import "TMapGpsManager.h"

// 앱등록 및 키발급 -> https://developers.skplanetx.com/develop/
#define TMAP_APPKEY             @"20f38848-f6ee-3f50-88e1-33fbc259cb14"

// TMap invoke-TMap App실행  API <TMapTapi> 사용시 필요합니다.
#define TMAP_BIZAPPID           @"INSERT YOUR KEY..."


static CGFloat x = 10;
static CGFloat y = 10;

NSMutableArray* __objectIDs = nil;

void Alert(NSString* message) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:@"확인"
                                           otherButtonTitles:nil] ;
    [alert show];
}

@interface TmapTest (Private)
- (void)initializeSubViews:(CGRect)rect;
- (void)addButtonWithTitle:(NSString*)title target:(UIView*)view action:(SEL)selector;
@end

@implementation TmapTest
{
    UIView*     _subBgView;
    
    NSMutableArray* _lineIDs;
    NSMutableArray* _circleIDs;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)])
    {
        CGFloat screenMaxLength = MAX([[UIScreen mainScreen] nativeBounds].size.width, [[UIScreen mainScreen] nativeBounds].size.height);
        NSLog(@"screenMaxLength :%f", screenMaxLength);
        
        CGFloat height = [[UIScreen mainScreen] bounds].size.height;
        NSLog(@"height :%f", height);
        
        CGFloat maxSize = MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width);
        NSLog(@"maxSize :%f", maxSize);
        
        UIScreen *mainScreen = [UIScreen mainScreen];
        NSLog(@"Screen bounds: %@, Screen resolution: %@, scale: %f, nativeScale: %f",
              NSStringFromCGRect(mainScreen.bounds), mainScreen.coordinateSpace, mainScreen.scale, mainScreen.nativeScale);
    }
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    CGFloat width = self.view.bounds.size.width - 10*2;
    CGFloat height = self.view.bounds.size.height * 4 / 7;
    height  = ceilf(height);
    
    _mapView = [[TMapView alloc] initWithFrame:CGRectMake(10, 10, width, height)];
    
    [_mapView setDelegate:self];
    [_mapView setGpsManagersDelegate:self];
    
    // API KEY
    // 발급 받은 Key 설정
    [_mapView setSKPMapApiKey:TMAP_APPKEY];
    
    /*
     * TMapTapi 사용시  BizAppID를 호출 하셔야 합니다.
     */
    [_mapView setBizAppID:TMAP_BIZAPPID];
    
    [self.view addSubview:_mapView];
    
    CGFloat yPos = _mapView.frame.origin.y + _mapView.frame.size.height + 5;
    
    CGRect buttonsFrame = CGRectMake(0, yPos, self.view.bounds.size.width, self.view.bounds.size.height - yPos - 5);
    [self initializeSubViews:buttonsFrame];
    
}


#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect mapviewFrame;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    CGFloat width = screenRect.size.width;
    CGFloat height = screenRect.size.height;
    
    switch(toInterfaceOrientation)
    {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            screenRect.size.height = height - 20;
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            screenRect.size.width = height;
            screenRect.size.height = width - 20;
            break;
    }
    
    width = screenRect.size.width - 10*2;
    height = screenRect.size.height * 4 / 7;
    mapviewFrame = CGRectMake(10, 10, width, height);
    
    [_mapView resizeWidthFrame:mapviewFrame];
    
    
    CGFloat yPos = mapviewFrame.origin.y + mapviewFrame.size.height + 5;
    
    CGRect buttonsFrame = CGRectMake(0, yPos, screenRect.size.width, screenRect.size.height - yPos - 5);
    [self initializeSubViews:buttonsFrame];
}
#pragma mark - TMapViewDelegate (TMapApiKey)

// setSKPMapApiKey: 성공시 발생하는 callback
- (void)SKPMapApikeySucceed
{
    NSLog(@"SKPMapApikeySucceed");
}

// setSKPMapApiKey: 실패시 발생하는 callback
- (void)SKPMapApikeyFailed:(NSError*)error
{
    NSLog(@"SKPMapApikeyFailed : %@", [error localizedDescription]);
}

#pragma mark - TMapViewDelegate
- (void)onClick:(TMapPoint *)TMP
{
    NSLog(@"onClick: %@", TMP);
}

- (void)onLongClick:(TMapPoint*)TMP
{
    NSLog(@"onLongClick: %@", TMP);
    [self revGeoRevInfos:TMP];
}

- (void)onCustomObjectClick:(TMapObject*)obj
{
    if([obj isMemberOfClass:[TMapMarkerItem class]])
    {
        NSLog(@"TMapMarkerItem clicked:%@", obj);
    }
}

- (void)onCustomObjectLongClick:(TMapObject*)obj
{
    if([obj isMemberOfClass:[TMapMarkerItem class]])
    {
        NSLog(@"TMapMarkerItem clicked:%@", obj);
    }
}

- (void)onCustomObjectClick:(TMapObject*)obj screenPoint:(CGPoint)point
{
    if([obj isMemberOfClass:[TMapMarkerItem class]])
    {
        NSLog(@"onCustomObjectClick :%@ screenPoint:{%f, %f}", obj, point.x, point.y);
    }
}

- (void)onCustomObjectLongClick:(TMapObject*)obj screenPoint:(CGPoint)point
{
    if([obj isMemberOfClass:[TMapMarkerItem class]])
    {
        NSLog(@"onCustomObjectLongClick :%@ screenPoint:{%f, %f}", obj, point.x, point.y);
    }
}

- (void)onDidScrollWithZoomLevel:(NSInteger)zoomLevel centerPoint:(TMapPoint*)mapPoint
{
    //NSLog(@"zoomLevel: %d point: %@", zoomLevel, mapPoint);
}

- (void)onDidEndScrollWithZoomLevel:(NSInteger)zoomLevel centerPoint:(TMapPoint*)mapPoint
{
    NSLog(@"zoomLevel: %d point: %@", (int)zoomLevel, mapPoint);
    //    NSLog(@"trackingMode %d", [_mapView getIsTracking]);
}

- (void)onCalloutRightbuttonClick:(TMapMarkerItem*)markerItem
{
    NSLog(@"markerItem: %@", [markerItem getID]);
}

- (void)onClusteringMarkerClick:(NSArray *)markerItems screenPoint:(CGPoint)point
{
    NSLog(@"markerItems : %@ {%f, %f}", markerItems, point.x, point.y);
}

- (UIView*)mapView:(TMapView *)mapView viewForCalloutView:(TMapMarkerItem2*)markerItem
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) ] ;
    [view setBackgroundColor:[UIColor redColor]];
    return view;
    
}

#pragma mark - TMapGpsManagerDelegate
- (void)locationChanged:(TMapPoint*)newTmp
{
    NSLog(@"%@", newTmp);
}

- (void)headingChanged:(double)heading
{
    //NSLog(@"%f", heading);
}

#pragma mark -

- (void)initializeSubViews:(CGRect) rect
{
    x = 10, y=10;
    
    if (_subBgView)
    {
        [_subBgView removeFromSuperview];
        _subBgView = nil;
    }
    
    _subBgView = [[UIView alloc] initWithFrame:rect];
    [_subBgView setBackgroundColor:[UIColor whiteColor]];
    [_subBgView.layer setBorderColor:[UIColor blackColor].CGColor];
    [_subBgView.layer setBorderWidth:3];
    
    [self addStaticButtonWithTitle:@"+" target:_subBgView action:@selector(zoomIn)];
    [self addStaticButtonWithTitle:@"-" target:_subBgView action:@selector(zoomOut)];
    [self addStaticButtonWithTitle:@"10" target:_subBgView action:@selector(zoomLevel10)];
    
    [self.view addSubview:_subBgView];
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, rect.size.width, rect.size.height - 35)] ;
    [scrollView.layer setBorderColor:[UIColor blackColor].CGColor];
    [scrollView.layer setBorderWidth:2];
    [scrollView setContentSize:CGSizeMake(rect.size.width, 500)];
    [_subBgView addSubview:scrollView];
    
    [self addButtonWithTitle:@"TMapAppInfo" target:scrollView action:@selector(TMapAppInfo)];
    
    // TMap App Launch APIs
    [self addButtonWithTitle:@"경로" target:scrollView action:@selector(route)];
    [self addButtonWithTitle:@"경로 상세" target:scrollView action:@selector(route2)];
    [self addButtonWithTitle:@"지도보기" target:scrollView action:@selector(mapview)];
    [self addButtonWithTitle:@"통합검색" target:scrollView action:@selector(search)];
    [self addButtonWithTitle:@"집으로" target:scrollView action:@selector(home)];
    [self addButtonWithTitle:@"회사로" target:scrollView action:@selector(company)];
    
    
    [self addButtonWithTitle:@"풍선뷰 마커" target:scrollView action:@selector(addCallOutMarker)];
    
    [self separateButtonArea:@"--------------------------------------------------------------------------------"];
    
    [self addButtonWithTitle:@"Logo Pos" target:scrollView action:@selector(logoPos)];
    
    [self addButtonWithTitle:@"ZoomToSpan" target:scrollView action:@selector(ZoomToSpan)];
    
    [self addButtonWithTitle:@"ZoomToTMapPoint" target:scrollView action:@selector(ZoomToTMapPoint)];
    
    [self separateButtonArea:@"--------------------------------------------------------------------------------"];
    
    [self addButtonWithTitle:@"구름위성" target:scrollView action:@selector(showWeatherOverlay)];
    
    [self addButtonWithTitle:@"구름 변경" target:scrollView action:@selector(changeImage)];
    
    [self addButtonWithTitle:@"구름 삭제" target:scrollView action:@selector(removeWeatherOverlay)];
    
    [self separateButtonArea:@"--------------------------------------------------------------------------------"];
    
    [self addButtonWithTitle:@"capture" target:scrollView action:@selector(capture)];
    
    [self addButtonWithTitle:@"currentZoom" target:scrollView action:@selector(getZoomLevel)];
    
    [self addButtonWithTitle:@"clear" target:scrollView action:@selector(clearObjects)];
    
    [self separateButtonArea:@"--------------------------------------------------------------------------------"];
    
    [self addButtonWithTitle:@"SD" target:scrollView action:@selector(tileSourceSD)];
    
    [self addButtonWithTitle:@"SD+EX" target:scrollView action:@selector(tileSourceEX)];
    
    [self addButtonWithTitle:@"HD" target:scrollView action:@selector(tileSourceHD)];
    
    // trafficMode
    [self addButtonWithTitle:@"trafficInfo" target:scrollView action:@selector(trafficInfo)];
    
    [self addButtonWithTitle:@"bicycleMode" target:scrollView action:@selector(bicycleMode)];
    
    [self addButtonWithTitle:@"bicycleFacilityMode" target:scrollView action:@selector(bicycleFacilityMode)];
    
    [self addButtonWithTitle:@"removeMap" target:scrollView action:@selector(removeMapView)];
    
    [self addButtonWithTitle:@"reloadMap" target:scrollView action:@selector(reloadMapView)];
    
    [self separateButtonArea:@"--------------------------------------------------------------------------------"];
    
    [self addButtonWithTitle:@"category" target:scrollView action:@selector(category)];
    // RP
    [self addButtonWithTitle:@"rp" target:scrollView action:@selector(rp)];
    
    [self addButtonWithTitle:@"rpPedestrian" target:scrollView action:@selector(rpPedestrian)];
    
    [self addButtonWithTitle:@"rpBike" target:scrollView action:@selector(rpBike)];
    
    [self addButtonWithTitle:@"pathDataAll" target:scrollView action:@selector(pathDataAll)];
    
    //
    [self addButtonWithTitle:@"fullPath" target:scrollView action:@selector(fullPath)];
    
    [self addButtonWithTitle:@"timeMachine" target:scrollView action:@selector(timeMachine)];
    
    [self addButtonWithTitle:@"poi" target:scrollView action:@selector(poiTest)];
    
    // poiCode
    [self addButtonWithTitle:@"poiCode(주유)" target:scrollView action:@selector(poiCode)];
    
    // reversegeocoding
    [self addButtonWithTitle:@"revGeo" target:scrollView action:@selector(revGeoTest)];
    //
    [self separateButtonArea:@"--------------------------------------------------------------------------------"];
    
    [self addButtonWithTitle:@"circle" target:scrollView action:@selector(addCircle)];
    
    [self addButtonWithTitle:@"rmvCircle" target:scrollView action:@selector(rmvCircle)];
    
    [self addButtonWithTitle:@"PolyLine" target:scrollView action:@selector(addPolyLine)];
    
    [self addButtonWithTitle:@"removeLine" target:scrollView action:@selector(removePolyLine)];
    
    [self addButtonWithTitle:@"LineDash" target:scrollView action:@selector(addPolyLineDash)];
    
    [self addButtonWithTitle:@"LineRedraw" target:scrollView action:@selector(addPolyLineRedraw)];
    
    [self addButtonWithTitle:@"Polygon" target:scrollView action:@selector(addPolygon)];
    
    [self addButtonWithTitle:@"marker" target:scrollView action:@selector(addMarker)];
    
    [self addButtonWithTitle:@"marker2" target:scrollView action:@selector(addMarker2)];
    
    [self addButtonWithTitle:@"changeIcon" target:scrollView action:@selector(changeIcon)];
    
    [self addButtonWithTitle:@"showCallOutView" target:scrollView action:@selector(showCallOutView)];
    
    [self addButtonWithTitle:@"backMacker" target:scrollView action:@selector(backMacker)];
    
    [self addButtonWithTitle:@"frontMarker" target:scrollView action:@selector(frontMarker)];
    
    [self addButtonWithTitle:@"remove marker" target:scrollView action:@selector(removeMarker)];
    
    [self separateButtonArea:@"--------------------------------------------------------------------------------"];
    
    // tracking
    [self addButtonWithTitle:@"tracking" target:scrollView action:@selector(trackingTest)];
    
    // compassMode
    [self addButtonWithTitle:@"compassMode" target:scrollView action:@selector(compassMode)];
    
    // sightMode
    [self addButtonWithTitle:@"sightMode" target:scrollView action:@selector(sightMode)];
    
    // default or navi position
    [self addButtonWithTitle:@"position" target:scrollView action:@selector(mapPositionTypeTest)];
    
    [self separateButtonArea:@"--------------------------------------------------------------------------------"];
    
    [self addButtonWithTitle:@"setIcon" target:scrollView action:@selector(setIconTest)];
    
    [self addButtonWithTitle:@"iconVisible" target:scrollView action:@selector(iconVisibleTest)];
    
    [self addButtonWithTitle:@"isvalid" target:scrollView action:@selector(isValidCoord)];
    
    [self addButtonWithTitle:@"poiCode" target:scrollView action:@selector(poiCode)];
    
    [self separateButtonArea:@"--------------------------------------------------------------------------------"];
    
    [self addButtonWithTitle:@"GPS_ON" target:scrollView action:@selector(GPS_ON)];
    
    [self addButtonWithTitle:@"GPS_OFF" target:scrollView action:@selector(GPS_OFF)];
    
    
}

const CGFloat leftMarzine = 10;
const CGFloat buttonWidth = 95;
const CGFloat buttonHeight = 30;
const CGFloat gap = 3;
static BOOL FLAG = NO;
- (void)separateButtonArea:(NSString*)temp
{
    if (x != leftMarzine) {
        y = y + buttonHeight + gap * 2;
        x = leftMarzine;
    } else {
        y = y + gap;
    }
    
    FLAG = !FLAG;
}

- (UIButton*)buttonForTest
{
    UIButton* button = nil;
    if (FLAG) {
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[button setBackgroundColor:[UIColor redColor]];
    } else {
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //[button setBackgroundColor:[UIColor blueColor]];
    }
    
    return button;
}

- (void)addButtonWithTitle:(NSString*)title target:(UIView*)view action:(SEL)selector
{
    UIButton* button = [self buttonForTest];
    [button setFrame:CGRectMake(x, y, buttonWidth, buttonHeight)];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    // calc next position
    x = x + buttonWidth + gap;
    if (x+ buttonWidth > view.frame.size.width) {
        x = leftMarzine;
        y = y + buttonHeight + gap;
    }
    UIScrollView* scrollView = (UIScrollView*)view;
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, y + buttonHeight + gap)];
}

- (void)addStaticButtonWithTitle:(NSString*)title target:(UIView*)view action:(SEL)selector
{
    static CGFloat x = 10;
    if (x > 120) {
        x = 10;
    }
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [button setFrame:CGRectMake(x, 5, 30, 30)];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    x = x + 40;
}

#define ARC4RANDOM_MAX 0x100000000

- (CLLocationCoordinate2D)randomCoordinate
{
    double latitude = ((double)arc4random() / ARC4RANDOM_MAX) * (37.575113-37.483086) + 37.483086;
    double longitude = ((double)arc4random() / ARC4RANDOM_MAX) * (127.027359-126.878357) + 126.878357;
    
    latitude = MIN(37.575113, latitude);
    latitude = MAX(37.483086, latitude);
    
    longitude = MIN(127.027359, longitude);
    longitude = MAX(126.878357, longitude);
    
    return CLLocationCoordinate2DMake(latitude, longitude);
}

- (TMapPoint*)randomTMapPoint
{
    return [[TMapPoint alloc] initWithCoordinate:[self randomCoordinate]];
}


#pragma mark - Button Actions


- (void)pathDataAll
{
    TMapPathData* pathData = [[TMapPathData alloc]init];
    // 37.507105, 126.903076
    // 37.403609, 126.916286
    
    // https://developers.skplanetx.com/apidoc/kor/t-map/course-guide/geojson/
    
    NSDictionary* dic = [pathData findPathDataAllWithStartPoint:[TMapPoint mapPointWithCoordinate:CLLocationCoordinate2DMake(37.403609, 126.916286)] endPoint:[TMapPoint mapPointWithCoordinate:CLLocationCoordinate2DMake(37.507105, 126.903076)]];
    NSLog(@"%@", dic);
    NSString *documentdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentdir stringByAppendingString:@"/rp.plist"];
    
    [dic writeToFile:filePath atomically:YES];

    
}

- (void)zoomIn
{
    [_mapView zoomIn];
}

- (void)zoomOut
{
    [_mapView zoomOut];
}

- (void)zoomLevel10
{
    [_mapView setZoomLevel:10];
}

- (void)getZoomLevel
{
    Alert([NSString stringWithFormat:@"zoomLevel: %d", (int)[_mapView getZoomLevel]]);
}

- (void)addCircle
{
    if (_circleIDs == nil) {
        _circleIDs = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
    TMapCircle *circle = [[TMapCircle alloc] init];
    
    TMapPoint *point1 = [self randomTMapPoint];
    [circle setCenterPoint:point1];
    [circle setCircleRadius:200];
    [circle setCircleLineColor:[UIColor redColor].CGColor];
    [circle setCircleLineWidth:5];
    [circle setCircleAreaColor:CGColorCreateCopyWithAlpha([[UIColor blueColor] CGColor], 0.2)];
    
    // 반지름 표시
    static BOOL radiusHidden = YES;
    [circle setRadiusVisible:radiusHidden];
    radiusHidden = !radiusHidden;
    
    static int objIdx = 0;
    NSString* circleID = [NSString stringWithFormat:@"circle%d", objIdx++];
    [_circleIDs addObject:circleID];
    
    [_mapView addCustomObject:circle ID:circleID];
    
}

- (void)rmvCircle
{
    NSString* circleID = [_circleIDs lastObject];
    
    if (circleID) {
        [_mapView removeTMapCircleID:circleID];
    }
    
    [_circleIDs removeLastObject];
}



- (void)addPolyLine
{
    if (_lineIDs == nil) {
        _lineIDs = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
    static int index = 0;
    
    NSString *ID = [NSString stringWithFormat:@"line%d", index];
    [_lineIDs addObject:ID];
    
    TMapPolyLine *polyLine = [[TMapPolyLine alloc] init];
    [polyLine setLineColor:[[UIColor blueColor] CGColor]];
    
    [polyLine setLineWidth:10.0];
    
    for(int i=0; i<5; i++)
    {
        TMapPoint *point1 = [self randomTMapPoint];
        [polyLine addLinePoint:point1];
    }
    
    [_mapView addCustomObject:polyLine ID:ID];
    index ++;
}

- (void)removePolyLine
{
    NSString* objectID = [_lineIDs lastObject];
    if (objectID) {
        [_mapView removeTMapPolyLineID:objectID];
        
        [_lineIDs removeLastObject];
    }
}

//*
- (void)addPolyLineDash
{
    if (_lineIDs == nil) {
        _lineIDs = [[NSMutableArray alloc] initWithCapacity:10];
    }
    // 안양역 37.401933, 126.922651
    CLLocationCoordinate2D coordinate1 = CLLocationCoordinate2DMake(37.401933, 126.922651);
    // 삼성역 37.508824, 127.063011
    CLLocationCoordinate2D coordinate2 = CLLocationCoordinate2DMake(37.508824, 127.063011);
    // 신도림역 37.508997, 126.891581
    CLLocationCoordinate2D coordinate3 = CLLocationCoordinate2DMake(37.508997, 126.891581);
    // 월드컵경기장 37.568375, 126.897218
    CLLocationCoordinate2D coordinate4 = CLLocationCoordinate2DMake(37.568375, 126.897218);
    
    CLLocationCoordinate2D coordinates[] = {coordinate1, coordinate2, coordinate3, coordinate4};
    
    TMapPolyLine *polyLine = [[TMapPolyLine alloc] init];
    [polyLine setLineColor:[UIColor blueColor].CGColor];
    [polyLine setLineWidth:4.0];
    
    // Dash 설정
    [polyLine setLineDashPattern:[NSArray arrayWithObjects:
                                  [NSNumber numberWithInt:10],
                                  [NSNumber numberWithInt:8],nil]];
    
    for(int i=0; i<4; i++)
    {
        TMapPoint *point = [[TMapPoint alloc] initWithCoordinate:coordinates[i]];
        [polyLine addLinePoint:point];
    }
    
    static int  index = 0;
    NSString* lineID = [NSString stringWithFormat:@"polyLine%d", index++];
    [_mapView addTMapPolyLineID:lineID Line:polyLine];
    [_lineIDs addObject:lineID];
}

- (void)addPolyLineRedraw
{
    for(NSString* lineID in _lineIDs)
    {
        TMapPolyLine* polyLine = [_mapView getPolyLineFromID:lineID];
        
        
        [polyLine setLineWidth:4.0];
        [polyLine setLineDashPattern:[NSArray arrayWithObjects:
                                      [NSNumber numberWithInt:10],
                                      [NSNumber numberWithInt:8],nil]];
        [polyLine setLineColor:[UIColor redColor].CGColor];
    }
}

// static int __markerID = 0;
NSMutableArray* __markerIDs =  nil;

- (void)addMarker
{
    if (__markerIDs == nil) {
        __markerIDs = [[NSMutableArray alloc] initWithCapacity:10];
    }
    NSArray* images = [NSArray arrayWithObjects:
                       //[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.sk.co.kr/Image/common/logo.gif"]]],
                       [UIImage imageNamed:@"start.png"],
                       //[UIImage imageNamed:@"end.png"],
                       nil];
    
    static int index = 0;
    
    // 중복아이디 테스트
    //NSString *ID = [NSString stringWithFormat:@"marker%d", 1];
    NSString *ID = [NSString stringWithFormat:@"marker%d", index];
    [__markerIDs addObject:ID];
    
    UIImage* image = [images objectAtIndex:index % [images count]];
    
    TMapPoint* mapPoint = [[TMapPoint alloc] initWithCoordinate:[self randomCoordinate]];
    //TMapPoint* mapPoint = [[[TMapPoint alloc] initWithCoordinate:CLLocationCoordinate2DMake(37.566474, 126.985022)] autorelease];
    TMapMarkerItem* marker1 = [[TMapMarkerItem alloc] init];
    [marker1 setTMapPoint:mapPoint];
    [marker1 setIcon:image anchorPoint:CGPointMake(0.5, 1.0)];
    [marker1 setCanShowCallout:YES];
    [marker1 setCalloutTitle:@"CallOut 타이틀"];
    [marker1 setCalloutSubtitle:@"CallOut 서브타이틀"];
    [marker1 setCalloutLeftImage:[UIImage imageNamed:@"end.png"]];
    [marker1 setCalloutRightButtonImage:[UIImage imageNamed:@"accessory_detail.png"]];
    [marker1 setName:[NSString stringWithFormat:@"name %@", ID]];
    
    [marker1 setEnableClustering:YES];
    
    //    [_mapView addTMapMarkerItemID:ID Marker:marker1];
    // 애니매이션
    [_mapView addTMapMarkerItemID:ID Marker:marker1 animated:YES];
    index ++;
}

# define MARKER_ANI @"aniMarker"
- (void)addMarker2
{
    NSMutableArray* aniImages = [NSMutableArray arrayWithCapacity:8];
    for (int i=0; i <8; i++)
    {
        [aniImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"bluegem_ani_%02d.png", i+1]]];
    }
    
    TMapPoint* mapPoint = [[TMapPoint alloc] initWithCoordinate:CLLocationCoordinate2DMake(37.566474, 126.985022)];
    TMapMarkerItem2* marker = [[TMapMarkerItem2 alloc] init];
    [marker setTMapPoint:mapPoint];
    
    [marker setAnimationIcons:aniImages anchorPoint:CGPointMake(0.5, 0.5)];
    [marker setCanShowCallout:YES];
    //[marker setAutoCalloutVisible:YES];
    [_mapView addTMapMarkerItemID:MARKER_ANI markerItem2:marker];
}

- (void)changeIcon
{
    TMapMarkerItem2* marker = [_mapView getMarketItem2FromID:MARKER_ANI];
    
    NSMutableArray* aniImages = [NSMutableArray arrayWithCapacity:8];
    for (int i=0; i <8; i++)
    {
        [aniImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"redgem_ani_%02d.png", i+1]]];
    }
    
    [marker setAnimationIcons:aniImages anchorPoint:CGPointMake(0.5, 0.5)];
    [marker startAnimation];
}

- (void)showCallOutView
{
    // 특정 마커의 CallOutView 함수호출로 나오도록
    [_mapView showCallOutViewWithMarkerItemID:@"marker3"];
}

- (void)removeMarker
{
    NSString* markerID = [__markerIDs lastObject];
    if (markerID) {
        [_mapView removeTMapMarkerItemID:markerID];
        
        [__markerIDs removeLastObject];
    }
}

- (void)backMacker
{
    TMapMarkerItem* item = [_mapView getMarketItemFromID:@"marker2"];
    
    if (item) {
        [_mapView sendMarkerToBack:item];
    }
}

- (void)frontMarker
{
    TMapMarkerItem* item = [_mapView getMarketItemFromID:@"marker2"];
    
    if (item) {
        [_mapView bringMarkerToFront:item];
    }
}

- (void)addPolygon
{
    TMapPolygon *polygon = [[TMapPolygon alloc] init];
    [polygon setPolygonAreaColor:CGColorCreateCopyWithAlpha([[UIColor redColor] CGColor], 0.2)];
    for(int i=0; i<5; i++)
    {
        TMapPoint *point1 = [self randomTMapPoint];
        [polygon addPolygonPoint:point1];
    }
    static int index = 0;
    [_mapView addCustomObject:polygon ID:[NSString stringWithFormat:@"polygon%d", index++]];
}

- (void)clearObjects
{
    [_mapView clearCustomObjects];
}

- (void)tileSourceSD
{
    [_mapView setTMapTileType:NORMALTILE];
    NSLog(@"%d", _mapView.tmapTileType);
}

- (void)tileSourceEX
{
    [_mapView setTMapTileType:EXTENSIONTILE];
    NSLog(@"%d", _mapView.tmapTileType);
}

- (void)tileSourceHD
{
    [_mapView setTMapTileType:HDTILE];
    NSLog(@"%d", _mapView.tmapTileType);
}

- (void)removeMapView {
    [_mapView removeFromSuperview];
    _mapView = nil;
}

- (void)reloadMapView {
    if (_mapView == nil) {
        CGFloat width = self.view.bounds.size.width - 10*2;
        CGFloat height = self.view.bounds.size.height * 4 / 7;
        height  = ceilf(height);
        _mapView = [[TMapView alloc] initWithFrame:CGRectMake(10, 10, width, height)];
        [_mapView setSKPMapApiKey:TMAP_APPKEY];
        [_mapView setDelegate:self];
        [_mapView setGpsManagersDelegate:self];
        
        [self.view addSubview:_mapView];
    }
}

- (void)category
{
    TMapPathData* path = [[TMapPathData alloc] init];
    
    //업종코드
    NSArray* result = [path getBizCategory];
    //NSLog(@"result:%@", result);
    
    int cnt = 0;
    for(BizCategory *biz in result)
    {
        NSLog(@"%d:%@", cnt++, [biz toString]);
    }
    

}

- (void)rp
{
    TMapPathData* path = [[TMapPathData alloc] init];
    
    TMapPoint* startPoint = [_mapView getCenterPoint];
    //SKT 타워 37.566411, 126.985173
    TMapPoint* endPoint = [[TMapPoint alloc] initWithLon:126.985173 Lat:37.566411];
    
    TMapPolyLine *polyLine = [path findPathDataFrom:startPoint to:endPoint];
    
    if (polyLine == nil) {
        return;
    }
    
    if ([[polyLine getLinePoint] count] == 0)
        return;
    //*
    // 출발, 도착 아이콘 설정
    TMapPoint* start = [[polyLine getLinePoint] objectAtIndex:0];
    TMapPoint* end = [[polyLine getLinePoint] lastObject];
    TMapMarkerItem* startMarkerItem = [[TMapMarkerItem alloc]initWithTMapPoint:start];
    [startMarkerItem setIcon:[UIImage imageNamed:@"start.png"] anchorPoint:CGPointMake(0.4, 1.0)];
    TMapMarkerItem* endMarkerItem = [[TMapMarkerItem alloc]initWithTMapPoint:end];
    [endMarkerItem setIcon:[UIImage imageNamed:@"end.png"]anchorPoint:CGPointMake(0.5, 1.0)];
    [_mapView setTMapPathIconStart:startMarkerItem End:endMarkerItem];
    //*/
    // 라인
    if(polyLine)
    {
        [_mapView addTMapPath:polyLine];
    }
}

- (void)rpPedestrian
{
    TMapPathData* path = [[TMapPathData alloc] init];
    
    TMapPoint* startPoint = [_mapView getCenterPoint];
    //SKT 타워 37.566411, 126.985173
    TMapPoint* endPoint = [[TMapPoint alloc] initWithLon:126.985173 Lat:37.566411];
    
    TMapPolyLine *polyLine = [path findPathDataWithType:PEDESTRIAN_PATH startPoint:startPoint endPoint:endPoint];
    
    if (polyLine == nil) {
        return;
    }
    
    if ([[polyLine getLinePoint] count] == 0)
        return;
    //*
    // 출발, 도착 아이콘 설정
    TMapPoint* start = [[polyLine getLinePoint] objectAtIndex:0];
    TMapPoint* end = [[polyLine getLinePoint] lastObject];
    TMapMarkerItem* startMarkerItem = [[TMapMarkerItem alloc]initWithTMapPoint:start];
    [startMarkerItem setIcon:[UIImage imageNamed:@"start.png"] anchorPoint:CGPointMake(0.4, 1.0)];
    TMapMarkerItem* endMarkerItem = [[TMapMarkerItem alloc]initWithTMapPoint:end];
    [endMarkerItem setIcon:[UIImage imageNamed:@"end.png"]anchorPoint:CGPointMake(0.5, 1.0)];
    [_mapView setTMapPathIconStart:startMarkerItem End:endMarkerItem];
    //*/
    // 라인
    if(polyLine)
    {
        [_mapView addTMapPath:polyLine];
    }
}

- (void)rpBike
{
    TMapPathData* path = [[TMapPathData alloc] init];
    
    TMapPoint* startPoint = [_mapView getCenterPoint];
    //SKT 타워 37.566411, 126.985173
    TMapPoint* endPoint = [[TMapPoint alloc] initWithLon:126.985173 Lat:37.566411];
    
    TMapPolyLine *polyLine = [path findPathDataWithType:BICYCLE_PATH startPoint:startPoint endPoint:endPoint];
    
    if (polyLine == nil) {
        return;
    }
    
    if ([[polyLine getLinePoint] count] == 0)
        return;
    //*
    // 출발, 도착 아이콘 설정
    TMapPoint* start = [[polyLine getLinePoint] objectAtIndex:0];
    TMapPoint* end = [[polyLine getLinePoint] lastObject];
    TMapMarkerItem* startMarkerItem = [[TMapMarkerItem alloc]initWithTMapPoint:start] ;
    [startMarkerItem setIcon:[UIImage imageNamed:@"start.png"] anchorPoint:CGPointMake(0.4, 1.0)];
    TMapMarkerItem* endMarkerItem = [[TMapMarkerItem alloc]initWithTMapPoint:end];
    [endMarkerItem setIcon:[UIImage imageNamed:@"end.png"]anchorPoint:CGPointMake(0.5, 1.0)];
    [_mapView setTMapPathIconStart:startMarkerItem End:endMarkerItem];
    //*/
    // 라인
    if(polyLine)
    {
        [_mapView addTMapPath:polyLine];
    }
}

- (void)poiTest
{
    TMapPathData* path = [[TMapPathData alloc] init] ;
    
    //통합검색
    NSArray* result = [path requestFindAllPOI:@"신도림역"];
    
    int cnt = 0;
    static int idx = 0;
    for(TMapPOIItem* poi in result)
    {
        if (cnt++ == 0) {
            [_mapView setCenterPoint:[poi getPOIPoint]];
        }
        
        [_mapView addCustomObject:poi ID:[NSString stringWithFormat:@"poi%d", idx++]];
        NSLog(@"poi:%@", poi);
    }
}

- (void)trafficInfo
{
    [_mapView setTrafficInfo:![_mapView isTrafficInfo]];
    
}

- (void)bicycleMode
{
    [_mapView setBicycleInfo:![_mapView isBicycleInfo]];
}

- (void)bicycleFacilityMode
{
    [_mapView setBicycleFacilityInfo:![_mapView isBicycleFacilityInfo]];
}

-(void) trackingTest
{
    NSLog(@"before trackingMode %d", [_mapView getIsTracking]);
    [_mapView setTrackingMode:![_mapView getIsTracking]];
    NSLog(@"after trackingMode %d", [_mapView getIsTracking]);
}

- (void)compassMode
{
    [_mapView setCompassMode:![_mapView getIsCompass]];
}

- (void)sightMode
{
    [_mapView setSightVisible:![_mapView getSightVisible]];
}

- (void)mapPositionTypeTest
{
    [_mapView setMapPositionType:![_mapView getMapPositionType]];
}

-(void)sightVisibleTest
{
    [_mapView setSightVisible:![_mapView getSightVisible]];
}

- (void)revGeoTest
{
    TMapPathData* path = [[TMapPathData alloc] init];
    
    NSString *address = [path convertGpsToAddressAt:[_mapView getCenterPoint]];

    
    Alert(address);
}

- (void)fullPath
{
    
    // 신길동 37.506386, 126.904018/,
    TMapPoint* endPoint = [[TMapPoint alloc] initWithLon:126.903613 Lat:37.506287];
    
    TMapPathData* path = [[TMapPathData alloc] init] ;
    TMapPolyLine *polyLine = [path findPathDataFrom:[_mapView getCenterPoint] to:endPoint];
    
    if(polyLine)
    {
        //        TMapMarkerItem* startMarker = [[[TMapMarkerItem alloc] initWithTMapPoint:[[polyLine getLinePoint] objectAtIndex:0]] autorelease];
        //        [startMarker setIcon:[UIImage imageNamed:@"start.png"]];
        //
        //        TMapMarkerItem* endMarker = [[[TMapMarkerItem alloc] initWithTMapPoint:[[polyLine getLinePoint] objectAtIndex:[polyLine getLinePoint].count-1]] autorelease];
        //        [endMarker setIcon:[UIImage imageNamed:@"end.png"]];
        
        //        NSArray* array = [[[NSArray alloc] initWithObjects:startMarker, endMarker, polyLine, endPoint, nil] autorelease];
        //        [_mapView showFullPath:array];
        [_mapView showFullPath:[NSArray arrayWithObjects:polyLine, nil]];
    }
}

- (void)timeMachine {
    TMapPoint* endPoint = [[TMapPoint alloc] initWithLon:126.903613 Lat:37.506287];
    //, , ,
    TMapPathData* path = [[TMapPathData alloc] init];
    NSArray* wayPoints = [NSArray arrayWithObjects:
                          [[TMapPoint alloc] initWithLon:126.949768 Lat:37.487322] ,
                          [[TMapPoint alloc] initWithLon:127.00882 Lat:37.535253] ,
                          nil];
    NSDictionary *info = [path findTimeMachineCarPathWithStartPoint:[_mapView getCenterPoint]
                                                           endPoint:endPoint isStartTime:YES
                                                               time:[NSDate date] wayPoints:wayPoints];
    
    if ([info objectForKey:@"error"] != nil) {
        NSLog(@"timeMachine Error( code: %@ message: %@", info[@"error"][@"code"], info[@"error"][@"message"]);
    } else {
        NSLog(@"timeMAchine Info :%@", info);
    }
}



- (void)setLocationTest
{
    [_mapView setLocationPoint:[TMapPoint mapPointWithCoordinate:CLLocationCoordinate2DMake(37.401933, 126.922651)]];
}

- (void)setIconTest
{
    NSArray* images = [NSArray arrayWithObjects:
                       [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.sk.co.kr/Image/common/logo.gif"]]],
                       [UIImage imageNamed:@"start.png"],
                       [UIImage imageNamed:@"end.png"],
                       nil];
    
    static int index = 0;
    
    UIImage* image = [images objectAtIndex:index++ % [images count]];
    
    [_mapView setIcon:image];
}

- (void)iconVisibleTest
{
    static BOOL visible = NO;
    [_mapView setIconVisibility:visible];
    visible = !visible;
}

- (void)isValidCoord
{
    // 35.480354, 121.970215 대만
    BOOL valid = NO;
    valid = [_mapView isValidTMapPoint:[TMapPoint mapPointWithCoordinate:CLLocationCoordinate2DMake(35.480354, 121.970215)]];
    NSLog(@"valid : %@ ", valid  ? @"YES" : @"NO");
    
    //36.651674, 126.606445 충남
    valid = [_mapView isValidTMapPoint:[TMapPoint mapPointWithCoordinate:CLLocationCoordinate2DMake(36.651674, 126.606445)]];
    NSLog(@"valid : %@ ", valid  ? @"YES" : @"NO");
    
    // 33.489011, 126.498302 제주
    valid = [_mapView isValidTMapPoint:[TMapPoint mapPointWithCoordinate:CLLocationCoordinate2DMake(33.489011, 126.498302)]];
    NSLog(@"valid : %@ ", valid  ? @"YES" : @"NO");
}

- (void)poiCode
{
    TMapPathData* path = [[TMapPathData alloc] init];
    
    //업종코드 (주유소)
    NSArray* result = [path requestFindGeoPOI:[_mapView getCenterPoint] LCode:@"04" MCode:@"03"];
   
    
    // 주유소 마커 표시
    if (__markerIDs == nil) {
        __markerIDs = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
    int i = 0;
    for (TMapPOIItem* item in result)
    {
        //
        NSString *ID = [NSString stringWithFormat:@"marker%d", i++];
        
        [__markerIDs addObject:ID];
        
        UIImage* image = [UIImage imageNamed:@"dot.png"];
        
        TMapPoint* mapPoint = [item getPOIPoint];
        TMapMarkerItem* marker1 = [[TMapMarkerItem alloc] init];
        [marker1 setTMapPoint:mapPoint];
        [marker1 setIcon:image];
        [marker1 setName:[item getPOIName]];
        
        [_mapView addTMapMarkerItemID:ID Marker:marker1];
        NSLog(@"name: %@", [item getPOIName]);
    }
}

- (void)capture
{
    UIImage* image = [_mapView getCaptureImage];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

- (void)revGeoRevInfos:(TMapPoint*)mapPoint
{
    NSArray* types = @[@"A00", @"A01", @"A02", @"A03", @"A04"];
    NSArray* tyepStrings = @[@"행정동, 법정동", @"행정동", @"법정동", @"도로명주소 길", @"도로명주소 건물번호"];
    
    int i = 0;
    for (NSString* type in types)
    {
        TMapPathData* path = [[TMapPathData alloc] init];
        
        NSDictionary *info = [path reverseGeocoding:mapPoint addressType:type];

        
        NSArray* keys = info.allKeys;
        NSLog(@"----------[%@]%@ -------------", type, tyepStrings[i]);
        for (NSString* key in keys)
        {
            NSLog(@"%@: %@", key, [info objectForKey:key]);
        }
        i++;
    }
}

#pragma mark - TMap 연동
- (void)route
{
    [TMapTapi invokeRoute:@"신도림역" coordinate:_mapView.centerCoordinate];
}

- (void)route2
{
    NSDictionary* routeInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"강남역",@"rGoName",                              // 목적지명칭(필수)
                               [NSNumber numberWithDouble:127.027621],@"rGoX",  // 목적지경도(필수)
                               [NSNumber numberWithDouble:37.497942],@"rGoY",   // 목적지위도(필수)
                               @"서울역",@"rStName",                              // 출발지명칭
                               [NSNumber numberWithDouble:126.972646],@"rStX",  // 출발지경도
                               [NSNumber numberWithDouble:37.553017],@"rStY",   // 출발지위도
                               @"용산역",@"rV1Name",                              // 경유지1명칭
                               [NSNumber numberWithDouble:126.964775],@"rV1X",  // 경유지1 경도
                               [NSNumber numberWithDouble:37.52989],@"rV1Y",    // 경유지1 위도
                               @"사당역",@"rV2Name",                              // 경유지2명칭
                               [NSNumber numberWithDouble:126.981633],@"rV2X",  // 경유지2경도
                               [NSNumber numberWithDouble:37.476559],@"rV2Y",nil]; // 경유지2위도
    [TMapTapi invokeRoute:routeInfo];
}

- (void)mapview
{
    [TMapTapi invokeSetLocation:@"신도림역" coordinate:_mapView.centerCoordinate];
}

- (void)search
{
    [TMapTapi invokeSearchPortal:@"신도림역"];
}

- (void)home
{
    [TMapTapi invokeGoHome];
}

- (void)company
{
    [TMapTapi invokeGoCompany];
}

- (void)TMapAppInfo
{
    // TMap 설치 여부
    BOOL installed = [TMapTapi isTmapApplicationInstalled];
    
    // TMap 앱스토어 URL
    NSString* appstoreURL = [TMapTapi getTMapDownUrl];
    
    NSLog(@"installed: %@ URL: %@", installed?@"Y":@"N", appstoreURL);
}


#pragma mark -
- (void)scrollEnable
{
    static BOOL enable = NO;
    [_mapView setUserScrollZoomEnable:enable];
    enable = !enable;
}

#pragma mark - CallOutMarker
- (void)addCallOutMarker
{
    UIImage* image = [UIImage imageNamed:@"start.png"];
    
    TMapPoint* mapPoint = [[TMapPoint alloc] initWithCoordinate:_mapView.centerCoordinate] ;
    
    TMapMarkerItem* marker1 = [[TMapMarkerItem alloc] init] ;
    [marker1 setTMapPoint:mapPoint];
    [marker1 setIcon:image anchorPoint:CGPointMake(0.5, 1.0)];
    [marker1 setCanShowCallout:YES];
    [marker1 setCalloutTitle:@"CallOut 타이틀"];
    [marker1 setCalloutSubtitle:@"CallOut 서브타이틀"];
    [marker1 setCalloutLeftImage:[UIImage imageNamed:@"end.png"]];
    [marker1 setCalloutRightButtonImage:[UIImage imageNamed:@"accessory_detail.png"]];
    [marker1 setAutoCalloutVisible:YES];    // 풍선뷰 보이기
    
    static int i = 0;
    NSString* markerID = [NSString stringWithFormat:@"marker_%d", i];
    [_mapView addTMapMarkerItemID:markerID Marker:marker1];
    i++;
}

#pragma mark - Overlay
- (void)showWeatherOverlay
{
    TMapPoint* leftTop      = [TMapPoint mapPointWithCoordinate:CLLocationCoordinate2DMake(45.640171, 114.9652948)];
    TMapPoint* rightBottom  = [TMapPoint mapPointWithCoordinate:CLLocationCoordinate2DMake(29.2267177, 138.7206798)];
    
    TMapOverlayItem* overlay = [[TMapOverlayItem alloc] init];
    [overlay setImage:[UIImage imageNamed:@"weather.png"]];
    [overlay setLeftTopPoint:leftTop];
    [overlay setRightBottomPoint:rightBottom];
    
    [_mapView addTMapOverlayID:@"weather_Overlay" overlayItem:overlay];
    }

- (void)changeImage
{
    TMapOverlayItem* item = [_mapView getOverlayItemFromID:@"weather_Overlay"];
    [item setImage:[UIImage imageNamed:@"weather_01.png"]];
}

- (void)removeWeatherOverlay
{
    [_mapView removeTMapOverlayID:@"weather_Overlay"];
}

#pragma mark - change logo pos
- (void)logoPos
{
    static TMapLogoPositon pos = POSITION_BOTTOMLEFT;
    
    [_mapView setTMapLogoPosition:pos];
    
    if (pos++ == POSITION_BOTTOMRIGHT)
        pos = POSITION_BOTTOMLEFT;
}

#pragma mark - ZoomToSpan
- (void)ZoomToSpan
{
    double minLat = 37.42852;
    double maxLat = 37.714784;
    double minLon = 126.750897;
    double maxLon = 127.196529;
    CLLocationCoordinate2D centerCoord = {(minLat + maxLat) / 2, (minLon + maxLon) / 2};
    
    [_mapView zoomToLatSpan:(maxLat) - (minLat) lonSpan: (maxLon) - (minLon)];
    [_mapView setCenterCoordinate:centerCoord];
}

- (void)ZoomToTMapPoint
{
    TMapPoint* leftTop = [TMapPoint mapPointWithCoordinate:CLLocationCoordinate2DMake(37.448697,126.705322)];
    TMapPoint* rightBottom = [TMapPoint mapPointWithCoordinate:CLLocationCoordinate2DMake(35.527756,129.320068)];
    [_mapView zoomToTMapPointLeftTop:leftTop rightBottom:rightBottom];
}

static TMapGpsManager *__gps = nil;
- (void)GPS_ON
{
    if (__gps == nil) {
        __gps = [[TMapGpsManager alloc] init];
    }
    
    // 백그라운드 위치정보 얻기
    //[__gps setAlwaysAuthorization:YES];
    
    [__gps setDelegate:self];
    [__gps openGps];
    
}

- (void)GPS_OFF
{
    [__gps closeGps];
    
  
    __gps = nil;
}


@end
