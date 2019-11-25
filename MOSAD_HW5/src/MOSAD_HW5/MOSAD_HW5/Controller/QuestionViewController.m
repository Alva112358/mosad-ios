//
//  QuestionViewController.m
//  MOSAD_HW5
//
//  Created by 梁俊华 on 2019/11/2.
//  Copyright © 2019 梁俊华. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#define COLLECTION_CELL_IDENTIFIER @"reuseCell"

#import <Foundation/Foundation.h>
#import "QuestionViewController.h"
#import "FinishingViewController.h"
#import "Masonry.h"
#import "AFNetworking.h"

@interface QuestionViewController() <UICollectionViewDataSource, UICollectionViewDelegate> {
    UILabel * _label;
    UILabel * _answer;
    UIButton * _button;
    UICollectionView * _collection;
    NSIndexPath * choose;
    UIView * _animateView;
    NSString * curAnswer;
    NSMutableArray * starCount;
    BOOL isFinish;
}

@end

@implementation QuestionViewController

@synthesize unit = _unit;
@synthesize num = _num;
@synthesize proc = _proc;

- (void)viewDidLoad {
    isFinish = NO;
    starCount = [NSMutableArray arrayWithObjects:@"0", @"0", @"0", @"0", nil];
    self.dataSource = [NSMutableArray arrayWithObjects:
                       @"", @"", @"", @"", nil];
    if ([_unit isEqualToString:@"Unit1"]) {
        _num = @"0";
    } else if ([_unit isEqualToString:@"Unit2"]) {
        _num = @"1";
    } else if ([_unit isEqualToString:@"Unit3"]) {
        _num = @"2";
    } else {
        _num = @"3";
    }
    [self getUnitFromNetworkWithUnit:_num WithProcess:_proc];
    
    NSLog(@"Hello");
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.title = _unit;
    
    _animateView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200)];
    _animateView.backgroundColor = [UIColor colorWithRed:127 / 255.0 green:255 / 255.0 blue:170 / 255.0 alpha:1];
    [self.view addSubview:_animateView];
    
    _answer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500, 50)];
    _answer.text = @"正确答案: ";
    _answer.font = [UIFont systemFontOfSize:18];
    _answer.textColor = UIColor.whiteColor;
    [_animateView addSubview:_answer];
    
    // Collection
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(200, 50);
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 300, 300) collectionViewLayout:layout];
    [_collection registerClass:[ChoiceCell class] forCellWithReuseIdentifier:COLLECTION_CELL_IDENTIFIER];
    _collection.backgroundColor = UIColor.whiteColor;
    _collection.dataSource = self;
    _collection.delegate = self;
    [self.view addSubview:_collection];
    
    // Label
    _label = [[UILabel alloc] init];
    _label.text = @"";
    _label.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:_label];
    
    // ButtoVn
    _button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 800, 200, 50)];
    // _buttonRect = CGRectMake(self.view.frame.size.width/2-100, 800, self.view.frame.size.width, 300);
    // _button.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:255 / 255.0 blue:127 / 255.0 alpha:1];
    _button.enabled = NO;
    _button.layer.borderWidth = 1;
    _button.layer.cornerRadius = 7.0f;
    _button.layer.masksToBounds = YES;
    [_button setTitle:@"确认" forState:UIControlStateNormal];
    _button.layer.borderColor = UIColor.whiteColor.CGColor;
    _button.backgroundColor = [UIColor grayColor];
    [_button addTarget:self action:@selector(checkAnswer) forControlEvents:UIControlEventTouchUpInside];
    
    // _button.backgroundColor = [UIColor colorWithRed:127 / 255.0 green:255 / 255.0 blue:170 / 255.0 alpha:1];
    
    // [_button setBackgroundColor:[UIColor colorWithRed:0 / 255.0 green:255 / 255.0 blue:127 / 255.0 alpha:1]];
    [self.view addSubview:_button];
    
    [self setLayout];
    
}

- (void)setLayout {
    UIView * superview = self.view;
    
    _collection.center = superview.center;
    
    [_label makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.top).offset(230);
        make.centerX.equalTo(superview.centerX);
    }];
    
    [_answer makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_animateView.top).offset(20);
        make.left.equalTo(self->_animateView.left).offset(20);
    }];
}

- (void)getUnitFromNetworkWithUnit:(NSString *)Unit
                       WithProcess:(NSInteger)procs {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString * url = @"https://service-p12xr1jd-1257177282.ap-beijing.apigateway.myqcloud.com/release/HW5_api?unit=";
    NSString * URL = [url stringByAppendingString:Unit];
    NSLog(@"Request URL: %@", URL);
    
    [manager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Request Successfully");
        [self.dataSource replaceObjectAtIndex:0 withObject:responseObject[@"data"][procs][@"choices"][0]];
        [self.dataSource replaceObjectAtIndex:1 withObject:responseObject[@"data"][procs][@"choices"][1]];
        [self.dataSource replaceObjectAtIndex:2 withObject:responseObject[@"data"][procs][@"choices"][2]];
        [self.dataSource replaceObjectAtIndex:3 withObject:responseObject[@"data"][procs][@"choices"][3]];
        self->_label.text = responseObject[@"data"][procs][@"question"];
        [self->_collection reloadData];
        NSLog(@"%@", responseObject[@"data"][procs][@"choices"][0]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Request Fail: %@", error);
    }];
}

