//
//  HomeViewController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"

#import "../Model/TabModel.h"

#import "TabCollectionViewController.h"
#import "ContentPageViewController.h"
#import "NewsCollectionViewController.h"

#import "Base/Controller/UserViewController.h"
#import "Base/Controller/SearchViewController.h"
#import "Base/View/NavTitleView.h"
#import "Base/View/LoadingView.h"
#import "Base/GlobalVariable.h"
#import "Base/NetRequest.h"

#import "Masonry.h"

@interface HomeViewController()

// 自定义导航栏
@property (nonatomic, strong) UIBarButtonItem * leftBarBtnItem;
@property (nonatomic, strong) UIBarButtonItem * rightBarBtnItem;

// 自定义加载视图
@property (nonatomic, strong) LoadingView * loadingView;
@property (nonatomic) BOOL isLoading;
@property (nonatomic) BOOL isLoaded;

// 自定义页面布局
@property (nonatomic, strong) TabCollectionViewController * tabCVC;
@property (nonatomic, strong) ContentPageViewController * contentPVC;
@property (nonatomic, strong) NSMutableArray * tabs;
@property (nonatomic, strong) NSMutableArray * contents;

// 标签导航数据
@property (nonatomic, strong) TabModel * tabModel;
@end

@implementation HomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.leftBarButtonItem = self.leftBarBtnItem;
    self.navigationItem.rightBarButtonItem = self.rightBarBtnItem;
    
    self.isLoading = NO;
    self.isLoaded = NO;
    
    [self loadView];
    
    [self searchNet:nil];
}

- (UIBarButtonItem *)leftBarBtnItem{
    if (_leftBarBtnItem == nil){
        _leftBarBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user"] style:UIBarButtonItemStyleDone target:self action:@selector(goToUserPage)];
    }
    return _leftBarBtnItem;
}

- (UIBarButtonItem *) rightBarBtnItem {
    if (_rightBarBtnItem == nil) {
        _rightBarBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleDone target:self action:@selector(goToSearchPage)];
    }
    return _rightBarBtnItem;
}

- (LoadingView *)loadingView{
    if (_loadingView == nil){
        _loadingView = [[LoadingView alloc] init];
        [self.view addSubview:_loadingView];
        
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.view);
            make.width.height.mas_equalTo(50);
        }];
        
        [_loadingView addTarget:self action:@selector(searchNet:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadingView;
}

- (TabCollectionViewController *)tabCVC{
    if (_tabCVC == nil){
        _tabCVC = [[TabCollectionViewController alloc] init];
        
        [self.view addSubview:_tabCVC.view];
        [_tabCVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.mas_equalTo(self.view);
            make.height.mas_equalTo(60);
        }];
    }
    return _tabCVC;
}

- (ContentPageViewController *)contentPVC{
    if (_contentPVC == nil){
        _contentPVC = [[ContentPageViewController alloc] init];

        [self.view addSubview:_contentPVC.view];
        [_contentPVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tabCVC.view.mas_bottom);
            make.width.bottom.equalTo(self.view);
        }];
    }
    return _contentPVC;
}

- (NSMutableArray *)tabs{
    if (_tabs == nil){
        _tabs = [NSMutableArray array];
        
        for (NSUInteger i=0; i<[self.tabModel.len intValue]; i++){
            [_tabs addObject:self.tabModel.names[i]];
        }
    }
    return _tabs;
}

- (NSMutableArray *)contents{
    if (_contents == nil){
        _contents = [NSMutableArray array];
        for (int i=0; i<[self.tabModel.len intValue]; i++){
            NewsCollectionViewController * newsCVC = [[NewsCollectionViewController alloc] init];
            
            newsCVC.tabID = i;
            newsCVC.curNav = self.navigationController;
            
            [_contents addObject:newsCVC];
        }
    }
    return _contents;
}

- (void)searchNet:(id)btn{    
    if (self.isLoaded || self.isLoading)return;
    [self.loadingView startLoading];
    self.isLoading = YES;
    
    [[NetRequest shareInstance] GET:[BaseIP stringByAppendingString:@":8000/api/v1/news/tabs"] params:nil progress:^(id downloadProgress) {
    } success:^(id responseObject) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.loadingView stopLoading];
            self.loadingView.hidden = YES;
            self.isLoaded = YES;
            self.isLoading = NO;
            NSLog(@"Search success, data: %@", responseObject);
            self.tabModel = [[TabModel alloc] initWithDict:responseObject];
            if (self.tabModel.len){
                [self addChildViewController:self.tabCVC];
                [self addChildViewController:self.contentPVC];
                [self.tabCVC configArray:self.tabs TabWeight:120 TabHeight:50 Index:0 Block:^(NSInteger index) {
                    [self.contentPVC updateIndex:index];
                }];
                [self.contentPVC configArray:self.contents Index:0 Block:^(NSInteger index) {
                    [self.tabCVC updateIndex:index];
                }];
            }
        });
    } failues:^(id error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.loadingView stopLoading];
            self.isLoading = NO;
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"tips" message:@"无法连接到服务器，请确认网络状态" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

- (void)goToUserPage{
    [self.navigationController pushViewController:[UserViewController shareInstance] animated:YES];
}

- (void)goToSearchPage{
    [self.navigationController pushViewController:[SearchViewController new] animated:YES];
}

@end
