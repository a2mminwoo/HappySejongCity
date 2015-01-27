#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "ContentController.h"

@class RootViewController;

@interface PhoneContentController : ContentController

@property (nonatomic, strong) IBOutlet RootViewController *rootViewController;

@end