//
//  personalController.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/16.
//

#import "personalController.h"

@interface personalController ()

@end

@implementation personalController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!_myView) {
        _myView = [[personalView alloc] init];
    }
    [_myView InitTable];
    [_myView InitTableView];
    [self.view addSubview:_myView];
    _myView.frame = self.view.bounds;
    _myView.tableview.delegate = self;
    _myView.tableview.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellStr = @"cell";
    UITableViewCell* cell = [_myView.tableview dequeueReusableCellWithIdentifier:cellStr];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    if(indexPath.row == 0) {
        cell.textLabel.text = @"我的收藏";
    } else {
        cell.textLabel.text = @"消息中心";
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        collectionController* collection = [[collectionController alloc] init];
        [self.navigationController pushViewController:collection animated:YES];
    }
}

@end
