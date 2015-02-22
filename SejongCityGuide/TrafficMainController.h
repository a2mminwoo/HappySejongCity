#import <UIKit/UIKit.h>


@interface TrafficMainController : UIViewController
- (IBAction)btnMenuAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIImageView *trafficBtn01;

- (IBAction)KTXTab:(id)sender;

- (IBAction)TrainTap:(id)sender;

- (IBAction)ExBusTap:(id)sender;


- (void)setConnectIv;
@end
