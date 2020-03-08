//
//  ALBaseKVOViewController.m
//  ALKVO
//
//  Created by 李丽 on 2020/2/23.
//  Copyright © 2020 李丽. All rights reserved.
//
                                                                    
#import "ALBaseKVOAutoViewController.h"
#import "Person.h"

@interface ALBaseKVOAutoViewController ()

@property (nonatomic, strong) Person *person;

@end


@implementation ALBaseKVOAutoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _person = [[Person alloc] init];
    [self registerObserver];
}

// 注册观察者
- (void)registerObserver {
    [_person addObserver:self forKeyPath:@"gender" options:(NSKeyValueObservingOptionNew) context:nil];
}
// 接受事件
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"change = %@", change);
}
// 移除观察者
- (void)removeObserver{
    [_person removeObserver:self forKeyPath:@"gender"];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _person.gender = @"男";
    
}

- (void)dealloc {
    [self removeObserver];
}


@end
