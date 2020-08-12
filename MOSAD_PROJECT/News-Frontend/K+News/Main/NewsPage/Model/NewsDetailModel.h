
//
//  NewsDetailModel.h
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef NewsDetailModel_h
#define NewsDetailModel_h

@interface NewsDetailModel : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * body;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

#endif /* NewsDetailModel_h */
