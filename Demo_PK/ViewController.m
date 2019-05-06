//
//  ViewController.m
//  Demo_PK
//
//  Created by 于建祥 on 16/4/7.
//  Copyright © 2016年 于建祥. All rights reserved.
//

#import "ViewController.h"
#import "Player.h"

#define APPScreenWidth      [UIScreen mainScreen].bounds.size.width
#define APPScreenHeight     [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) Player *player1;
@property (nonatomic, strong) Player *player2;

@property (nonatomic, assign) BOOL isPK;
@property (nonatomic, assign) float blood_width;

@property (nonatomic, strong) UILabel *player1_name;
@property (nonatomic, strong) UILabel *player2_name;

@property (nonatomic, strong) UIView *blood1;
@property (nonatomic, strong) UIView *blood2;

@property (nonatomic, strong) UIButton *btn_pk;
@property (nonatomic, strong) UITextView *resultView;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupView];
    [self initData];
}

- (void)initData
{
    self.player1 = nil;
    self.player2 = nil;
    self.isPK = NO;
    self.player1 = [Player creatPlayerWithName:@"女巫" Age:20 Blood:100 Atk:10];
    self.player2 = [Player creatPlayerWithName:@"大骷髅" Age:20 Blood:100 Atk:10];
    
    self.blood1.frame = CGRectMake(15, 50, (APPScreenWidth-60)/2.0, 20);
    self.blood2.frame = CGRectMake(APPScreenWidth/2.0+15, 50, (APPScreenWidth-60)/2.0, 20);
    self.blood_width = (APPScreenWidth-60)/2.0;
    
    self.player1_name.text = self.player1.name;
    self.player2_name.text = self.player2.name;
    self.resultView.text = @"";
}

#pragma mark - view

-(UILabel *)player1_name
{
    if (!_player1_name)
    {
        _player1_name  = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 30)];
        _player1_name.font = [UIFont systemFontOfSize:20];
        _player1_name.textAlignment = NSTextAlignmentLeft;
        _player1_name.textColor = [UIColor blueColor];
    }
    return _player1_name;
}

-(UILabel *)player2_name
{
    if (!_player2_name)
    {
        _player2_name  = [[UILabel alloc] initWithFrame:CGRectMake(APPScreenWidth-115, 15, 100, 30)];
        _player2_name.font = [UIFont systemFontOfSize:20];
        _player2_name.textAlignment = NSTextAlignmentRight;
        _player2_name.textColor = [UIColor blueColor];
    }
    return _player2_name;
}

-(UIView *)blood1
{
    if (!_blood1)
    {
        _blood1 = [[UIView alloc] initWithFrame:CGRectMake(15, 50, (APPScreenWidth-60)/2.0, 20)];
        _blood1.backgroundColor = [UIColor redColor];
    }
    return _blood1;
}

-(UIView *)blood2
{
    if (!_blood2)
    {
        _blood2 = [[UIView alloc] initWithFrame:CGRectMake(APPScreenWidth/2.0+15, 50, (APPScreenWidth-60)/2.0, 20)];
        _blood2.backgroundColor = [UIColor redColor];
    }
    return _blood2;
}

-(UIButton *)btn_pk
{
    if (!_btn_pk)
    {
        _btn_pk = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_pk.frame = CGRectMake((APPScreenWidth-100)/2.0, 0, 100, 50);
        [_btn_pk setTitle:@"PK" forState:UIControlStateNormal];
        [_btn_pk setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _btn_pk.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        [_btn_pk addTarget:self action:@selector(begin_pk:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_pk;
}

-(UITextView *)resultView
{
    if (!_resultView)
    {
        _resultView = [[UITextView alloc] initWithFrame:CGRectMake(15, 90, APPScreenWidth-30, APPScreenHeight-110-20)];
        _resultView.textAlignment = NSTextAlignmentCenter;
        _resultView.font = [UIFont systemFontOfSize:16];
        _resultView.textColor = [UIColor blackColor];
        _resultView.layer.borderWidth = 1.0;
        _resultView.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    return _resultView;
}

- (void)setupView
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, APPScreenWidth, APPScreenHeight-20)];
    [backView addSubview:self.player1_name];
    [backView addSubview:self.player2_name];
    
    UIView *blood_back1 = [[UIView alloc] initWithFrame:CGRectMake(self.blood1.frame.origin.x-1, self.blood1.frame.origin.y-1, self.blood1.frame.size.width+2, self.blood1.frame.size.height+2)];
    blood_back1.layer.borderColor = [[UIColor blackColor] CGColor];
    blood_back1.layer.borderWidth = 1.0;
    
    UIView *blood_back2 = [[UIView alloc] initWithFrame:CGRectMake(self.blood2.frame.origin.x-1, self.blood2.frame.origin.y-1, self.blood2.frame.size.width+2, self.blood2.frame.size.height+2)];
    blood_back2.layer.borderColor = [[UIColor blackColor] CGColor];
    blood_back2.layer.borderWidth = 1.0;
    
    [backView addSubview:blood_back1];
    [backView addSubview:blood_back2];
    [backView addSubview:self.blood1];
    [backView addSubview:self.blood2];
    
    [backView addSubview:self.btn_pk];
    [backView addSubview:self.resultView];
    [self.view addSubview:backView];
}


#pragma mark - action

- (void)begin_pk:(UIButton *)sender
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self initData];
    
    [self action_pk];
}

- (void)action_pk
{
    NSString *temp = @"";
    if (self.isPK)
    {
        self.isPK = NO;
        temp = [self.player1 pk_player:self.player2];
    }
    else
    {
        self.isPK = YES;
        temp = [self.player2 pk_player:self.player1];
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        self.blood1.frame = CGRectMake(self.blood1.frame.origin.x, self.blood1.frame.origin.y, self.blood_width*(self.player1.blood/100.0), self.blood1.frame.size.height);
        self.blood2.frame = CGRectMake(APPScreenWidth-self.blood_width*(self.player2.blood/100.0)-15, self.blood2.frame.origin.y, self.blood_width*(self.player2.blood/100.0), self.blood2.frame.size.height);
    }];
    
    self.resultView.text = [self.resultView.text stringByAppendingFormat:@"%@\n",temp];
    
    if (self.player1.blood>0 && self.player2.blood>0)
    {
        [self performSelector:@selector(action_pk) withObject:nil afterDelay:1];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
