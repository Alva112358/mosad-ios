//
//  TabCollectionViewController.m
//  News
//
//  Created by tplish on 2019/12/17.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TabCollectionViewController.h"
#import "../View/TabCollectionViewCell.h"

@interface TabCollectionViewController()
<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    NSInteger currentIndex;
    CGFloat tabWeight;
    CGFloat tabHeight;
}
@property (nonatomic, strong) NSArray<NSString *> * tabs;
@property (nonatomic, strong) ContentSwitchBlock contentSwitch;
@end

@implementation TabCollectionViewController

- (instancetype)init{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    if (self = [super initWithCollectionViewLayout:layout]){
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        self.collectionView.backgroundColor = UIColor.clearColor;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[TabCollectionViewCell class] forCellWithReuseIdentifier:@"tabCollectionViewCell"];
    };
    return self;
}

- (BOOL)canMove:(NSInteger)index{
    CGFloat maxWidth = self.view.frame.size.width;
    CGFloat halfWidth = maxWidth / 2;
    return index*tabWeight>=halfWidth && (self.tabs.count-index-1)*tabWeight>=halfWidth;
}

- (void)updateIndex:(NSInteger)index{
    CGFloat maxWidth = self.view.frame.size.width;
    CGFloat offset = index * tabWeight - maxWidth/2 + tabWeight/2;
    if (![self canMove:index]){
        if (index < self.tabs.count/2)offset = 0;
        else offset = self.tabs.count*tabWeight - maxWidth;
    }
    [self.collectionView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
    currentIndex = index;
    [self.collectionView reloadData];
}

- (void)configArray:(NSMutableArray<NSString *> *)tabs TabWeight:(CGFloat)weight TabHeight:(CGFloat)height Index:(NSInteger)index Block:(ContentSwitchBlock)contentSwitch{
    _tabs = tabs;
    _contentSwitch = contentSwitch;
    tabWeight = weight;
    tabHeight = height;
    [self updateIndex:index];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tabs.count;
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TabCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tabCollectionViewCell" forIndexPath:indexPath];
    cell.label.text = self.tabs[indexPath.row];
    if (indexPath.row == currentIndex){
        cell.label.textColor = UIColor.orangeColor;
    } else {
        cell.label.textColor = UIColor.blackColor;
    }
    return cell;
}

#pragma mark UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(tabWeight, tabHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self updateIndex:indexPath.row];
    self.contentSwitch(indexPath.row);
}

@end
