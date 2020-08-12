//
//  SearchViewController.m
//  News
//
//  Created by tplish on 2020/1/5.
//  Copyright © 2020 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchViewController.h"
#import "NewsDetailViewController.h"
#import "TableViewCell.h"
#import "SearchModel.h"
#import "Masonry.h"

#import "GlobalVariable.h"
#import "NetRequest.h"

@interface SearchViewController()
<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    TableViewCell * _cell;
}
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * resArr;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
    }];
}

- (UISearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        _searchBar.showsCancelButton = YES;
        _searchBar.placeholder=@"搜索一下";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
        _tableView.tableHeaderView = self.searchBar;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)resArr{
    if (_resArr == nil){
        _resArr = [NSMutableArray array];
        SearchModel * model = [SearchModel new];
        model.title = @"这里空空如也";
        model.detailUrl = @"";
        [_resArr addObject:model];
    }
    return _resArr;
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    
    _cell.textLabel.text = [self.resArr[indexPath.row] title];
    return _cell;
}

#pragma mark UISearchBar

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"Will search text: %@", searchBar.text);
    
    [self.resArr removeAllObjects];
    
    NSString * url = [BaseIP stringByAppendingFormat:@":8000/api/v1/search"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"text"] = searchBar.text;
    params[@"count"] = @8;
    [[NetRequest shareInstance] GET:url params:params progress:^(id downloadProgress) {
    } success:^(id responseObject) {
        NSArray * data = [responseObject objectForKey:@"result"];
        for (NSUInteger i=0; i<data.count; i++){
            SearchModel * model = [[SearchModel alloc] initWithDict:data[i]];
            [self.resArr addObject:model];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (self.resArr.count == 0){
                SearchModel * model = [[SearchModel alloc] init];
                model.title = @"找不到呢";
                model.detailUrl = @"";
                [self.resArr addObject:model];
            }
            [self.tableView reloadData];
        });
        NSLog(@"Search request result: %@", data);
    } failues:^(id error) {
        SearchModel * model = [[SearchModel alloc] init];
        model.title = @"找不到呢";
        model.detailUrl = @"";
        [self.resArr addObject:model];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        NSLog(@"Search failed, err: %@", error);
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([[self.resArr[indexPath.row] detailUrl] isEqual:@""])return;
    
    NewsDetailViewController * detailVC = [[NewsDetailViewController alloc] init];
    detailVC.detailUrl = [self.resArr[indexPath.row] detailUrl];
    detailVC.curNav = self.navigationController;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
