//
//  FinishingViewController.m
//  MOSAD_HW5
//
//  Created by 梁俊华 on 2019/11/2.
//  Copyright © 2019 梁俊华. All rights reserved.
//


#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#define COLLECTION_CELL_IDENTIFIER @"reuseCell"
#import <Foundation/Foundation.h>
#import "FinishingViewController.h"
#import "Masonry.h"
#import "StarUnit.h"

@interface FinishingViewController() <UICollectionViewDelegate, UICollectionViewDataSource> {
    UILabel * _title;
    UILabel * _count;
    UIButton * _button;
    UICollectionView * _collection;
    
    NSInteger starCount;
}

@end

@implementation FinishingViewController

- (void)viewDidLoad {
    starCount = 0;
//    for(NSString * str in _stars) {
//        if ([str isEqualToString:@"1"]) {
//            starCount += 1;
//        }
//    }
    NSLog(@"Right %ld", starCount);
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    // Title
    _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500, 50)];
    _title.text = @"正确数";
    _title.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_title];
    
    // Count
    _count = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500, 100)];
    _count.text = @"0";//[NSString stringWithFormat:@"%ld", starCount];
    _count.font = [UIFont systemFontOfSize:50];
    [self.view addSubview:_count];
    
    
    // Button
    _button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 800, 200, 50)];
    _button.layer.borderWidth = 1;
    _button.layer.cornerRadius = 7.0f;
    _button.layer.masksToBounds = YES;
    [_button setTitle:@"返回" forState:UIControlStateNormal];
    _button.layer.borderColor = UIColor.whiteColor.CGColor;
    _button.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:255 / 255.0 blue:127 / 255.0 alpha:1];
    [_button addTarget:self action:@selector(goBackToRoot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    // 设置Collection.
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(50, 50);
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 300, 120) collectionViewLayout:layout];
    [_collection registerClass:[StarUnit class] forCellWithReuseIdentifier:COLLECTION_CELL_IDENTIFIER];
    _collection.backgroundColor = UIColor.whiteColor;
    _collection.dataSource = self;
    _collection.delegate = self;
    [self.view addSubview:_collection];
    
    [self setLayout];
}

- (void)setLayout {
    UIView * superview = self.view;
    
    // Title
    [_title makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.top).offset(230);
        make.centerX.equalTo(superview.centerX);
    }];
    
    // Count
    [_count makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.top).offset(300);
        make.centerX.equalTo(superview.centerX);
    }];
    
    // Collection
    _collection.center = superview.center;
}

- (void)goBackToRoot {
    [self.navigationController popToRootViewControllerAnimated:NO];
}


#pragma mark UICollectionViewDataSource
// 返回section数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 返回每个section的item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StarUnit * cell = (StarUnit *)[collectionView dequeueReusableCellWithReuseIdentifier:COLLECTION_CELL_IDENTIFIER forIndexPath:indexPath];
    
//    CAKeyframeAnimation *scaleXAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
//    scaleXAni.values = @[@1, @1.3, @1]; scaleXAni.keyTimes = @[@0, @0.5, @1];
//
//    CAKeyframeAnimation *scaleYAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
//    scaleYAni.values = @[@1, @1.3, @1]; scaleYAni.keyTimes = @[@0, @0.5, @1];
//
//
//    CAAnimationGroup *aniGroup = [CAAnimationGroup animation]; aniGroup.animations = @[scaleXAni, scaleYAni];
//    aniGroup.duration = 0.25;
//    aniGroup.beginTime = CACurrentMediaTime() + 0.25 * indexPath.item;
//    [cell.contentView.layer addAnimation:aniGroup forKey:@"scale"];
    
    [UIView animateKeyframesWithDuration:0.5 delay:0.5 * indexPath.item options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.6 animations: ^{
            cell.contentView.transform = CGAffineTransformScale(cell.contentView.transform, 1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.4 animations: ^{
            cell.contentView.transform = CGAffineTransformScale(cell.contentView.transform, 0.66, 0.66);
        }];
    } completion:^(BOOL finished) {
        if ([self->_stars[indexPath.item] isEqualToString:@"1"]) {
            cell.image.image = [UIImage imageNamed:@"Star1.png"];
            [cell setLayout];
            self->starCount += 1;
            self->_count.text = [NSString stringWithFormat:@"%ld", self->starCount];
        }
    }];
    
    return cell;
}

// 设置cell的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // UIEdgeInsets insets = {top, left, bottom, right};
    return UIEdgeInsetsMake(0, 25, 25, 25);
}


@end
