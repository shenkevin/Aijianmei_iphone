//
//  MoreViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/14/12.
//
//

#import "MoreViewController.h"
#import "AboutViewController.h"
#import "More_SettingsViewController.h"
#import "UserService.h"
#import "ShareToSinaController.h"
#import "ImageManager.h"
#import "FontSize.h"

#import "DeviceDetection.h"

#import "AppDelegate.h"



enum ACTION_SHEET_TYPE{
    SHARE_FRIENDS=0,
    SHARE_SOCIAL_NET_WORK,
};



enum SHARE_FRIENDS_TYPE {
    WECHATE_FRIENDS= 0,
    QQ_FRIENDS,
    EMAIL_FRIENDS ,
    MESSAGE_FRIENDS ,
    CANCLE_BUTTON_A
};

enum SHARE_SOCIAL_NET_WORK_TYPE {
    SEND_SINA_WEIBO= 0,
    SEND_TENGXUN_WEIBO,
    SEND_WECHAT_SOCAIL,
    SEND_QQ_SPACE,
    CANCLE_BUTTON_B
};




typedef enum {
    ACCOUNT_MANAGEMENT = 0,
    SHARE_To_SOCIAL_NET_WORKS,
    SHARE_TO_FRIENDS,
    FEEDBACK,
    LIKE_US,
    SHOW_ABOUT_VIEW,
    UPDATE_APP,
    REMMOMED_APPS,
    LOGOUT
} MORE_SELECTION;


@interface MoreViewController ()<UIActionSheetDelegate,AWActionSheetDelegate>

@end

@implementation MoreViewController
@synthesize listData =_listData;

-(void)dealloc{
    
    [_listData release];
    [super dealloc];
    
}

-(void)initUI{
    
    ////Set the background Image
    [self setBackgroundImageName:@"BackGround.png"];
    [self showBackgroundImage];

    ///Set the right bar button 
    [self setTitle:@"更多"];
    [self setNavigationRightButton:@"设置"
                          fontSize:FONT_SIZE
                         imageName:@"setting.png"
                            action:@selector(clickSettingsButton:)];
}

- (void)initOptionList
{
    NSArray *array = [[NSArray alloc] initWithObjects:@"账号管理", @"分享", @"推荐给好友", @"信息反馈",@"喜欢我们,打分鼓励", @"关于我们",  nil];
    self.listData = array;
    [array release];
}

