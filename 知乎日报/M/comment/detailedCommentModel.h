//
//  detailedCommentModel.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/28.
//

#import <Foundation/Foundation.h>
#import "replyCommentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface detailedCommentModel : NSObject
@property(nonatomic, strong) NSString* author;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy) NSString* avatar;
@property (nonatomic, copy) NSNumber* time;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString* likes;
@property replyCommentModel* reply_to;
@end

NS_ASSUME_NONNULL_END
