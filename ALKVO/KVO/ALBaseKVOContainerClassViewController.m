//
//  ALBaseKVOContainerClassViewController.m
//  ALKVO
//
//  Created by 李丽 on 2020/2/23.
//  Copyright © 2020 李丽. All rights reserved.
//
// 容器类的监听 array set dictionary 等
#import "ALBaseKVOContainerClassViewController.h"
#import "Person.h"

@interface ALBaseKVOContainerClassViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation ALBaseKVOContainerClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.title = @"容器类监听";
    _person = [[Person alloc] init];
    [self registerObserver];
}

// 注册观察者
- (void)registerObserver {
    [_person addObserver:self forKeyPath:@"array" options:(NSKeyValueObservingOptionNew) context:nil];
}
// 接受事件
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"change = %@", change);
}
// 触发容器类监听
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // [_person.array addObject:@"aa"] ,直接给 array 添加元素，是不会触发监听的
    // KVO 通过 set 方法 进行监听， addObject: 不是set方法
    NSMutableArray *tempArray = [_person mutableArrayValueForKey:@"array"];
    [tempArray addObject:@"aa"];
}
// 移除观察者
- (void)removeObserver{
    [_person removeObserver:self forKeyPath:@"array"];
}

- (void)dealloc {
    [self removeObserver];
}
@end