-(void)clickSettingsButton:(id)sender{
    
    More_SettingsViewController *vc = [[More_SettingsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

#pragma mark -lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    [self initOptionList];
    [self initUI];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
}


#pragma mark -
#pragma mark tableView delegates





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43.0f;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


    return 3;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    switch (section) {
        case 0:
        {
            PPDebug(@"Section one");
            
            return 6;

        }
            break;
        case 1:
        {
            PPDebug(@"Section two");
            
            return 2;
        }
            break;
        case 2:
        {
            PPDebug(@"Section three");
//            @"客户端更新",@"推荐应用",@"退出客户端"
            return 1;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreViewController"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreViewController"] autorelease];

    }
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
    UIImage* image_icon = [UIImage imageNamed:@"szicon_a.png"];
    UIImageView* cellAccessoryView = [[UIImageView alloc] initWithImage:image_icon];
    cell.accessoryView = cellAccessoryView;
    cell.backgroundColor = [UIColor whiteColor];
    [cellAccessoryView release];
    
    
    // set backgroudView
    UIImageView *imageView = nil;
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_cell_background.png"]];

    if (indexPath.section ==0) {
        
        cell.textLabel.text = [self.listData objectAtIndex:indexPath.row];
        
        if (0 == [indexPath row] )
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_cell_background.png"]];
        else if (5 == [indexPath row])
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom_cell_background.png"]];
        else
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"middle_cell_background.png"]];
        
    }else if(indexPath.section==1){
        // @"客户端更新",@"推荐应用",@"退出客户端"
        if (indexPath.row == 0) {
            cell.textLabel.text = @"客户端更新";
         imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_cell_background.png"]];
        }else {
            cell.textLabel.text  = @"推荐应用";
         imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom_cell_background.png"]];
            
        }
        
    }else {
        cell.textLabel.text = @"退出客户端";
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"singleCellBackgroud.png"]];
    }
    

    cell.backgroundView=imageView;
    [imageView release];
    


    UIImage *image = nil;
    if (indexPath.section ==0) {
        
        switch ([indexPath row] ) {
            case ACCOUNT_MANAGEMENT:
                image = [UIImage imageNamed:@"social_networks.png"];
                break;
            case SHARE_To_SOCIAL_NET_WORKS:
                image = [UIImage imageNamed:@"share_social.png"];
                break;
            case SHARE_TO_FRIENDS :
                image = [UIImage imageNamed:@"share_with_firends.png"];
                break;
            case FEEDBACK:
                image = [UIImage imageNamed:@"feed_back.png"];
                break;
            case LIKE_US:
                image = [UIImage imageNamed:@"Rate_Us.png"];
                break;
            case SHOW_ABOUT_VIEW:
                image = [UIImage imageNamed:@"about_us.png"];
                break;
            default:
                break;
        }

    }else if(indexPath.section ==1){
        
        switch ([indexPath row] ) {
            case 0:
                image = [UIImage imageNamed:@"update_app.png"];
                break;
            case 1:
                image = [UIImage imageNamed:@"more_apps.png"];
                break;
            default:
                break;

        }
    }else{
        image = [UIImage imageNamed:@"quit_app.png"];
    }
    
       
    cell.imageView.image = image;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        NSUInteger row = [indexPath row];
        switch (row) {
            case ACCOUNT_MANAGEMENT:
            {
                [self accountManagement];
                
            }
                break;
            case SHARE_To_SOCIAL_NET_WORKS:
            {
                [self shareToSocialnetWorks];
            }
                break;
            case SHARE_TO_FRIENDS:
            {
                [self shareToYourFriends];
            }
                break;
            case FEEDBACK:
            {
                [self showFeedback];
            }
                break;
            case LIKE_US:
            {
                [self likeUs];
            }
                break;
            case SHOW_ABOUT_VIEW:
            {
                [self showAboutView];
            }
                break;
            default:
                break;
        }
    }else if (indexPath.section==1){
        
        NSUInteger row = [indexPath row];
        switch (row) {
            case 0:
            {
                [self updateApplication];
            }
                break;
            case 1:
            {
                [self recommmendedApps];
                
            }
                break;
                
            default:
                break;
        }
    
    
    }else {
        
             [self logout];
    }
    
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




#pragma mark --Controller Methods



-(void)accountManagement{

    PPDebug(@"user goes to accountManagement");
}

-(void)shareToSocialnetWorks
{
    whichAcctionSheet = SHARE_SOCIAL_NET_WORK;
    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:NSLS(@"取消")
                                         destructiveButtonTitle:NSLS(@"分享到新浪微博")
                                              otherButtonTitles:NSLS(@"分享到腾讯微博"),NSLS(@"微信社交圈"),NSLS(@"QQ空间"),nil];
   [share showFromTabBar:self.tabBarController.tabBar];
    [share release];
    
}


/////only avaiable at ios 6
- (void)showAWSheet
{
    AWActionSheet *sheet = [[AWActionSheet alloc] initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    
//    [sheet showFromTabBar:self.tabBarController.tabBar];
    [sheet showInView:self.view];
    [sheet release];
}

-(int)numberOfItemsInActionSheet
{
    return 13;
}

-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[[AWActionSheetCell alloc] init] autorelease];
    
    [[cell iconView] setBackgroundColor:
     [UIColor colorWithRed:rand()%255/255.0f
                     green:rand()%255/255.0f
                      blue:rand()%255/255.0f
                     alpha:1]];
    [[cell titleLabel] setText:[NSString stringWithFormat:@"item %d",index]];
    [[cell iconView] setImage:[UIImage imageNamed:@"touxiang_40x40.png"]];
    cell.index = index;
    return cell;
}

-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    PPDebug(@"tap on %d",index);
    
}



