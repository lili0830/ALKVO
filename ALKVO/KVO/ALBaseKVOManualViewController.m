//
//  ALBaseKVOManualViewController.m
//  ALKVO
//
//  Created by 李丽 on 2020/2/23.
//  Copyright © 2020 李丽. All rights reserved.
//

#import "ALBaseKVOManualViewController.h"
#import "Person.h"

@interface ALBaseKVOManualViewController ()

@property (nonatomic, strong) Person *person;


@end

@implementation ALBaseKVOManualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _person = [[Person alloc] init];
    _person.name = @"AL_";
    [_person addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"change = %@", change);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_person willChangeValueForKey:@"name"];
    _person.name = [_person.name stringByAppendingString:@"M"];
    [_person didChangeValueForKey:@"name"];
}

- (void)dealloc {
    [_person removeObserver:self forKeyPath:@"name"];
}

@end
