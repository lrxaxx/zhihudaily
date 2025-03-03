//
//  replyCommentModel.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/28.
//

#import "replyCommentModel.h"

@implementation replyCommentModel
- (void)jisuan:(NSString *)content {
    NSLog(@"content = %@", content);
    _content = content;
    if (content == nil || [content isEqualToString:@""]) {
        self.titleActualH = 0;
        self.titleMaxH = 0;
    } else {
        NSUInteger numCount = 2; //这是cell收起状态下期望展示的最大行数
        NSString *str = @"这是一行用来计算高度的文本";
        //这行文本也可以为一个字，但不能太长
        CGFloat W =  318 - 30; //这里是文本展示的宽度
        self.titleActualH = [content boundingRectWithSize:CGSizeMake(W, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
        self.titleMaxH = [str boundingRectWithSize:CGSizeMake(W, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height*numCount;
    }
}
@end
