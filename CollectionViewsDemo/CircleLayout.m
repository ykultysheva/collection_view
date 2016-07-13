//
//  CircularLayout.m
//  LighthouseCollectionsDemo
//
//  Created by James Cash on 19-08-15.
//  Copyright (c) 2015 Occasionally Cogent. All rights reserved.
//

#import "CircleLayout.h"

@interface CircleLayout () {
    NSArray *points;
}

@end

@implementation CircleLayout

- (void)prepareLayout
{
    [super prepareLayout];

    NSMutableArray *sections = [[NSMutableArray alloc] init];
    CGRect frame = self.collectionView.frame;
    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    for (NSInteger sectionIdx = 0; sectionIdx < self.collectionView.numberOfSections; sectionIdx++) {
        NSMutableArray *itemPoints = [[NSMutableArray alloc] init];
        CGFloat anglePerItem = 360.0 / [self.collectionView numberOfItemsInSection:sectionIdx];
        CGFloat radius = 100 + (120 * sectionIdx);
        for (CGFloat angle = 0; angle <= 360.0; angle += anglePerItem) {
            CGFloat x = center.x + radius * cos(angle * M_PI / 180);
            CGFloat y = center.y + radius * sin(angle * M_PI / 180);
            CGPoint point = CGPointMake(x, y);
            [itemPoints addObject:[NSValue valueWithCGPoint:point]];
        }
        [sections addObject:itemPoints];
    }
    points = [NSArray arrayWithArray:sections];
}

- (CGSize)collectionViewContentSize
{
    return self.collectionView.bounds.size;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attrs = [[NSMutableArray alloc] init];
    for (NSInteger section = 0; section < self.collectionView.numberOfSections; section++) {
        for (NSInteger item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:item inSection:section];
            [attrs addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
    return attrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    NSArray *sectionPoints = points[indexPath.section];
    CGPoint point = [(NSValue*)sectionPoints[indexPath.item] CGPointValue];
    attrs.center = point;
    attrs.size = CGSizeMake(100, 100);

    return attrs;
}

@end