//
//  ViewController.m
//  CollectionViewsDemo
//
//  Created by James Cash on 13-07-16.
//  Copyright © 2016 Occasionally Cogent. All rights reserved.
//

#import "ViewController.h"
#import "CircleLayout.h"

@interface ViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *defaultFlowLayout;
@property (strong,nonatomic) UICollectionViewFlowLayout *bigLayout;
@property (strong,nonatomic) UICollectionViewFlowLayout *smallLayout;
@property (strong,nonatomic) CircleLayout *circleLayout;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bigLayout = [[UICollectionViewFlowLayout alloc] init];
    self.bigLayout.itemSize = CGSizeMake(300, 300);
    self.bigLayout.minimumLineSpacing = 200;
    self.bigLayout.minimumInteritemSpacing = 100;
    self.bigLayout.sectionInset = UIEdgeInsetsMake(10, 100, 15, 50);
    self.bigLayout.headerReferenceSize = CGSizeMake(0, 100);
    self.bigLayout.footerReferenceSize = CGSizeMake(0, 75);

    self.smallLayout = [[UICollectionViewFlowLayout alloc] init];
    self.smallLayout.itemSize = CGSizeMake(100, 50);
    self.smallLayout.minimumLineSpacing = 10;
    self.smallLayout.minimumInteritemSpacing = 15;
    self.smallLayout.sectionInset = UIEdgeInsetsMake(10, 10, 15, 25);
    self.smallLayout.headerReferenceSize = CGSizeMake(0, 44);
    self.smallLayout.footerReferenceSize = CGSizeMake(0, 0);

    self.circleLayout = [[CircleLayout alloc] init];
//    self.collectionView.collectionViewLayout = self.bigLayout;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleLayout:(UIButton *)sender {
    sender.enabled = NO;
    UICollectionViewLayout *nextLayout;
    UICollectionViewLayout *currentLayout = self.collectionView.collectionViewLayout;
    if (currentLayout == self.defaultFlowLayout) {
        nextLayout = self.bigLayout;
    } else if (currentLayout == self.bigLayout) {
        nextLayout = self.smallLayout;
    } else if (currentLayout == self.smallLayout) {
        nextLayout = self.circleLayout;
    } else {
        nextLayout = self.defaultFlowLayout;
    }
    [currentLayout invalidateLayout];
    [self.collectionView setCollectionViewLayout:nextLayout animated:YES completion:^(BOOL finished) {
        sender.enabled = YES;
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3 + section;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"basicCollectionCell" forIndexPath:indexPath];

    UILabel *lbl = (UILabel*)[cell viewWithTag:1];
    lbl.text = [NSString stringWithFormat:@"%ld, %ld", indexPath.section, indexPath.item];

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"collectionHeaderView" forIndexPath:indexPath];
        return header;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"collectionFooterView" forIndexPath:indexPath];
        return footer;
    }
    return nil;
}

@end
