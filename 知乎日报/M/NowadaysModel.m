//
//  NowadaysModel.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/28.
//

#import "NowadaysModel.h"

@implementation NowadaysModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"stories":[StoriesModel class],@"top_stories":[TopStoriesModel class]};
}

@end
