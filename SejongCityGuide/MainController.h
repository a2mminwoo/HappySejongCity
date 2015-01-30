#import <UIKit/UIKit.h>

@interface MainController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *trafficBtn01;

@property (weak, nonatomic) IBOutlet UIImageView *ivMainPdf01;
@property (weak, nonatomic) IBOutlet UIImageView *ivMainPdf02;
@property (weak, nonatomic) IBOutlet UIImageView *ivMainPdf03;
@property (weak, nonatomic) IBOutlet UIImageView *ivMainPdf04;
@property (weak, nonatomic) IBOutlet UIImageView *ivMainPdf05;
@property (weak, nonatomic) IBOutlet UIImageView *ivMainSejong;

@property (weak, nonatomic) IBOutlet UIImageView *officeBtn01;
@property (weak, nonatomic) IBOutlet UIImageView *officeBtn02;
@property (weak, nonatomic) IBOutlet UIImageView *officeBtn03;
@property (weak, nonatomic) IBOutlet UIImageView *officeBtn04;
@property (weak, nonatomic) IBOutlet UIImageView *officeBtn05;
@property (weak, nonatomic) IBOutlet UIImageView *officeBtn06;

- (void)setConnectIv;
@end
