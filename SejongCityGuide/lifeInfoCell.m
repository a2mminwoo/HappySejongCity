//
//  lifeInfoCell.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 12..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "lifeInfoCell.h"
#import "TmapInfoLocation.h"

@implementation lifeInfoCell



- (void)awakeFromNib {
  
   }

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)phoneCall:(id)sender {
    //NSLog(@"tel : %@", self.lifeTel.titleLabel.text);
    NSString *telNum = [self.lifeTel.titleLabel.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    telNum = [NSString stringWithFormat:@"telprompt://%@", telNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telNum]];
}

- (IBAction)locationFind:(id)sender {
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    TmapInfoLocation *viewController = (TmapInfoLocation *)[storyboard instantiateViewControllerWithIdentifier:@"TmapInfoLocation"];
    viewController.isLifeInfoList = YES;
    viewController.lat= [self.lati doubleValue];
    viewController.lon= [self.longi doubleValue];
    [self.getViewController presentViewController:viewController animated:YES completion:nil];
}

- (UIViewController *)getViewController
{
    id vc = [self nextResponder];
    while(![vc isKindOfClass:[UIViewController class]] && vc!=nil)
    {
        vc = [vc nextResponder];
    }
    
    return vc;
}
@end
