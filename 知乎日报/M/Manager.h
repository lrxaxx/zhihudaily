//
//  Manager.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/10/31.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import <AFNetworking/AFNetworking.h>
#import "NowadaysModel.h"
typedef void (^DataBlock)(NowadaysModel * _Nonnull mainModel);
typedef void (^ErrorBlock)(NSError * _Nonnull error);
NS_ASSUME_NONNULL_BEGIN

@interface Manager : NSObject
+(instancetype) shareManager;
- (void)URLString:(NSString*)url NetWorkWithData: (DataBlock)dataBlock error: (ErrorBlock) errorBlock;
@end

NS_ASSUME_NONNULL_END
