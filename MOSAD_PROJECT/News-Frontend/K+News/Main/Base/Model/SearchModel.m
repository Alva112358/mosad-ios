//
//  SearchModel.m
//  News
//
//  Created by tplish on 2020/1/5.
//  Copyright © 2020 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchModel.h"

@interface SearchModel()

@end

@implementation SearchModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self){
        self.title = dict[@"title"];
        self.tag = dict[@"tag"];
        self.detailUrl = dict[@"detail_url"];
    }
    return self;
}

@end
