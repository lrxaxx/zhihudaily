//
//  commentController.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/7.
//

#import "commentController.h"
@interface commentController ()

@end

@implementation commentController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.sumcomment);
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.toolbarHidden = YES;
    NSString* str_Long  = @"https://news-at.zhihu.com/api/4/story//long-comments";
    NSMutableString* Long = [self gainKPI:str_Long andid:_sumcomment];
    _arrLong = [NSMutableArray array];
    _arrShort = [NSMutableArray array];
    _arrImage = [NSMutableArray array];
    if(!_commentview) {
        _commentview = [[commentView alloc] init];
    }
    [self settingNav];
    [self gainComment:Long];
    
}

-(void) settingNav {
    NSString* str = [NSString stringWithFormat:@"%d条评论", _commentcount];
    self.title = str;
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"返回.png"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void) back {
    self.navigationController.toolbarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableString*) gainKPI:(NSString*) url andid: (NSString*) urlid {
    // 创建可变字符串
    NSMutableString *mutableURL = [NSMutableString stringWithString:url];
    // 查找第一个和第二个 `//` 的位置
    NSUInteger firstSlashRange = [mutableURL rangeOfString:@"//"].location;
    NSUInteger secondSlashRange = [mutableURL rangeOfString:@"//" options:0 range:NSMakeRange(firstSlashRange + 2, mutableURL.length - (firstSlashRange + 2))].location;
    // 计算插入位置
    NSUInteger insertIndex = secondSlashRange + 1; // 插入到第二个 `//` 之后
    // 插入字符串
    if (insertIndex != NSNotFound) {
        [mutableURL insertString:[NSString stringWithFormat:@"%@", urlid] atIndex:insertIndex];
    }
    // 输出结果
    NSLog(@"%@", mutableURL);
    return mutableURL;
}

-(void) gainComment:(NSMutableString*) url  {
    id manager = [ManagerComment shareManager];
    [manager URLString1:url NetWorkWithData:^(SumCommentModel * _Nonnull mainModel) {
        NSDictionary* dic = [mainModel yy_modelToJSONObject];
        // 在主线程中更新 UI
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray* arr = dic[@"comments"];
            self->_arrLong = [arr mutableCopy];
            if(self->_arrLong.count == 0) {
                NSLog(@"没有");
            } else
            NSLog(@"long = %@", self->_arrLong);
            NSMutableString* str_Short = [NSMutableString stringWithString: @"https://news-at.zhihu.com/api/4/story//short-comments"];
            NSMutableString* Short = [self gainKPI:str_Short andid:self->_sumcomment];
            [self gainComment1:Short];
        });
    } error:^(NSError * _Nonnull error) {
        NSLog(@"error:%@", error.localizedDescription);
    }];
}

-(void) gainComment1:(NSMutableString*) url  {
    id manager = [ManagerComment shareManager];
    [manager URLString1:url NetWorkWithData:^(SumCommentModel * _Nonnull mainModel) {
        NSDictionary* dic = [mainModel yy_modelToJSONObject];
        // 在主线程中更新 UI
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray* arr = dic[@"comments"];
            self->_arrShort = [arr mutableCopy];
            NSLog(@"short = %@", self->_arrShort);
            [self Inittableview];
        });
    } error:^(NSError * _Nonnull error) {
        NSLog(@"error:%@", error.localizedDescription);
    }];
}