- (void)checkAnswer {
    _button.enabled = NO;
    __block NSString * isOK = @"wrong";
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString * url = @"https://service-p12xr1jd-1257177282.ap-beijing.apigateway.myqcloud.com/release/HW5_api?unit=";
    NSString * URL = [url stringByAppendingString:_num];
    NSDictionary * dic = @{@"unit": _num,
                           @"question": [NSString stringWithFormat:@"%ld", self.proc],
                           @"Answer": curAnswer};
    NSLog(@"Request URL: %@", URL);
    NSLog(@"Post %@", dic);
    
    [manager POST:URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Request Successfully %@", responseObject);
        NSString * answer = [@"正确答案: " stringByAppendingFormat:@"%@", responseObject[@"data"]];
        self->_answer.text = answer;
        if ([responseObject[@"message"] isEqual:@"right"]) {
            isOK = @"right";
            [self->starCount replaceObjectAtIndex:self->_proc withObject:@"1"];
            self->_animateView.backgroundColor = [UIColor colorWithRed:127 / 255.0 green:255 / 255.0 blue:170 / 255.0 alpha:1];
        } else {
            // 红色
            self->_animateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:192 / 255.0 blue:203 / 255.0 alpha:1];
            self->_button.backgroundColor = UIColor.redColor;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Request Fail: %@", error);
    }];
    
    [_button setTitle:@"继续" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self->_animateView.transform = CGAffineTransformTranslate(self->_animateView.transform, 0, -200);
    } completion:^(BOOL finished) {
        [self->_button removeTarget:self action:@selector(checkAnswer) forControlEvents:UIControlEventTouchUpInside];
        [self->_button addTarget:self action:@selector(viewGoBackToBottom) forControlEvents:UIControlEventTouchUpInside];
        self->_proc = self->_proc + 1;
        self->isFinish = YES;
        self->_button.enabled = YES;
    }];
}

- (void)gotoFinishView {
    FinishingViewController * finishvc = [[FinishingViewController alloc] init];
    finishvc.stars = self->starCount;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.navigationController pushViewController:finishvc animated:NO];
}

- (void)viewGoBackToBottom {
    _button.enabled = NO;
    if (_proc != 4) {
        [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self->_animateView.transform = CGAffineTransformTranslate(self->_animateView.transform, 0, 200);
        } completion:^(BOOL finished) {
            // 按钮在完成以后恢复到灰色
            self->_button.backgroundColor = [UIColor grayColor];
            [self->_button setTitle:@"确认" forState:UIControlStateNormal];
            [self->_button removeTarget:self action:@selector(viewGoBackToBottom) forControlEvents:UIControlEventTouchUpInside];
            [self->_button addTarget:self action:@selector(checkAnswer) forControlEvents:UIControlEventTouchUpInside];
            self->isFinish = NO;
            [self getUnitFromNetworkWithUnit:self->_num WithProcess:self->_proc];
            NSLog(@"Complete!");
        }];
        // _animateView.backgroundColor = [UIColor colorWithRed:127 / 255.0 green:255 / 255.0 blue:170 / 255.0 alpha:1];
    } else {
        [self gotoFinishView];
    }
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
    ChoiceCell * cell = (ChoiceCell *)[collectionView dequeueReusableCellWithReuseIdentifier:COLLECTION_CELL_IDENTIFIER forIndexPath:indexPath];
    
    [cell setWithWord:self.dataSource[indexPath.section]];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = UIColor.whiteColor.CGColor;
    cell.layer.cornerRadius = 7.0f;
    cell.layer.masksToBounds = YES;
    NSLog(@"%@", self.dataSource[indexPath.section]);
    return cell;
}

// 设置cell的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // UIEdgeInsets insets = {top, left, bottom, right};
    return UIEdgeInsetsMake(0, 50, 25, 50);
}

// 设置点击事件
- (void)collectionView:(UICollectionViewCell *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // Cancel the old print.
    NSLog(@"%@", choose);
    
    if (!isFinish) {
        if (![choose isEqual:NULL]) {
            ChoiceCell * cell = (ChoiceCell *)[_collection cellForItemAtIndexPath:choose];
            cell.layer.borderColor = UIColor.whiteColor.CGColor;
            [cell setTextColor:UIColor.blackColor];
        }

        // [_collection cellForItemAtIndexPath:choose].layer.borderColor = UIColor.whiteColor.CGColor;
        
        ChoiceCell * newCell = (ChoiceCell *)[_collection cellForItemAtIndexPath:indexPath];
        [_collection cellForItemAtIndexPath:indexPath].layer.borderColor = UIColor.greenColor.CGColor;
        [newCell setTextColor:UIColor.greenColor];
        _button.enabled = YES;
        [_button setBackgroundColor:[UIColor colorWithRed:0 / 255.0 green:255 / 255.0 blue:127 / 255.0 alpha:1]];
        curAnswer = newCell.word.text;
        
        choose = indexPath;
    }

}

@end
