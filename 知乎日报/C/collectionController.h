//
//  collectionController.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/18.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImage.h>
#import "collectionView.h"
#import "FMDB.h"
#import "collectionCell.h"
#import "TopDetailsController.h"
NS_ASSUME_NONNULL_BEGIN

@interface collectionController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSMutableArray* arrImageURL;
@property (nonatomic, copy) NSMutableArray* arrID;
@property (nonatomic, copy) NSMutableArray* arrHeadingTitle;
@property (nonatomic, copy) NSMutableArray* arrWebAPI;
@property (nonatomic, copy) NSMutableArray* arrImage;
@property (nonatomic, strong) collectionView* myView;
@property (nonatomic, strong) FMDatabase* dataBase;
@end

NS_ASSUME_NONNULL_END
