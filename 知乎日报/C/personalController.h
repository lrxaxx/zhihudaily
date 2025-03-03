//
//  personalController.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/16.
//

#import <UIKit/UIKit.h>
#import "personalView.h"
#import "collectionController.h"
NS_ASSUME_NONNULL_BEGIN

@interface personalController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) personalView* myView;
@end

NS_ASSUME_NONNULL_END
