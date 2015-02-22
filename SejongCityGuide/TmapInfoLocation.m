//
//  TmapTest.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 30..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "TmapInfoLocation.h"
#import <QuartzCore/QuartzCore.h>
#import "TMapGpsManager.h"

// 앱등록 및 키발급 -> https://developers.skplanetx.com/develop/
#define TMAP_APPKEY             @"20f38848-f6ee-3f50-88e1-33fbc259cb14"

// TMap invoke-TMap App실행  API <TMapTapi> 사용시 필요합니다.
#define TMAP_BIZAPPID           @"INSERT YOUR KEY..."


NSMutableArray* __objectIDs = nil;

void Alert(NSString* message) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:@"확인"
                                           otherButtonTitles:nil] ;
    [alert show];
}
@interface TmapInfoLocation() <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@end

@implementation TmapInfoLocation
{
    UIView*     _subBgView;
    NSMutableArray* _lineIDs;
    NSMutableArray* _circleIDs;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
      if (self.isLifeInfoList == YES) {
              self.contentTitle.title = @"경로검색";
      }else{
          self.contentTitle.title = @"입주기관 경로검색";
      }
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
    
    
    CGFloat width = self.view.bounds.size.width ;
    CGFloat height = self.view.bounds.size.height;
    height  = ceilf(height);
    
    _mapView = [[TMapView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    [_mapView setDelegate:self];
    [_mapView setGpsManagersDelegate:self];
    [_mapView setSKPMapApiKey:TMAP_APPKEY];
    [_mapView setBizAppID:TMAP_BIZAPPID];
    
    [self.viewTmap addSubview:_mapView];
    if (self.isLifeInfoList == YES) {
             [self rpLifeList];
    }else{
       [self rp:(self.locationFlag +1)];
    }
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

#pragma mark - TMapViewDelegate (TMapApiKey)
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"11 %@" , error);
    
}

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

#pragma mark - Button Actions
- (void)locationChanged:(TMapPoint*)newTmp
{
    NSLog(@"%@", newTmp);
}


- (void)rp:(NSInteger) sender
{
    TMapPathData* path = [[TMapPathData alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    ///
    //iOS8 대응
    if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        //   [locationManager requestWhenInUseAuthorization];   //앱을 사용하는 동안
        [locationManager requestAlwaysAuthorization];      //항상
        
        [self GPS_ON];
    }
    
    
    NSLog(@"1111  %f",locationManager.location.coordinate.latitude);      // latitude
    NSLog(@"1111  %f",locationManager.location.coordinate.longitude);    // longitude
    
    TMapPoint* startPoint = [[TMapPoint alloc] initWithLon:locationManager.location.coordinate.longitude Lat:locationManager.location.coordinate.latitude] ;
//TMapPoint* startPoint = [_mapView getCenterPoint];
    
    TMapPoint* endPoint  ;
    
    NSLog(@"tag!!  %i", sender);    // longitude

    
    switch (sender) {
        case 1:
            endPoint = [[TMapPoint alloc] initWithLon:127.262623 Lat:36.504369] ;
            break;
        case 2:
            endPoint = [[TMapPoint alloc] initWithLon:127.271587 Lat:36.502735] ;
            break;
        case 3:
            endPoint = [[TMapPoint alloc] initWithLon:127.268535 Lat:36.503563] ;
            break;
        case 4:
            endPoint = [[TMapPoint alloc] initWithLon:127.264828 Lat:36.505245] ;
            break;
        case 5:
            endPoint = [[TMapPoint alloc] initWithLon:127.266019 Lat:36.506711] ;
            break;
        case 6:
            endPoint = [[TMapPoint alloc] initWithLon:127.264828 Lat:36.505245] ;
            break;
        case 7:
            endPoint = [[TMapPoint alloc] initWithLon:127.264828 Lat:36.505245] ;
            break;
        case 8:
            endPoint = [[TMapPoint alloc] initWithLon:127.263010 Lat:36.506353] ;
            break;
        case 9:
            endPoint = [[TMapPoint alloc] initWithLon:127.263010 Lat:36.506353] ;
            break;
        case 10:
            endPoint = [[TMapPoint alloc] initWithLon:127.263010 Lat:36.506353] ;
            break;
        case 11:
            endPoint = [[TMapPoint alloc] initWithLon:127.259118 Lat:36.505359] ;
            break;
        case 12:
            endPoint = [[TMapPoint alloc] initWithLon:127.259118 Lat:36.505359] ;
            break;
        case 13:
            endPoint = [[TMapPoint alloc] initWithLon:127.259091 Lat:36.505204] ;
            break;
        case 14:
            endPoint = [[TMapPoint alloc] initWithLon:127.261406 Lat:36.502791] ;
            break;
        case 15:
            endPoint = [[TMapPoint alloc] initWithLon:127.261564 Lat:36.502690] ;
            break;
        case 16:
            endPoint = [[TMapPoint alloc] initWithLon:127.260931 Lat:36.500670] ;
            break;
        case 17:
            endPoint = [[TMapPoint alloc] initWithLon:127.259850 Lat:36.499411] ;
            break;
        case 18:
            endPoint = [[TMapPoint alloc] initWithLon:127.261840 Lat:36.499324] ;
            break;
        case 19:
            endPoint = [[TMapPoint alloc] initWithLon:127.266121 Lat:36.499432] ;
            break;
        case 20:
            endPoint = [[TMapPoint alloc] initWithLon:127.264936 Lat:36.497526] ;
            break;
        case 21:
            endPoint = [[TMapPoint alloc] initWithLon:127.260046 Lat:36.485823] ;
            break;
        case 22:
            endPoint = [[TMapPoint alloc] initWithLon:127.261848 Lat:36.483421] ;
            break;
    }
    
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
    
    CLLocationCoordinate2D centerCoord = {locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude};
//    [_mapView zoomToLatSpan: locationManager.location.coordinate.latitude lonSpan: locationManager.location.coordinate.longitude];
   [_mapView setCenterCoordinate:centerCoord];
}

- (void)rpLifeList
{
    TMapPathData* path = [[TMapPathData alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
  
    if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        //   [locationManager requestWhenInUseAuthorization];   //앱을 사용하는 동안
        [locationManager requestAlwaysAuthorization];      //항상
        
        [self GPS_ON];
    }
    
    
   
    TMapPoint* startPoint = [[TMapPoint alloc] initWithLon:locationManager.location.coordinate.longitude Lat:locationManager.location.coordinate.latitude] ;
    
    TMapPoint* endPoint = [[TMapPoint alloc] initWithLon:self.lon Lat:self.lat] ;

    NSLog(@"123412341234123412341234  %f",self.lon);      // latitude
    NSLog(@"221234123412341234123422  %f",self.lat);
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
    
    CLLocationCoordinate2D centerCoord = {locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude};
    //    [_mapView zoomToLatSpan: locationManager.location.coordinate.latitude lonSpan: locationManager.location.coordinate.longitude];
    [_mapView setCenterCoordinate:centerCoord];
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



-(IBAction)cancelPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
