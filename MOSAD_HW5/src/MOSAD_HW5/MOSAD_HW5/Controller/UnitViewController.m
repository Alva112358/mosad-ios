//
//  UnitViewController.m
//  MOSAD_HW5
//
//  Created by 梁俊华 on 2019/11/2.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#define COLLECTION_CELL_IDENTIFIER @"reuseCell"

#import <Foundation/Foundation.h>
#import "UnitViewController.h"
#import "QuestionViewController.h"
#import "Masonry.h"


@interface UnitViewController() <UICollectionViewDataSource, UICollectionViewDelegate> {
    UILabel * _label;
    UICollectionView * _collection;
}

@end

@implementation UnitViewController

- (void)viewDidLoad {
    self.dataSource = @[@"Unit1", @"Unit2", @"Unit3", @"Unit4"];
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    _label.text = @"请选择题目";
    _label.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:_label];
    
    // 设置Collection.
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(200, 50);
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 300, 300) collectionViewLayout:layout];
    [_collection registerClass:[UnitCell class] forCellWithReuseIdentifier:COLLECTION_CELL_IDENTIFIER];
    _collection.backgroundColor = UIColor.whiteColor;
    _collection.dataSource = self;
    _collection.delegate = self;
    [self.view addSubview:_collection];
    
    [self setLayout];
}

- (void)setLayout {
    UIView * superview = self.view;
    _collection.center = superview.center;
    
    [_label makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.top).offset(230);
        make.centerX.equalTo(superview.centerX);
    }];
}

- (void)gotoUnit:(NSString *)unit {
    QuestionViewController * questionvc = [[QuestionViewController alloc] init];
    questionvc.unit = unit;
    questionvc.proc = 0;
    [self.navigationController pushViewController:questionvc animated:NO];
}


#pragma mark UICollectionViewDataSource

// 返回section数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

// 返回每个section的item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UnitCell * cell = (UnitCell *)[collectionView dequeueReusableCellWithReuseIdentifier:COLLECTION_CELL_IDENTIFIER forIndexPath:indexPath];
    
    [cell setUnitText:self.dataSource[indexPath.section]];
    return cell;
}

// 设置cell的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // UIEdgeInsets insets = {top, left, bottom, right};
    return UIEdgeInsetsMake(0, 50, 25, 50);
}

// 设置点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString * unit = self.dataSource[indexPath.section];
    [self gotoUnit:unit];
}

@end
