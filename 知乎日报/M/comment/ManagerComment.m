//
//  ManagerComment.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/7.
//

#import "ManagerComment.h"
static ManagerComment* managerSington = nil;
@implementation ManagerComment : NSObject

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
    return [ManagerComment shareManager];
}

- (void)URLString1:(NSString*)url NetWorkWithData: (successBlock)dataBlock error: (ErrorBlock) errorBlock
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SumCommentModel* model1 = [SumCommentModel yy_modelWithJSON:responseObject];
            dataBlock(model1);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
        }];
}

@end
