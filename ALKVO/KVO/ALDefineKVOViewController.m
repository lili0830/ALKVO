//
//  ALDefineKVOViewController.m
//  ALKVO
//
//  Created by 李丽 on 2020/2/23.
//  Copyright © 2020 李丽. All rights reserved.
//

// 自定义 KVO
#import "ALDefineKVOViewController.h"
#import "Person.h"
#import "NSObject+ALKVO.h"

@interface ALDefineKVOViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation ALDefineKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    _person = [[Person alloc] init];
    [_person al_addObserver:self forKeyPath:@"gender" options:(NSKeyValueObservingOptionNew) context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"change = %@", change);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _person.gender = @"女性";
    
}


@end
