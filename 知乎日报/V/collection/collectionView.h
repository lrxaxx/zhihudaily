//
//  collectionView.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/18.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface collectionView : UIView
@property (nonatomic, strong) UITableView* tableView;
-(void) InitTableView;
@end

NS_ASSUME_NONNULL_END
