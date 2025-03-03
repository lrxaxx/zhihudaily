//
//  Manager1.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/4.
//

#import "Manager1.h"
static Manager1* managerSington = nil;
@implementation Manager1 : NSObject

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
    return [Manager1 shareManager];
}

- (void)URLString1:(NSString*)url NetWorkWithData: (dataBlock)dataBlock error: (ErrorBlock) errorBlock
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CommentModel* model = [CommentModel yy_modelWithJSON:responseObject];
            dataBlock(model);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
        }];
}

@end
