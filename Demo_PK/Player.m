//
//  Player.m
//  Demo_PK
//
//  Created by 于建祥 on 16/4/7.
//  Copyright © 2016年 于建祥. All rights reserved.
//

#import "Player.h"

@implementation Player

+(Player *)creatPlayerWithName:(NSString *)p_name Age:(int)p_age Blood:(int)p_blood Atk:(int)p_atk
{
    Player *player = [[Player alloc] init];
    player.name = p_name;
    player.age = p_age;
    player.blood = p_blood;
    player.atk = p_atk;
    return player;
}


- (NSString *)pk_player:(Player *)other
{
    int something = (int)arc4random()%10;
    NSString *result = @"";
    switch (something)
    {
        case 0: //攻击
        case 5:
        case 6:
            other.blood -= (self.atk+something);
            if (other.blood>0)
            {
                result = [NSString stringWithFormat:@"%@🔪%@造成了%d伤害",self.name,other.name,self.atk+something];
            }
            else
            {
                other.blood = 0;
                result = [other go_die];
            }
            break;
        case 1: //闪避
            result = [NSString stringWithFormat:@"%@闪避了%@的攻击😏",self.name,other.name];
            break;
        case 2: //反击
        case 8:
        case 9:
            self.blood -= (other.atk+something);
            if (self.blood>0)
            {
                result = [NSString stringWithFormat:@"%@遭到%@的反击🔫%d伤害",self.name,other.name,other.atk+something];
            }
            else
            {
                self.blood = 0;
                result = [self go_die];
            }
            break;
        case 3: //逃跑
            result = [NSString stringWithFormat:@"%@突然逃跑了👞",self.name];
            break;
        case 4: //直击要害
            other.blood = 0;
            result = [NSString stringWithFormat:@"%@直击%@的要害👻",self.name,other.name];
            break;
        case 7: //格挡
            result = [NSString stringWithFormat:@"%@💪格挡了%@的攻击😏",self.name,other.name];
            break;
//        case 5:
//            result = [NSString stringWithFormat:@"%@%@",self.name,other.name];
//            break;
//        case 6:
//            result = [NSString stringWithFormat:@"%@%@",self.name,other.name];
//            break;
//        case 7:
//            result = [NSString stringWithFormat:@"%@%@",self.name,other.name];
//            break;
//        case 8:
//            result = [NSString stringWithFormat:@"%@%@",self.name,other.name];
//            break;
//        case 9:
//            result = [NSString stringWithFormat:@"%@%@",self.name,other.name];
//            break;
            
        default:
            result = [NSString stringWithFormat:@"%@闪避了%@的攻击😏",self.name,other.name];
            break;
    }
    
    return result;
}

- (NSString *)go_die
{
    return [NSString stringWithFormat:@"%@被击败 😇",self.name];
}

@end
