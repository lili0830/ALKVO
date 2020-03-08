//
//  ALBaseKVOAttriDependViewController.m
//  ALKVO
//
//  Created by 李丽 on 2020/2/23.
//  Copyright © 2020 李丽. All rights reserved.
//

// 属性依赖 Attribute dependency
#import "ALBaseKVOAttriDependViewController.h"
#import "Person.h"

@interface ALBaseKVOAttriDependViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation ALBaseKVOAttriDependViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    _person = [[Person alloc] init];
    _person.petDog.name = @"Pet_";
    [_person addObserver:self forKeyPath:@"petDog" options:(NSKeyValueObservingOptionNew) context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"change = %@", change);
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _person.petDog.name = [_person.petDog.name stringByAppendingString:@"M"];
}

- (void)dealloc {
    [_person removeObserver:self forKeyPath:@"petDog"];
}

@end
