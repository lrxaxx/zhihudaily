//
//  commentView.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/7.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface commentView : UIView
@property (nonatomic, strong) UITableView* tableview;

-(void) InitTableView;
@end

NS_ASSUME_NONNULL_END
