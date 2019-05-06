//
//  Player.h
//  Demo_PK
//
//  Created by 于建祥 on 16/4/7.
//  Copyright © 2016年 于建祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

/*
 人物属性
 名字 年龄 血量 攻击力
 */
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) int blood;
@property (nonatomic, assign) int atk;

/*
 创建角色
 */
+(Player *)creatPlayerWithName:(NSString *)p_name Age:(int)p_age Blood:(int)p_blood Atk:(int)p_atk;


/*
 角色行为
 */
- (NSString *)pk_player:(Player *)other;
- (NSString *)go_die;


/*
 辅助
 */



@end
