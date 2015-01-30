//
//  TMapPoint.h
//  skp
//
//  Created by developer on 12. 8. 5..
//  Copyright (c) 2012년 SKP. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>

@interface TMapPoint : NSObject

// Ver 0.1.0 (2012.10.08) 추가
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

/*
 *  mapPointWithCoordinate:
 *
 *  @abstract
 *      coordinate값으로 객체를 생성
 */
+ (id)mapPointWithCoordinate:(CLLocationCoordinate2D)coordinate;

/*
 *  initWithCoordinate:
 *
 *  @abstract
 *      coordinate값으로 객체를 생성
 */
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

/*
 *  initWithLon:Lat:
 *
 *  @abstract
 *      경도, 위도값으로 객체를 생성
 */
- (id)initWithLon:(double)lon Lat:(double)lat;

/*
 *  setLatitude:
 *
 *  @abstract
 *      위도값을 설정
 */
- (void)setLatitude:(double)lat;

/*
 *  setLongitude:
 *
 *  @abstract
 *      경도값을 설정
 */
- (void)setLongitude:(double)lon;

/*
 *  getLatitude
 *
 *  @abstract
 *      위도값을 얻어온다.
 */
- (double)getLatitude;

/*
 *  getLongitude
 *
 *  @abstract
 *      경도값을 얻어온다.
 */
- (double)getLongitude;

- (NSString *)toString;

/*
 *  getDistanceWith
 *
 *  @abstract
 *      두지점의 거리를 얻어온다
 */
- (double)getDistanceWith:(TMapPoint*)compareTmp;

/*
 *  getKatec
 *
 *  @abstract
 *      카텍좌표로 변환
 */
- (CGPoint)getKatec;

/*
 *  getKatechLon
 *
 *  @abstract
 *      latitude를 카텍좌표 y로 변환
 */
- (double)getKatechLat;

/*
 *  getKatechLon
 *
 *  @abstract
 *      longitude를 카텍좌표 x로 변환
 */
- (double)getKatechLon;

/*
 *  equalWith:
 *
 *  @abstract
 *      좌표 일치여부조사
 */
- (bool)equalWith:(TMapPoint*)p;

@end


