//
//  ZFVoteModel.m
//  ZFVoteViewDemo
//
//  Created by MAC_PRO on 16/8/18.
//  Copyright © 2016年 ZFbory. All rights reserved.
//

#import "ZFVoteModel.h"
#import "ZFConfig.h"

@implementation ZFVoteModel


-(void)setTitle:(NSString *)title{//根据数据算出每行cell的实际高度

    _title = title;
    
    CGFloat title_H = [title boundingRectWithSize:CGSizeMake(ZFVoteTableViewMax_W - percentLable_W - thumbUpView_WH - 85, 100)
                                          options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]}
                                          context:nil].size.height;

    self.voteCell_H = title_H + 30;
}

@end
