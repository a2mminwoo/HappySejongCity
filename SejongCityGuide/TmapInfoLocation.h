//
//  TmapTest.h
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 30..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMapView.h"
@interface TmapInfoLocation : UIViewController <TMapViewDelegate, TMapGpsManagerDelegate>
{
     TMapView*       _mapView;
}
@property (weak, nonatomic) IBOutlet UIView *viewTmap;
@property (nonatomic) NSInteger locationFlag;
@end

