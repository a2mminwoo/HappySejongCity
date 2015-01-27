#import "PhoneContentController.h"
#import "AppDelegate.h"
#import "RootViewController.h"

@implementation PhoneContentController

- (void)awakeFromNib
{
	// load our data from a plist file inside our app bundle
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content_iPhone" ofType:@"plist"];
    self.contentList = [NSArray arrayWithContentsOfFile:path];
    self.rootViewController.contentList = self.contentList;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = (UIViewController *)self.rootViewController;
}

@end