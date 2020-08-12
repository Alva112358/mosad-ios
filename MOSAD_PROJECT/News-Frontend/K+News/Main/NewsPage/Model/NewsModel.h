//
//  NewsModel.h
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef NewsModel_h
#define NewsModel_h

@interface NewsModel : NSObject

@property (nonatomic) NSNumber * ID;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSArray * imageLinks;
@property (nonatomic, strong) NSString * detailUrl;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

#endif /* NewsModel_h */
