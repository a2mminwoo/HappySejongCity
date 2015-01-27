#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *pageNumberLabel;

@property (nonatomic, strong) IBOutlet UILabel *numberTitle;
@property (nonatomic, strong) IBOutlet UIImageView *numberImage;

- (id)initWithPageNumber:(NSUInteger)page;

@end
