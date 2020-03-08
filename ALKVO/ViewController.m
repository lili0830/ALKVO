//
//  ViewController.m
//  ALKVO
//
//  Created by 李丽 on 2020/2/22.
//  Copyright © 2020 李丽. All rights reserved.
//

#import "ViewController.h"
#import "ALBaseKVOAutoViewController.h"
#import "ALBaseKVOManualViewController.h"
#import "ALBaseKVOAttriDependViewController.h"
#import "ALBaseKVOContainerClassViewController.h"
#import "ALDefineKVOViewController.h"
#import "ALDefineKVOBlockViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *dataList;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"KVO";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    _dataList = @[@"基础KVO-自动监听", @"基础KVO-手动监听", @"基础KVO-属性依赖", @"基础KVO-容器类观察", @"自定义KVO", @"Block形式KVO"];
    [_tableView reloadData];

}

// MARK: - UITableViewDelegate、UItableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *cellIndentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.textLabel.text = _dataList[indexPath.row];
    return cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = nil;
    if (indexPath.row == 0) {
        vc = [[ALBaseKVOAutoViewController alloc] init];
    } else if (indexPath.row == 1) {
        vc = [[ALBaseKVOManualViewController alloc] init];
    } else if (indexPath.row == 2) {
        vc = [[ALBaseKVOAttriDependViewController alloc] init];
    } else if (indexPath.row == 3) {
        vc = [[ALBaseKVOContainerClassViewController alloc] init];
    } else if (indexPath.row == 4) {
        vc = [[ALDefineKVOViewController alloc] init];
    } else {
        vc = [[ALDefineKVOBlockViewController alloc] init];
    }
    [self.navigationController pushViewController:vc animated:true];

}


@end
