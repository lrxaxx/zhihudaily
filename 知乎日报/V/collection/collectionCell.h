//
//  collectionCell.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/18.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface collectionCell : UITableViewCell
@property (nonatomic, strong) UILabel* mainTitle;
@property (nonatomic, strong) UIImageView* image;
@end

NS_ASSUME_NONNULL_END
