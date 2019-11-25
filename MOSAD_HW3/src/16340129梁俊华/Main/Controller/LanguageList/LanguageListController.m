//
//  LanguageListController.m
//  16340129梁俊华
//
//  Created by 梁俊华 on 2019/9/28.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LanguageListController.h"


// extense class.
@interface LanguageListController() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@end

// implement class.
@implementation LanguageListController

@synthesize dataSource = _dataSource;
// @synthesize language = _language;

- (void)viewDidLoad {
    _dataSource = [@[
        @{@"Name" : @"TOUR 1",
          @"List" : @[@"unit 1", @"unit 2", @"unit 3", @"unit 4"]},
        @{@"Name" : @"TOUR 2",
          @"List" : @[@"unit 1", @"unit 2", @"unit 3", @"unit 4"]},
        @{@"Name" : @"TOUR 3",
          @"List" : @[@"unit 1", @"unit 2", @"unit 3", @"unit 4"]},
        @{@"Name" : @"TOUR 4",
          @"List" : @[@"unit 1", @"unit 2", @"unit 3", @"unit 4"]},
        @{@"Name" : @"TOUR 5",
          @"List" : @[@"unit 1", @"unit 2", @"unit 3", @"unit 4"]},
        @{@"Name" : @"TOUR 6",
          @"List" : @[@"unit 1", @"unit 2", @"unit 3", @"unit 4"]},
        @{@"Name" : @"TOUR 7",
          @"List" : @[@"unit 1", @"unit 2", @"unit 3", @"unit 4"]},
        @{@"Name" : @"TOUR 8",
          @"List" : @[@"unit 1", @"unit 2", @"unit 3", @"unit 4"]},
    ] mutableCopy];
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

// 重写 dataSource 的 getter 方法.
- (void)setDataSource:(NSArray<NSMutableDictionary *> *)dataSource {
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        [self.tableView reloadData];
    }
}

// 重写 tableView 的 getter 方法.
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark UITableViewDataSource
// Total sections = 8.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_dataSource count];
}

// Rows for each section = 4.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource[section][@"List"] count];
}

// Titles for each section.
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _dataSource[section][@"Name"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    NSArray * List = _dataSource[indexPath.section][@"List"];
    cell.textLabel.text = List[indexPath.row];
    return cell;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark) {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    } else {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

@end
