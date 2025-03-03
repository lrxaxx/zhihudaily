//
//  CommentModel.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/28.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "StoriesModel.h"
#import "TopStoriesModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentModel : NSObject <YYModel>
@property (nonatomic, copy) NSString* long_comments;
@property (nonatomic, copy) NSString* short_comments;
@property (nonatomic, copy) NSString* comments;
@property (nonatomic, copy) NSString* popularity;
@end

NS_ASSUME_NONNULL_END
