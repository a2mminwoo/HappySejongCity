//
//  metroBusViewController.h
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 11..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol metroBusViewControllerDelegate <NSObject>

@required
-(void)itemSelectedatRow:(NSInteger)row position:(NSString *)pos;

@end

@interface metroBusViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
- (IBAction)cancelPress:(id)sender;

@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) NSString *startDest;
@property (nonatomic, assign) id<metroBusViewControllerDelegate> delegate;

@end
