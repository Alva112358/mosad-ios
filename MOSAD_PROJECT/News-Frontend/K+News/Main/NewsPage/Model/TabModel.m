//
//  TabModel.m
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TabModel.h"

@implementation TabModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self){
        self.len = [dict objectForKey:@"len"];
        self.names = [dict objectForKey:@"names"];
    }
    return self;
}

@end
