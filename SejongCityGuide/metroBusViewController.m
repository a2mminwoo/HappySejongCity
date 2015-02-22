//
//  metroBusViewController.m
//  SejongCityGuide
//
//  Created by A2M on 2015. 2. 11..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "metroBusViewController.h"
#import "metroBusCell.h"

@interface metroBusViewController ()

@end

@implementation metroBusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tableData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"busCell" forIndexPath:indexPath];
    metroBusCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"busCell" forIndexPath:indexPath];
    cell.stationName.text = [[self.tableData objectAtIndex:indexPath.row]objectForKeyedSubscript:@"name"];
    //label2.text = [[self.tableData objectAtIndex:indexPath.row] objectForKeyedSubscript:@"name"];
    
    [cell.layer setCornerRadius:10.0f];
    [cell.layer setBorderWidth:0.5f];
    [cell.layer setBorderColor:[UIColor grayColor].CGColor];
//    CGRect screenRect = [[UIScreen mainScreen]bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    NSInteger widthInt = indexPath.row % 2;
//    CGFloat cellWidth = screenWidth / 2.0f;
//    [cell.layer setFrame:CGRectMake(widthInt * cellWidth, (indexPath.row/2) * 50.0f, screenWidth / 2.0f, 50.0f)];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSString *title = self.startDest;
    if([self.delegate respondsToSelector:@selector(itemSelectedatRow:position:)]){
        [self.delegate itemSelectedatRow:indexPath.row position:title];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelPress:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
