//
//  SimpleTableCellTableViewCell.h
//  shemtov
//
//  Created by Roy Leizer on 19/08/2018.
//  Copyright © 2018 Roy Leizer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnGender;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveName;
-(void)setLikedState:(BOOL)selected;
@property (weak, nonatomic) IBOutlet UIButton *btnShowNameInfo;
@property (weak, nonatomic) NSIndexPath * cindex;
@end
