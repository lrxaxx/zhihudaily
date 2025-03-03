//
//  mainView.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/10/31.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface mainView : UIView
@property (nonatomic, strong) UITableView* tableview;
@property (nonatomic, strong) UIActivityIndicatorView* active;
@property (nonatomic, strong) UILabel* month;
@property (nonatomic, strong) UILabel* day;
@property (nonatomic, strong) UIImageView* photo;
@property (nonatomic, strong) UILabel* hello;
//@property (nonatomic, strong)

@end

NS_ASSUME_NONNULL_END
