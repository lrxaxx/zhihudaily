//
//  CommentCell.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/28.
//

#import "CommentCell.h"

@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if([self.reuseIdentifier isEqualToString:@"Cellcomment"]) {
        [self InitAll];
        [self Masorny_widget];
        [self setting_widget];
    }
    return self;
}

-(void) InitAll {
    _good = [[UIButton alloc] init];
    _time = [[UILabel alloc] init];
    _extra = [[UIButton alloc] init];
    _comment = [[UIButton alloc] init];
    _profile = [[UIImageView alloc] init];
    _mainComment = [[UILabel alloc] init];
    _auxComment = [[UITextView alloc] init];
    _name = [[UILabel alloc] init];
    
    [self.contentView addSubview:_good];
    [self.contentView addSubview:_time];
    [self.contentView addSubview:_extra];
    [self.contentView addSubview:_comment];
    [self.contentView addSubview:_profile];
    [self.contentView addSubview:_mainComment];
    [self.contentView addSubview:_auxComment];
    [self.contentView addSubview:_name];
}

-(void) Masorny_widget {
    [_profile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.width.and.height.equalTo(@36);
    }];
    
    [_extra mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_profile.mas_top);
        make.right.equalTo(self.contentView).offset(-20);
        make.width.and.height.equalTo(@16);
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(55);
        make.top.equalTo(self.contentView).offset(10);
        make.width.equalTo(@150);
        make.height.mas_offset(25);
    }];
    
    [_mainComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name.mas_left);
        make.top.equalTo(_profile.mas_bottom).offset(-10);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name.mas_left);
        make.top.equalTo(_auxComment.mas_bottom).offset(10);
        make.width.mas_offset(80);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [_comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_auxComment.mas_bottom);
        make.right.equalTo(self.contentView).offset(-20);
        make.width.and.height.equalTo(@18);
    }];
    
    [_good mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_auxComment.mas_bottom);
        make.right.equalTo(self.contentView).offset(-100);
        make.width.mas_offset(50);
        make.height.mas_offset(18);
    }];
    
    [_auxComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainComment.mas_left);
        make.top.equalTo(_mainComment.mas_bottom);
        make.right.equalTo(_mainComment.mas_right);
    }];
}

-(void) setting_widget {
    _profile.contentMode = UIViewContentModeScaleAspectFill; // 设置内容模式
    _profile.clipsToBounds = YES; // 确保内容不超出边界
    _profile.layer.cornerRadius = 18;
    _profile.layer.masksToBounds = YES;
    
    _name.numberOfLines = 0;
    
    _mainComment.font = [UIFont systemFontOfSize:16];
    _mainComment.numberOfLines = 0;
    
    _time.font = [UIFont systemFontOfSize:12];
    _time.textColor = [UIColor grayColor];
    
    _auxComment.font = [UIFont systemFontOfSize:16];
    _auxComment.scrollEnabled = NO;
    _auxComment.editable = NO;
//    _aux_comment.selectable = NO;
    _auxComment.delegate = self;
    _auxComment.textColor = [UIColor grayColor];
    
    [_extra setImage:[UIImage imageNamed:@"三个点点.png"] forState:UIControlStateNormal];
    
    [_comment setImage:[UIImage imageNamed:@"评论.png"] forState:UIControlStateNormal];
    
    _good.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_good setTitle:@"" forState:UIControlStateNormal];
    [_good setImage:[UIImage imageNamed:@"点赞.png"] forState:UIControlStateNormal];
    [_good setFont:[UIFont systemFontOfSize:12]];
    [_good setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    // 设置图片和文字的边距
//    CGFloat spacing = 8.0; // 图片和文字之间的间距
    _good.imageEdgeInsets = UIEdgeInsetsMake(0, 18, 0, -18);
    _good.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
}

- (void)setupCellData:(replyCommentModel *)model {
    
    NSString *suffixStr = @""; //添加的后缀按钮文本（收起或展开）
    NSString *contentStr = model.content;
    CGFloat H = model.titleActualH; //文本的高度，默认为实际高度
    
    if (model.titleActualH > model.titleMaxH) {
        //文本实际高度>最大高度，需要添加后缀
        if (model.isOpen) {
            //文本已经展开，此时后缀为“收起”按钮
            suffixStr = @"收起";
            contentStr = [NSString stringWithFormat:@"%@ %@", contentStr, suffixStr];
            H = model.titleActualH;
        } else {
            NSLog(@"就是NO");
            //文本已经收起，此时后缀为“展开/全文”按钮
            //需要对文本进行截取，将“...展开”添加到我们限制的展示文字的末尾
            NSUInteger numCount = 2; //这是cell收起状态下期望展示的最大行数
            CGFloat W = 318 - 30; //这里是文本展示的宽度
            NSString *tempStr = [self stringByTruncatingString:contentStr suffixStr:@"...展开" font:[UIFont systemFontOfSize:16] forLength:W*numCount];
            NSLog(@"tempStr = %@", tempStr);
            contentStr = tempStr;
            suffixStr = @"展开";
            H = model.titleMaxH;
        }
    }

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    self.auxComment.linkTextAttributes = @{};
    
    //给富文本的后缀添加点击事件
    if (suffixStr != nil && suffixStr.length > 0){
        NSRange range3 = [contentStr rangeOfString:suffixStr];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor systemBlueColor]range:range3];//[UIColor colorWithHexString:@"#000000"]
        NSString *valueString3 = [[NSString stringWithFormat:@"didOpenClose://%@", suffixStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        [attStr addAttribute:NSLinkAttributeName value:valueString3 range:range3];
    }
    self.auxComment.attributedText = attStr;
}


- (NSString *)stringByTruncatingString:(NSString *)str suffixStr:(NSString *)suffixStr font:(UIFont *)font forLength:(CGFloat)length {
    if (!str) return nil; // 如果 str 为 nil，返回 nil
    if (![str isKindOfClass:[NSString class]]) return nil; // 确保 str 是 NSString 类型

    // 从字符串的长度开始，逐步截断
    for (NSInteger i = str.length; i > 0; i--) {
        NSString *tempStr = [str substringToIndex:i];
        CGSize size = [tempStr sizeWithAttributes:@{NSFontAttributeName: font}];
        
        // 检查截断后的字符串宽度
        if (size.width < length) {
            // 添加 suffixStr
            NSString *resultStr = [tempStr stringByAppendingString:suffixStr];
            CGSize resultSize = [resultStr sizeWithAttributes:@{NSFontAttributeName: font}];

            // 如果加上后缀后的宽度也在限制内
            if (resultSize.width < length) {
                return resultStr; // 返回最终字符串
            }
        }
    }
    
    // 如果没有找到合适的截断位置，返回原字符串或处理为空的情况
    return suffixStr; // 如果所有情况都不满足，返回后缀
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"didOpenClose"]) {
        //点击了“展开”或”收起“，通过代理或者block回调，让持有tableView的控制器去刷新单行Cell
        if (self.openCloseBlock) {
            self.openCloseBlock();
        }
        return NO;
    }
    return YES;
}

- (void)setOpenCloseBlock:(OpenCloseBlock)block {
    _openCloseBlock = block; // 保存块
}



@end
