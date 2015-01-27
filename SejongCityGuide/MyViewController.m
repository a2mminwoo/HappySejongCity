#import "MyViewController.h"

@interface MyViewController ()
@property (assign) NSInteger pageNumber;
@end


#pragma mark -

@implementation MyViewController

// load the view nib and initialize the pageNumber ivar
- (id)initWithPageNumber:(NSUInteger)page
{
    if (self = [super initWithNibName:@"MyView" bundle:nil])
    {
        _pageNumber = page;
    }
    return self;
}

// set the label and background color when the view has finished loading
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pageNumberLabel.text = [NSString stringWithFormat:@"Page %ld", (long)self.pageNumber + 1];
}

@end