-(void) Inittableview {
    [self.view addSubview:_commentview];
    [_commentview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top).offset(98);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self.commentview InitTableView];
    self.commentview.tableview.delegate = self;
    _commentview.tableview.dataSource = self;
    _commentview.tableview.allowsSelection = NO;
    self.commentview.tableview.estimatedRowHeight = 50;
    _commentview.tableview.rowHeight = UITableViewAutomaticDimension;
    [_commentview.tableview registerClass:[CommentCell class] forCellReuseIdentifier:@"Cellcomment"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(_arrLong.count == 0) {
        NSString* str = [NSString stringWithFormat:@"%ld条短评",_arrShort.count];
        return str;
    } else {
        if(section == 0) {
            NSString* str = [NSString stringWithFormat:@"%ld条长评",_arrLong.count];
            return str;
        } else {
            NSString* str = [NSString stringWithFormat:@"%ld条短评",_arrShort.count];
            return str;
        }
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    if(_arrLong.count == 0) {
//        NSString* str = @"已展示全部评论";
//        return str;
//    } else {
//        if(section == 1) {
//            NSString* str = @"已展示全部评论";
//            return str;
//        } else
//            return nil;
//    }
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(_arrLong.count == 0)
        return 1;
    else
        return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_arrLong.count == 0) {
        return _arrShort.count;
    } else {
        if(section == 0)
            return _arrLong.count;
        else
            return _arrShort.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld %ld", indexPath.section, indexPath.row);
    CommentCell* cell = [_commentview.tableview cellForRowAtIndexPath:indexPath];
    if(!cell) {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cellcomment"];
    }
    if(_arrLong.count != 0) {
        if(indexPath.section == 0) {
            NSURL *imageurl = [NSURL URLWithString:_arrLong[indexPath.row][@"avatar"]];
            [cell.profile sd_setImageWithURL:imageurl
        placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                 options:SDWebImageRefreshCached
                                   completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (error) {
                    NSLog(@"加载图片失败: %@", error.localizedDescription);
                } else {
                    NSLog(@"图片加载成功");
                }
            }];
            cell.name.text = _arrLong[indexPath.row][@"author"];
            cell.mainComment.text = _arrLong[indexPath.row][@"content"];
            cell.time.text = [self convertTimestampToString:_arrLong[indexPath.row][@"time"]];
            if([_arrLong[indexPath.row] objectForKey:@"reply_to"] != nil) {
                replyCommentModel* model = [replyCommentModel yy_modelWithDictionary:_arrLong[indexPath.row][@"reply_to"]];
                if([model isKindOfClass:[replyCommentModel class]]) {
                    NSLog(@"true");
                } else {
                    NSLog(@"model class = %@", [model class]);
                }
                NSMutableString *str = [NSMutableString stringWithString:@"//"]; // 使用 stringWithString 初始化
                [str appendFormat:@"%@", model.author]; // 追加作者
                [str appendFormat:@"："]; // 追加冒号
                [str appendFormat:@"%@", model.content];
                [model jisuan:str];
                NSLog(@"高度 = %f", model.titleActualH);
                NSLog(@"第%ld组，第%ld个", indexPath.section, indexPath.row);
                [cell setupCellData:model];
                [cell setOpenCloseBlock:^{
                    NSMutableDictionary *replyTo = self->_arrLong[indexPath.row][@"reply_to"];
                    // 获取当前的 isOpen 值
                    NSNumber *currentValue = replyTo[@"isOpen"];
                    BOOL isOpen = [currentValue boolValue]; // 转换为 BOOL
                    // 反转 isOpen 的值并存储回字典
                    replyTo[@"isOpen"] = @( !isOpen );
                    [self->_commentview.tableview beginUpdates];
                    [self->_commentview.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    [self->_commentview.tableview endUpdates];
                    
                }];
                
            } else {
                [cell.auxComment mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@0); // 设置高度为 0
                }];
            }
            if([_arrLong[indexPath.row][@"likes"] intValue] != 0) {
                [cell.good setTitle:[NSString stringWithFormat:@"%@", _arrLong[indexPath.row][@"likes"]] forState:UIControlStateNormal];
            }
        } else {
            NSURL *imageurl = [NSURL URLWithString:_arrShort[indexPath.row][@"avatar"]];
            [cell.profile sd_setImageWithURL:imageurl
        placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                 options:SDWebImageRefreshCached
                                   completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (error) {
                    NSLog(@"加载图片失败: %@", error.localizedDescription);
                } else {
                    NSLog(@"图片加载成功");
                }
            }];
            cell.name.text = _arrShort[indexPath.row][@"author"];
            cell.mainComment.text = _arrShort[indexPath.row][@"content"];
            cell.time.text = [self convertTimestampToString:_arrShort[indexPath.row][@"time"]];
            if([_arrShort[indexPath.row] objectForKey:@"reply_to"] != nil) {

                replyCommentModel* model = [replyCommentModel yy_modelWithDictionary:_arrShort[indexPath.row][@"reply_to"]];
                if([model isKindOfClass:[replyCommentModel class]]) {
                    NSLog(@"true");
                } else {
                    NSLog(@"model class = %@", [model class]);
                }
                NSMutableString *str = [NSMutableString stringWithString:@"//"]; // 使用 stringWithString 初始化
                [str appendFormat:@"%@", model.author]; // 追加作者
                [str appendFormat:@"："]; // 追加冒号
                [str appendFormat:@"%@", model.content];
                [model jisuan:str];
                NSLog(@"高度 = %f", model.titleActualH);
                NSLog(@"第%ld组，第%ld个", indexPath.section, indexPath.row);
                [cell setupCellData:model];
                [cell setOpenCloseBlock:^{
                    NSMutableDictionary *replyTo = self->_arrShort[indexPath.row][@"reply_to"];
                    // 获取当前的 isOpen 值
                    NSNumber *currentValue = replyTo[@"isOpen"];
                    BOOL isOpen = [currentValue boolValue]; // 转换为 BOOL
                    // 反转 isOpen 的值并存储回字典
                    replyTo[@"isOpen"] = @( !isOpen );
                    [self->_commentview.tableview beginUpdates];
                    [self->_commentview.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    [self->_commentview.tableview endUpdates];
                    
                }];
                
            } else {
                [cell.auxComment mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(@0); // 设置高度为 0
                    }];
            }
            if([_arrShort[indexPath.row][@"likes"] intValue] != 0) {
                [cell.good setTitle:[NSString stringWithFormat:@"%@", _arrShort[indexPath.row][@"likes"]] forState:UIControlStateNormal];
            }
        }
    } else {
        NSURL *imageurl = [NSURL URLWithString:_arrShort[indexPath.row][@"avatar"]];
        [cell.profile sd_setImageWithURL:imageurl
    placeholderImage:[UIImage imageNamed:@"placeholder.png"]
             options:SDWebImageRefreshCached
                               completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                NSLog(@"加载图片失败: %@", error.localizedDescription);
            } else {
                NSLog(@"图片加载成功");
            }
        }];
        cell.name.text = _arrShort[indexPath.row][@"author"];
        cell.mainComment.text = _arrShort[indexPath.row][@"content"];
        cell.time.text = [self convertTimestampToString:_arrShort[indexPath.row][@"time"]];
        if([_arrShort[indexPath.row] objectForKey:@"reply_to"] != nil) {
            replyCommentModel* model = [replyCommentModel yy_modelWithDictionary:_arrShort[indexPath.row][@"reply_to"]];
            if([model isKindOfClass:[replyCommentModel class]]) {
                NSLog(@"true");
            } else {
                NSLog(@"model class = %@", [model class]);
            }
            NSMutableString *str = [NSMutableString stringWithString:@"//"]; // 使用 stringWithString 初始化
            [str appendFormat:@"%@", model.author]; // 追加作者
            [str appendFormat:@"："]; // 追加冒号
            [str appendFormat:@"%@", model.content];
            [model jisuan:str];
            NSLog(@"高度 = %f", model.titleActualH);
            NSLog(@"第%ld组，第%ld个", indexPath.section, indexPath.row);
            [cell setupCellData:model];
            [cell setOpenCloseBlock:^{
                NSMutableDictionary *replyTo = self->_arrShort[indexPath.row][@"reply_to"];
                // 获取当前的 isOpen 值
                NSNumber *currentValue = replyTo[@"isOpen"];
                BOOL isOpen = [currentValue boolValue]; // 转换为 BOOL
                // 反转 isOpen 的值并存储回字典
                replyTo[@"isOpen"] = @( !isOpen );
                [self->_commentview.tableview beginUpdates];
                [self->_commentview.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [self->_commentview.tableview endUpdates];
                
            }];
            
        } else {
            [cell.auxComment mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@0); // 设置高度为 0
                }];
        }
        if([_arrShort[indexPath.row][@"likes"] intValue] != 0) {
            [cell.good setTitle:[NSString stringWithFormat:@"%@", _arrShort[indexPath.row][@"likes"]] forState:UIControlStateNormal];
        }
    }
    return cell;
}

-(NSString*)convertTimestampToString:(NSNumber *)timestamp {
    // 将 NSNumber 转换为 NSInteger
    NSInteger timeInterval = [timestamp integerValue];
    // 创建 NSDate 对象
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    // 创建 NSDateFormatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"]; // 设置格式
    // 将 NSDate 转换为字符串
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

@end
