//
//  ViewControllerWebview.h
//  shemtov
//
//  Created by Roy Leizer on 27/08/2018.
//  Copyright © 2018 Roy Leizer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerWebview : UIViewController <UIWebViewDelegate>
@property (nonatomic,strong) NSString * url;
@end