- (void)shareToYourFriends
{
    
    whichAcctionSheet = SHARE_FRIENDS;
//    [self shareToSocialnetWorks];
    PPDebug(@"Users share to his friends");

    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:NSLS(@"取消")
                                         destructiveButtonTitle:NSLS(@"微信好友")
                                              otherButtonTitles:NSLS(@"QQ好友"),NSLS(@"通过邮箱"),NSLS(@"通过短信"),nil];
    [share showFromTabBar:self.tabBarController.tabBar];
    [share release];


    
//    if ([DeviceDetection isOS6]){
//        
//        [self showAWSheet];
//    }
//    else{
//        whichAcctionSheet = RECOMMENDATION;
//        [self shareToSocialnetWorks];
//        PPDebug(@"Users share to his friends");
//    
//    }
    
}

-(void)showFeedback{
    
    [self performSegueWithIdentifier:@"FeedbackSegue" sender:self];
    PPDebug(@"Users show feedback");
    
}

-(void)likeUs{

    PPDebug(@"Users likes us !");

}

-(void)showAboutView{
    
    [self performSegueWithIdentifier:@"AboutViewControllerSegue" sender:self];
    
    PPDebug(@"Users Trying to show the aboutView");
}

-(void)updateApplication{
    
    [[UserService defaultService] queryVersion:self];
    PPDebug(@"Users are trying to upgrad the app");
}

-(void)recommmendedApps{
    
    PPDebug(@"Show me the recommended Apps");
}
-(void)logout{
    
    PPDebug(@"User is trying to logout");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定要退出账号吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];

}




#pragma mark --actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *bodyStringBegin = @"朋友，我正在使用爱健美客户端，学习如何健身，分享，很方便很好用，下载地址是";
    NSString *bodyStringWebsite = @"http://www.aijianmei.com";
    NSString *bodyString = [NSString stringWithFormat:@"%@%@", bodyStringBegin, bodyStringWebsite];
    
    
    if (whichAcctionSheet == SHARE_SOCIAL_NET_WORK )
    {

        NSInteger SHARE_SOCIAL_NET_WORK_TYPE ;
        SHARE_SOCIAL_NET_WORK_TYPE  = buttonIndex;
        
        switch (SHARE_SOCIAL_NET_WORK_TYPE) {
            case SEND_SINA_WEIBO:
            {
                
                ShareToSinaController *sc = [[ShareToSinaController alloc]init];
                [self.navigationController pushViewController:sc animated:YES];
                [sc release];
                PPDebug(@" Send sian weibo");
                
            }
                break;
            case SEND_TENGXUN_WEIBO:
            {
                PPDebug(@" Send tencent weibo");
            }
                break;
            case SEND_WECHAT_SOCAIL:
                
            {
               
                
                PPDebug(@" Send email");

                
            }
                break;
            case SEND_QQ_SPACE:
            {
               
            }
                break;
            case CANCLE_BUTTON_A:
            {
                PPDebug(@"Click the cancle button");
                
            }
                break;
            default:
                break;
        }
    }
    
   if (whichAcctionSheet == SHARE_FRIENDS ){
      
       NSInteger SHARE_FRIENDS_TYPE ;
       SHARE_FRIENDS_TYPE  = buttonIndex;
       switch (SHARE_FRIENDS_TYPE) {
           case WECHATE_FRIENDS:
           {
               PPDebug(@"i am WECHAT friends");
           }
               break;
           case QQ_FRIENDS:
           {
               PPDebug(@"i am qq friends");
           }
               break;
               
           case EMAIL_FRIENDS:
           {
               [self sendEmailTo:nil
                    ccRecipients:nil
                   bccRecipients:nil
                         subject:@"向你推荐爱健美的客户端"
                            body:bodyString
                          isHTML:NO
                        delegate:self];
               PPDebug(@"i am email friends");
           }
               break;
           case MESSAGE_FRIENDS:
           {
               [self sendSms:nil body:bodyString];
               PPDebug(@" Send message ");
           }
               break;
           case CANCLE_BUTTON_B:
           {
               PPDebug(@"i am cancle Button");
           }
               break;
               
           default:
               break;
       }
       


}



    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

 @end
