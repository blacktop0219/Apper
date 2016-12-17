
//
//  SignInViewController.swift
//  Apper
//
//  Created by jian on 8/4/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


class SignInViewController: BaseViewController, UITextFieldDelegate, GPPSignInDelegate
{
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var viewPreview: UIView!
    @IBOutlet weak var viewOverlay: UIView!
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var scrollMain: UIScrollView!
    @IBOutlet weak var viewSignInFB: UIView!
    @IBOutlet weak var btnFB: UIButton!
    @IBOutlet weak var viewSignInTwitter: UIView!
    @IBOutlet weak var btnTwitter: UIButton!
    @IBOutlet weak var viewSignInGoogle: UIView!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var viewSignInLinkedIn: UIView!
    @IBOutlet weak var btnLinkedIn: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnJoin: UIButton!
    @IBOutlet weak var viewJoin: UIView!
    
    var rectJoin: CGRect!
    var player: AVPlayer!
    var twitterAPI: STTwitterAPI!
    var signIn: GPPSignIn?

    override func viewDidLoad() {
        super.viewDidLoad()

        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.authViewController = self
        
        self.initGooglePlus()
        
        // Do any additional setup after loading the view.
        imgBg.layer.masksToBounds = true
        imgBg.contentMode = UIViewContentMode.ScaleAspectFill
        
        //Main
        btnFB.layer.masksToBounds = true
        btnFB.layer.cornerRadius = btnFB.frame.height/2.0
        btnFB.layer.borderColor = UIColor.whiteColor().CGColor
        btnFB.layer.borderWidth = 1.0
        
        btnTwitter.layer.masksToBounds = true
        btnTwitter.layer.cornerRadius = btnTwitter.frame.height/2.0
        btnTwitter.layer.borderColor = UIColor.whiteColor().CGColor
        btnTwitter.layer.borderWidth = 1.0

        btnGoogle.layer.masksToBounds = true
        btnGoogle.layer.cornerRadius = btnGoogle.frame.height/2.0
        btnGoogle.layer.borderColor = UIColor.whiteColor().CGColor
        btnGoogle.layer.borderWidth = 1.0

        btnLinkedIn.layer.masksToBounds = true
        btnLinkedIn.layer.cornerRadius = btnLinkedIn.frame.height/2.0
        btnLinkedIn.layer.borderColor = UIColor.whiteColor().CGColor
        btnLinkedIn.layer.borderWidth = 1.0

        viewMain.alpha = 0
        rectJoin = viewJoin.frame
        
        viewJoin.frame = CGRectMake(rectJoin.origin.x, self.view.frame.height, rectJoin.width, rectJoin.height)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        tapGesture.numberOfTapsRequired = 1
        scrollMain.addGestureRecognizer(tapGesture)
        
        //Add Keyboard functions.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        self.initVideoPreview()
        self.startAnimate()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }

