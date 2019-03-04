//
//  SimpleTableCellTableViewCell.m
//  shemtov
//
//  Created by Roy Leizer on 19/08/2018.
//  Copyright © 2018 Roy Leizer. All rights reserved.
//

#import "SimpleTableCellTableViewCell.h"

@implementation SimpleTableCellTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code∂
    
}

-(void)setLikedState:(BOOL)selected
    {
        if(selected==YES)
        {
              [_btnSaveName setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        }
        else
        {
             [_btnSaveName setImage:[UIImage imageNamed:@"heart.png"] forState:UIControlStateNormal];
        }

    }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
   
}





@end
