//
//  SecondViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMStaticContentTableViewController.h"
#import "SinaweiboManager.h"
#import "TencentOAuthManager.h"
#import "TCWBEngine.h"

@class HZActivityIndicatorView;
@class SinaweiboManager;
@class TCWBEngine;
@class TencentOAuthManager;

@interface More_SettingsViewController: JMStaticContentTableViewController<SinaWeiboDelegate,SinaWeiboRequestDelegate,UIAlertViewDelegate,TencentSessionDelegate>

{
    
    SinaweiboManager         *sinaweiboManager;
    TencentOAuthManager      *tencentQQManager;
    TCWBEngine            *tencentWeiBoManager;
    
    
    HZActivityIndicatorView *indictorView;
}



@end
