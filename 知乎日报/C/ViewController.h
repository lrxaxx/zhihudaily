//
//  ViewController.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/10/31.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImage.h>
#import <WebKit/WebKit.h>
#import <libkern/OSAtomic.h>
#import "mainView.h"
#import "Celllun.h"
#import "Manager.h"
#import "CellShow.h"
#import "DetailsController.h"
#import "TopDetailsController.h"
#import "personalController.h"
#import "FMDB.h"
@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) mainView* mainView;
@property (nonatomic, copy) NSMutableArray* arrStories;
@property (nonatomic, copy) NSMutableArray* arrTopStories;
@property (nonatomic, copy) NSMutableArray* arrImage;
@property (nonatomic, copy) NSMutableArray* arrTopImage;
@property (nonatomic, copy) NSMutableArray* arrURL;
@property (nonatomic, copy) NSMutableArray* arryopurl;
@property  BOOL action;
@property (nonatomic, copy) NSMutableArray* arrDate;
@property (nonatomic, strong) FMDatabase* dataBase;
@end
