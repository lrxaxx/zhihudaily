//
//  NowadaysModel.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/28.
//

#import <Foundation/Foundation.h>
#import "StoriesModel.h"
#import "TopStoriesModel.h"
#import <YYModel/YYModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface NowadaysModel : NSObject <YYModel>
@property (nonatomic, copy) NSString* date;
@property (nonatomic, copy) NSArray* stories;
@property (nonatomic, copy) NSArray* top_stories;

@end

NS_ASSUME_NONNULL_END
