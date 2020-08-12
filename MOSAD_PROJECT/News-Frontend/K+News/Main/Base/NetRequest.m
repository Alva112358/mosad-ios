//
//  NetRequest.m
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetRequest.h"
#import "AFNetworking.h"

@interface NetRequest()
@property (nonatomic, strong) AFHTTPSessionManager * mgr;
@end

@implementation NetRequest

static id _instance;

+ (id)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (AFHTTPSessionManager *)mgr{
    if (_mgr == nil){
        _mgr = [[AFHTTPSessionManager alloc] init];
        _mgr.completionQueue = dispatch_get_global_queue(0, 0);
        _mgr.requestSerializer = [AFJSONRequestSerializer serializer];
        _mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _mgr;
}

- (void)GET:(NSString *)url
     params:(NSMutableDictionary *)params
   progress:(void (^)(id downloadProgress))progress
    success:(void (^)(id responseObject))success
    failues:(void (^)(id error))failure{
    [self.mgr GET:url
  parameters:params
    progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)SynGET:(NSString *)url
        params:(NSMutableDictionary *)params
      progress:(void (^)(id))progress
       success:(void (^)(id))success
       failues:(void (^)(id))failure{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    [self GET:url
       params:params
     progress:^(id downloadProgress) {
        progress(downloadProgress);
    } success:^(id responseObject) {
        success(responseObject);
        dispatch_semaphore_signal(sema);
    } failues:^(id error) {
        failure(error);
        dispatch_semaphore_signal(sema);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

- (void)POST:(NSString *)url
      params:(NSMutableDictionary *)params
    progress:(void (^)(id downloadProgress))progress
     success:(void (^)(id responseObject))success
     failues:(void (^)(id error))failure{
      [self.mgr POST:url
    parameters:params
      progress:^(NSProgress * downloadProgress) {
          progress(downloadProgress);
      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          success(responseObject);
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          failure(error);
      }];
}

@end
