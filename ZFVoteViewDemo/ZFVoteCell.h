//
//  ZFVoteCell.h
//  ZFVoteViewDemo
//
//  Created by MAC_PRO on 16/8/18.
//  Copyright © 2016年 ZFbory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFVoteModel.h"
@interface ZFVoteCell : UITableViewCell

/**voteModel*/
@property (nonatomic, strong) ZFVoteModel *voteModel;

-(void)thumbUpstartAnimation;

@end
