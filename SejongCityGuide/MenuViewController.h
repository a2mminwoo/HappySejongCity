//
//  MenuViewController.h
//  SlideToDo
//
//  Created by Brandon King on 4/20/13.
//  Copyright (c) 2013 King's Cocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol MenuViewControllerDelegate;

@interface MenuViewController :UIViewController<UITableViewDelegate, UITableViewDataSource>
- (IBAction)ErrorReportBtnAction:(id)sender;
- (IBAction)MenuCloseAction:(id)sender;
//@property (nonatomic, weak) id <MenuViewControllerDelegate> delegate;
//@property (nonatomic, strong) NSArray *categoryList;
@end


//@protocol MenuViewControllerDelegate
//-(void)menuViewControllerDidFinishWithCategoryId:(NSInteger)categoryId;
//@end
