//
//  personalView.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/16.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface personalView : UIView 
@property (nonatomic, strong) UIImageView* personalImage;
@property (nonatomic, strong) UIButton* btnType;
@property (nonatomic, strong) UIButton* btnSetting;
@property (nonatomic, strong) UITableView* tableview;
@property (nonatomic, strong) UILabel* myName;
-(void) InitTable;
-(void) InitTableView;
@end

NS_ASSUME_NONNULL_END
