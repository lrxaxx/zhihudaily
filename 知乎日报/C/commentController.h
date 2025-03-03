//
//  commentController.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/7.
//

#import <UIKit/UIKit.h>
#import "commentView.h"
#import "ManagerComment.h"
#import "SumCommentModel.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>
#import "commentView.h"
#import "CommentCell.h"
#import <SDWebImage/SDWebImage.h>
#import "replyCommentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface commentController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSString* sumcomment;
@property (nonatomic, strong) NSMutableArray* arrShort;
@property (nonatomic, strong) NSMutableArray* arrLong;
@property (nonatomic, strong) NSMutableArray* arrImage;
@property (nonatomic, strong) commentView* commentview;
//@property (nonatomic, strong) Modelcomment_reply_to* model;
@property int commentcount;
@end

NS_ASSUME_NONNULL_END
