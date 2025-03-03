//
//  SumCommentModel.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/28.
//

#import "SumCommentModel.h"

@implementation SumCommentModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"comments":[detailedCommentModel class]};
}

@end