    func initVideoPreview()
    {
        let path = NSBundle.mainBundle().pathForResource("HD", ofType:"mp4")
        let url = NSURL.fileURLWithPath(path!)

        player = AVPlayer(URL: url)
        let avPlayerLayer:AVPlayerLayer = AVPlayerLayer(player: player)
        avPlayerLayer.frame = CGRectMake(0, 0, viewPreview.frame.width, viewPreview.frame.height)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        viewPreview.layer.addSublayer(avPlayerLayer)

        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "playerItemDidReachEnd",
            name: AVPlayerItemDidPlayToEndTimeNotification,
            object: self.player.currentItem)
    }

    func startAnimate()
    {
        UIView.animateWithDuration(0.5,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                self.viewOverlay.alpha = 0.3
            }) {(Bool) -> Void in
                
                //Show Main.
                UIView.animateWithDuration(0.5,
                    delay: 0.5,
                    options: [.CurveEaseInOut, .AllowUserInteraction],
                    animations: { () -> Void in
                        
                        self.viewMain.alpha = 1.0
                        self.viewJoin.frame = self.rectJoin
                        
                    }) {(Bool) -> Void in
                        
                        self.player.play()
                }
        }
    }
    
    func playerItemDidReachEnd()
    {
        self.player.seekToTime(CMTimeMakeWithSeconds(0, self.player.currentTime().timescale))
        self.player.play()
    }
    
    @IBAction func actionForgotPassword()
    {
        self.hideKeyboard()
        
        let alertController = UIAlertController(title: "Email", message: "Please input your email:", preferredStyle: .Alert)
        
        let confirmAction = UIAlertAction(title: "Submit", style: .Default) { (_) in
//            if let field = alertController.textFields![0] as UITextField! {
                // store your data
//                NSUserDefaults.standardUserDefaults().setObject(field.text, forKey: "userEmail")
//                NSUserDefaults.standardUserDefaults().synchronize()
//            } else {
                // user did not fill field
//            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Email Address"
            textField.keyboardType = UIKeyboardType.EmailAddress
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
/////////////////////////////////////////////////////////////////////////////////////
/// UITextField Delegate
/////////////////////////////////////////////////////////////////////////////////////
    
    func hideKeyboard()
    {
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField == txtEmail)
        {
            txtPassword.becomeFirstResponder()
        }
        else
        {
            textField .resignFirstResponder()
            self.actionJoin()
        }
        
        return true
    }
    
    func keyboardWillShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        {
            UIView.animateWithDuration(0.2,
                delay: 0,
                options: [.CurveEaseInOut, .AllowUserInteraction],
                animations: { () -> Void in
                    
                    self.scrollMain.setContentOffset(CGPointMake(0, keyboardSize.height), animated: false)
                    self.viewJoin.frame = CGRectMake(self.viewJoin.frame.origin.x,
                        self.rectJoin.origin.y - keyboardSize.height,
                        self.rectJoin.width,
                        self.rectJoin.height + keyboardSize.height)
                    
                }) {(Bool) -> Void in
            }
        }
    }

    func keyboardWillHide(notification: NSNotification)
    {
        UIView.animateWithDuration(0.2,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.scrollMain.setContentOffset(CGPointZero, animated: false)
                self.viewJoin.frame = self.rectJoin
                
            }) {(Bool) -> Void in
        }
    }
    
/////////////////////////////////////////////////////////////////////////////////////
/// Facebook
/////////////////////////////////////////////////////////////////////////////////////
    
    @IBAction func btnFBLoginPressed(sender: AnyObject) {
        
        self.hideKeyboard()
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        if(FBSDKAccessToken.currentAccessToken() != nil)
        {
            self.getFBUserData()
        }
        else
        {
            fbLoginManager.logInWithReadPermissions(["public_profile", "email"], handler: { (result, error) -> Void in
                if (error == nil){
                    let fbloginresult : FBSDKLoginManagerLoginResult = result
                    if(fbloginresult.grantedPermissions.contains("public_profile"))
                    {
                        self.getFBUserData()
                    }
                }
                else
                {
                    NSLog(error.description)
                }
            })
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large)"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    print(result)
                    
                    self.actionJoin()
                }
                else
                {
                    NSLog(error.description)
                }
            })
        }
    }
    
/////////////////////////////////////////////////////////////////////////////////////
/// Twitter
/////////////////////////////////////////////////////////////////////////////////////
    
    @IBAction func actionTwitter()
    {
        self.hideKeyboard()
        twitterAPI = STTwitterAPI(OAuthConsumerKey: TWITTER_KEY, consumerSecret:  TWITTER_SECRET)
        twitterAPI.postTokenRequest({ (url, oauthToken) -> Void in
                UIApplication.sharedApplication().openURL(url)
            },
            
            authenticateInsteadOfAuthorize: false,
            forceLogin: NSNumber(bool: true),
            screenName: nil,
            oauthCallback: "apper://") { (error) -> Void in

                print(error)
        }
    }
    
    func setOAuthToken(token: String, verifier: String)
    {
        twitterAPI.postAccessTokenRequestWithPIN(verifier, successBlock: { (oauthToken, oauthTokenSecret, userID, screenName) -> Void in
                print(userID)
                self.actionJoin()
            
            }) { (error) -> Void in
                print(error)
        }
    }
    
