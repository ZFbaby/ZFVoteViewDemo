//
//  ZFVoteView.h
//  ZFVoteViewDemo
//
//  Created by MAC_PRO on 16/8/19.
//  Copyright © 2016年 ZFbory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFVoteModel.h"
@interface ZFVoteView : UIView

-(instancetype)initWithFrame:(CGRect)frame voteView:(ZFVoteModel *)voteModel;

@property (nonatomic, strong) ZFVoteModel *voteModel;

- (void)thumbUpstartAnimation;
@end
