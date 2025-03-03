//
//  ManagerComment.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/7.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import <AFNetworking/AFNetworking.h>
#import "SumCommentModel.h"
typedef void (^successBlock)(SumCommentModel * _Nonnull mainModel);
typedef void (^ErrorBlock)(NSError * _Nonnull error);
NS_ASSUME_NONNULL_BEGIN

@interface ManagerComment : NSObject
+(instancetype) shareManager;
- (void)URLString1:(NSString*)url NetWorkWithData: (successBlock)dataBlock error: (ErrorBlock) errorBlock;
@end

NS_ASSUME_NONNULL_END
