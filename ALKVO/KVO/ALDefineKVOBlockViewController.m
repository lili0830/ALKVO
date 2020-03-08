//
//  ALDefineKVOBlockViewController.m
//  ALKVO
//
//  Created by 李丽 on 2020/2/23.
//  Copyright © 2020 李丽. All rights reserved.
//

#import "ALDefineKVOBlockViewController.h"
#import "Person.h"
#import "NSObject+ALKVOBlock.h"

@interface ALDefineKVOBlockViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation ALDefineKVOBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    _person = [[Person alloc] init];
    [_person al_observerKeyPath:@"gender" options:(NSKeyValueObservingOptionNew) block:^(NSDictionary * _Nonnull change) {
        NSLog(@"%@", change);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _person.gender = @"女性";
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
