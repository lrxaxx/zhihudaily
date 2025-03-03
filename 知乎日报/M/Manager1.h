//
//  Manager1.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/4.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import <AFNetworking/AFNetworking.h>
#import "CommentModel.h"
typedef void (^dataBlock)(CommentModel * _Nonnull mainModel);
typedef void (^ErrorBlock)(NSError * _Nonnull error);
NS_ASSUME_NONNULL_BEGIN

@interface Manager1 : NSObject
+(instancetype) shareManager;
- (void)URLString1:(NSString*)url NetWorkWithData: (dataBlock)dataBlock error: (ErrorBlock) errorBlock;
@end

NS_ASSUME_NONNULL_END
