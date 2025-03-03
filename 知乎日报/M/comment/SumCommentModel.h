//
//  SumCommentModel.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/28.
//

#import <Foundation/Foundation.h>
#import "detailedCommentModel.h"
#import <YYModel/YYModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface SumCommentModel : NSObject <YYModel>
@property (nonatomic, strong) NSArray* comments;
@end

NS_ASSUME_NONNULL_END
