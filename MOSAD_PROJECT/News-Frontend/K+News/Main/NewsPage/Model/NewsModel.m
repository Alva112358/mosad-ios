//
//  NewsModel.m
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"

@implementation NewsModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self){
        self.ID = dict[@"id"];
        self.title = dict[@"title"];
        self.imageLinks = dict[@"image_links"];
        self.detailUrl = dict[@"detail_url"];
    }
    return self;
}

@end
