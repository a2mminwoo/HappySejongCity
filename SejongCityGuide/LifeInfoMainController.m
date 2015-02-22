//
//  LifeInfoMainController.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 2. 9..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "LifeInfoMainController.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "lifeInfoTableViewController.h"
#import "MenuViewController.h"
@interface LifeInfoMainController ()

@end

@implementation LifeInfoMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self.slidingViewController.underRightViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underRightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuView"];
    }
    //  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}
- (IBAction)btnMenuAction:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECLeft];
}

- (IBAction)btn02Action:(id)sender {
    UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LifeInfoVC"];
    lifeInfoTableViewController *viewController = (lifeInfoTableViewController *)[[navigationController viewControllers]objectAtIndex:0];
    viewController.type = @"공공기관";
    viewController.navigationItem.title = [NSString stringWithFormat:@"%@ > 생활정보", viewController.type];
    [self presentViewController:navigationController animated:YES completion:nil];
}
- (IBAction)btn03Action:(id)sender {
    UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LifeInfoVC"];
    lifeInfoTableViewController *viewController = (lifeInfoTableViewController *)[[navigationController viewControllers]objectAtIndex:0];
    viewController.type = @"호텔";
    viewController.navigationItem.title = [NSString stringWithFormat:@"%@ > 생활정보", viewController.type];
    [self presentViewController:navigationController animated:YES completion:nil];
   
}
- (IBAction)btn05Action:(id)sender {
    
    UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LifeInfoVC"];
    lifeInfoTableViewController *viewController = (lifeInfoTableViewController *)[[navigationController viewControllers]objectAtIndex:0];
    viewController.type = @"금융";
    viewController.navigationItem.title = [NSString stringWithFormat:@"%@ > 생활정보", viewController.type];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}
- (IBAction)btn06Action:(id)sender {
    
    UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LifeInfoVC"];
    lifeInfoTableViewController *viewController = (lifeInfoTableViewController *)[[navigationController viewControllers]objectAtIndex:0];
    viewController.type = @"쇼핑·마트";
    viewController.navigationItem.title = [NSString stringWithFormat:@"%@ > 생활정보", viewController.type];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}
- (IBAction)btn07Action:(id)sender {
    UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LifeInfoVC"];
    lifeInfoTableViewController *viewController = (lifeInfoTableViewController *)[[navigationController viewControllers]objectAtIndex:0];
    viewController.type = @"차량주유·정비";
    viewController.navigationItem.title = [NSString stringWithFormat:@"%@ > 생활정보", viewController.type];
    [self presentViewController:navigationController animated:YES completion:nil];
    }
- (IBAction)btn08Action:(id)sender {
    
    UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LifeInfoVC"];
    lifeInfoTableViewController *viewController = (lifeInfoTableViewController *)[[navigationController viewControllers]objectAtIndex:0];
    viewController.type = @"보육·교육";
    viewController.navigationItem.title = [NSString stringWithFormat:@"%@ > 생활정보", viewController.type];
    [self presentViewController:navigationController animated:YES completion:nil];
   
}
- (IBAction)btn09Action:(id)sender {
    
    UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LifeInfoVC"];
    lifeInfoTableViewController *viewController = (lifeInfoTableViewController *)[[navigationController viewControllers]objectAtIndex:0];
    viewController.type = @"문화·예술";
    viewController.navigationItem.title = [NSString stringWithFormat:@"%@ > 생활정보", viewController.type];
    [self presentViewController:navigationController animated:YES completion:nil];

    }
- (IBAction)btn10Action:(id)sender {
    UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LifeInfoVC"];
    lifeInfoTableViewController *viewController = (lifeInfoTableViewController *)[[navigationController viewControllers]objectAtIndex:0];
    viewController.type = @"사회복지";
    viewController.navigationItem.title = [NSString stringWithFormat:@"%@ > 생활정보", viewController.type];
    [self presentViewController:navigationController animated:YES completion:nil];

}
- (IBAction)btn11Action:(id)sender {
    UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LifeInfoVC"];
    lifeInfoTableViewController *viewController = (lifeInfoTableViewController *)[[navigationController viewControllers]objectAtIndex:0];
    viewController.type = @"관광";
    viewController.navigationItem.title = [NSString stringWithFormat:@"%@ > 생활정보", viewController.type];
    [self presentViewController:navigationController animated:YES completion:nil];
    }


@end