/////////////////////////////////////////////////////////////////////////////////////
/// Google Plus
/////////////////////////////////////////////////////////////////////////////////////
    func initGooglePlus()
    {
        signIn = GPPSignIn.sharedInstance()
        signIn?.shouldFetchGooglePlusUser = true
        signIn?.clientID = GOOGLE_PLUS_KEY
        signIn?.scopes = [kGTLAuthScopePlusLogin]
        signIn?.delegate = self;
    }
    
    @IBAction func actionGoogle()
    {
        self.hideKeyboard()
        signIn?.authenticate()
    }
    
    func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
        self.actionJoin()
    }
    
    func didDisconnectWithError(error: NSError!) {
        print(error)
    }
    
/////////////////////////////////////////////////////////////////////////////////////
/// LinkedIn
/////////////////////////////////////////////////////////////////////////////////////
    
    var linkedInClient: LIALinkedInHttpClient {
        let application = LIALinkedInApplication(redirectURL: LINKEDIN_REDIRECT_URL, clientId: LINKEDIN_CLIENT_ID, clientSecret: LINKEDIN_CLIENT_SECRET, state: "DCEEFWF45453sdffef424", grantedAccess: ["r_basicprofile"])
        return LIALinkedInHttpClient(forApplication: application, presentingViewController: self)
    }

    @IBAction func actionLinkedIn()
    {
        self.hideKeyboard()
        self.linkedInClient.getAuthorizationCode({ (code: String!) -> Void in
            self.linkedInClient.getAccessToken(code, success: { (accessTokenData: [NSObject: AnyObject]!) -> Void in
                let accessToken = accessTokenData["access_token"] as! String
                let urlPath = "https://api.linkedin.com/v1/people/~?oauth2_access_token=\(accessToken)&format=json"
                self.linkedInClient.GET(urlPath, parameters: nil, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
                    
                    print("current user %@", result);
                    self.actionJoin()
                    
                    }, failure: { (operation, error) -> Void in
                        print(error)
                })
                }, failure: { (error) -> Void in
                    NSLog("error getting linked in access token: \(error)")
            })
            }, cancel: { () -> Void in
                NSLog("LinkedIn authorization canceled")
            }) { (error) -> Void in
                NSLog("Error getting linkedin auth code: \(error)")
        }
    }

/////////////////////////////////////////////////////////////////////////////////////
/// Join
/////////////////////////////////////////////////////////////////////////////////////
    @IBAction func actionJoin()
    {
        self.hideKeyboard()
        btnJoin.alpha = 0
        
        UIView.animateWithDuration(0.2,
            delay: 0,
            options: [.CurveEaseIn, .AllowUserInteraction],
            animations: { () -> Void in
                
                self.viewJoin.frame = CGRectMake(0, self.rectJoin.origin.y + 20, self.view.frame.width, self.view.frame.height) // can be better later
                
            }) {(Bool) -> Void in
                
                UIView.animateWithDuration(0.2,
                    delay: 0.2,
                    options: [.CurveEaseInOut, .AllowUserInteraction],
                    animations: { () -> Void in
                        
                        self.viewJoin.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
                        
                    }) {(Bool) -> Void in
                        
                        self.gotoDashboard()
                }

        }
        
    }
    
    func gotoDashboard()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboard = storyboard.instantiateViewControllerWithIdentifier("DashboardViewController") as! DashboardViewController
        let menu = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        let container = MFSideMenuContainerViewController.containerWithCenterViewController(dashboard, leftMenuViewController: menu, rightMenuViewController: nil)
        self.navigationController?.pushViewController(container, animated: false)
    }
}
