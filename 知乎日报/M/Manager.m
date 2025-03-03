//
//  Manager.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/10/31.
//

#import "Manager.h"
static Manager* managerSington = nil;
@implementation Manager

+ (instancetype)shareManager {
    if (!managerSington) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            managerSington = [[super allocWithZone:NULL] init];
        });
    }
    return managerSington;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [Manager shareManager];
}

- (void)URLString:(NSString*)url NetWorkWithData: (DataBlock)dataBlock error: (ErrorBlock) errorBlock
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NowadaysModel* model = [NowadaysModel yy_modelWithJSON:responseObject];
            dataBlock(model);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
        }];
}

@end
