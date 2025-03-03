//
//  replyCommentModel.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface replyCommentModel : NSObject
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy) NSString* status;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString* author;
@property (nonatomic, assign) CGFloat titleActualH;
@property (nonatomic, assign) CGFloat titleMaxH;
@property  BOOL isOpen;
- (void)jisuan:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
