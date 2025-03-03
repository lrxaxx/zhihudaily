//
//  CommentCell.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/28.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "replyCommentModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void (^OpenCloseBlock)(void);
@interface CommentCell : UITableViewCell <UITextViewDelegate>
@property (nonatomic, strong) UIImageView* profile;
@property (nonatomic, strong) UILabel* name;
@property (nonatomic, strong) UILabel* mainComment;
@property (nonatomic, strong) UITextView* auxComment;
@property (nonatomic, strong) UIButton* extra;
@property (nonatomic, strong) UILabel* time;
@property (nonatomic, strong) UIButton* good;
@property (nonatomic, strong) UIButton* comment;
@property (nonatomic, copy) OpenCloseBlock openCloseBlock;

// 声明设置块的方法
- (void)setOpenCloseBlock:(OpenCloseBlock)block;
- (NSString*)stringByTruncatingString:(NSString *)str suffixStr:(NSString *)suffixStr font:(UIFont *)font forLength:(CGFloat)length;
- (void)setupCellData:(replyCommentModel *)model;
@end

NS_ASSUME_NONNULL_END

