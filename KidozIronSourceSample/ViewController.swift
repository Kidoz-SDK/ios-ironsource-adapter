//
//  ViewController.swift
//  KidozIronSourceSample
//
//  Created by Yarden Rosenberg on 23/02/2022.
//

import UIKit
import Foundation
import ObjectiveC.runtime
//import KidozSDKModule

let kAPPKEY = "11ec9bd9d"


class ViewController: UIViewController, ISInterstitialDelegate,ISRewardedVideoManualDelegate,KDZInitDelegate,KDZBannerDelegate{
    
    var mBanner: UIView!
    @IBOutlet weak var logText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBorder()
        self.setupIronSourceSdk()
        // Do any additional setup after loading the view.
    }
    

    
    
    // MARK: - SDK
    
    //MARK: Private Functions
    func setupIronSourceSdk() {
        ISIntegrationHelper.validateIntegration()
        
        
        // Before initializing any of our products (Rewarded video, Offerwall or Interstitial) you must set
        // their delegates. Take a look at these classes and you will see that they each implement a product
        // protocol. This is our way of letting you know what's going on, and if you don't set the delegates
        // we will not be able to communicate with you.
        // We're passing 'self' to our delegates because we want
        // to be able to enable/disable buttons to match ad availability.
        IronSource.setRewardedVideoManualDelegate(self)
        IronSource.setInterstitialDelegate(self)
        
        //        IronSource.initWithAppKey(kAPPKEY)
        // To initialize specific ad units:
        IronSource.initWithAppKey(kAPPKEY, adUnits:[IS_INTERSTITIAL,IS_REWARDED_VIDEO])
        logOut(message: "Initilalizing IronSource::" + IronSource.sdkVersion())
    }
    
    @IBAction func onInitKidozSDKAction(_ sender: Any) {
        
        logOut(message: "SDK Vesion " + KidozSDK.instance().getVersion())
        if(!KidozSDK.instance().isSDKInitialized()){
            logOut(message: "Initilalizing SDK...")
            KidozSDK.instance().initialize(withPublisherID: "5", securityToken: "i0tnrdwdtq0dm36cqcpg6uyuwupkj76s",with :self)
        }
        else{
            logOut(message: "Kidoz SDK already initialized...")
            onInitSuccess()
        }
    }
    
    func onInitSuccess(){
        if(KidozSDK.instance().isSDKInitialized()){
            logOut(message: "SDK Initialized")
            initBannerWithView()
            //            KidozSDK.instance().initializeBanner(with: self, with: self)
            
            KidozSDK.instance().setBannerPosition(BOTTOM_CENTER)
        }
    };
    
    
    func onInitError(_ errorMessage: String!){
        logOut(message: "onInitError " + errorMessage)
    }
    
    
    // MARK: - Interstitial
    
    @IBAction func loadInterstitial(_ sender: Any) {
        logOut(message: "IronSource loadInterstitial")
        IronSource.loadInterstitial()
    }
    
    @IBAction func showInterstitial(_ sender: Any) {
        logOut(message: "IronSource showInterstitial")
        IronSource.showInterstitial(with: self)
    }
    
    //MARK: ISInterstitialDelegate Functions
    /**
     Called after an interstitial has been clicked.
     */
    public func didClickInterstitial() {
    }
    
    /**
     Called after an interstitial has attempted to show but failed.
     
     @param error The reason for the error
     */
    public func interstitialDidFailToShowWithError(_ error: Error!) {
        logOut(message: String(describing: error.self))
    }
    
    /**
     Called after an interstitial has been displayed on the screen.
     */
    public func interstitialDidShow() {
        logOut(message: "IronSource interstitialDidShow")
    }
    
    /**
     Called after an interstitial has been dismissed.
     */
    public func interstitialDidClose() {
        logOut(message: "IronSource interstitialDidClose")
    }
    
    /**
     Called after an interstitial has been opened.
     */
    public func interstitialDidOpen() {
        logOut(message: "IronSource interstitialDidOpen")
    }
    
    /**
     Called after an interstitial has attempted to load but failed.
     
     @param error The reason for the error
     */
    public func interstitialDidFailToLoadWithError(_ error: Error!) {
        logOut(message: "IronSource interstitialDidFailToLoadWithError"+String(describing: error.self))
    }
    
    /**
     Called after an interstitial has been loaded
     */
    public func interstitialDidLoad() {
        //        showISButton.isEnabled=true
        logOut(message: "IronSource interstitialDidLoad")
    }
    
    // ********************
    
    
    // MARK: - Rewarded
    
    @IBAction func loadRewarded(_ sender: Any) {
        logOut(message: "ironSource loadRewarded")
        IronSource.loadRewardedVideo()
    }
    
    @IBAction func showRewarded(_ sender: Any) {
        logOut(message: "ironSource showRewarded")
        IronSource.showRewardedVideo(with:self)
    }
    
    /*
    Called after a rewarded video has changed its availability.
    
    @param available The new rewarded video availability. YES if available and ready to be shown, NO otherwise.
    */
   public func rewardedVideoHasChangedAvailability(_ available: Bool) {
       logOut(message: "ironSource rewardedVideoHasChangedAvailability" + String(available.self))
   }
   
   /**
    Called after a rewarded video has finished playing.
    */
   public func rewardedVideoDidEnd() {
       logOut(message: "ironSource rewardedVideoDidEnd")
   }
   
   /**
    Called after a rewarded video has started playing.
    */
   public func rewardedVideoDidStart() {
       logOut(message: "ironSource rewardedVideoDidStart")
   }
   
   /**
    Called after a rewarded video has been dismissed.
    */
   public func rewardedVideoDidClose() {
       logOut(message: "ironSource rewardedVideoDidClose")
   }
   
   /**
    Called after a rewarded video has been opened.
    */
   public func rewardedVideoDidOpen() {
       logOut(message: "ironSource rewardedVideoDidOpen")
   }
   
   /**
    Called after a rewarded video has attempted to show but failed.
    
    @param error The reason for the error
    */
   public func rewardedVideoDidFailToShowWithError(_ error: Error!) {
       logOut(message: "ironSource rewardedVideoDidFailToShowWithError " + String(describing: error.self))
   }
   
   /**
    Called after a rewarded video has been viewed completely and the user is eligible for reward.
    
    @param placementInfo An object that contains the placement's reward name and amount.
    */
   public func didReceiveReward(forPlacement placementInfo: ISPlacementInfo!) {
       logOut(message: "ironSource didReceiveReward")
   }
   /**
    Called after a rewarded video has been clicked.
    
    @param placementInfo An object that contains the placement's reward name and amount.
    */
   func didClickRewardedVideo(_ placementInfo: ISPlacementInfo!) {
       logOut(message: "ironSource didClickRewardedVideo")
   }
   
   func rewardedVideoDidLoad() {
       logOut(message: "ironSource rewardedVideoDidLoad")
   }
   
   func rewardedVideoDidFailToLoadWithError(_ error: Error!) {
       logOut(message: "ironSource rewardedVideoDidFailToLoadWithError " + String(describing: error.self))
   }
    
    
    // MARK: - Banner
    
    @IBAction func loadBanner(_ sender: Any) {
        logOut(message: "Kidoz loadBanner")
        if(KidozSDK.instance().isSDKInitialized()){
            if(KidozSDK.instance().isBannerInitialized()){
                KidozSDK.instance().loadBanner()
            }else{
                logOut(message: "Kidoz Banner not initialized")
                NSLog("Kidoz Banner not initialized");
            }
        }else{
            logOut(message: "Kidoz SDK not initialized")
        }
    }
    
    @IBAction func showBanner(_ sender: Any) {
        logOut(message: "Kidoz showBanner")
        if(KidozSDK.instance().isBannerReady()){
            KidozSDK.instance().showBanner(self)
        }else{
            logOut(message: "Kidoz Banner not ready")
        }
    }
    
    
    @IBAction func hideBanner(_ sender: Any) {
        KidozSDK.instance().hideBanner()
        logOut(message: "Kidoz hideBanner")
    }
    
    
    func bannerDidInitialize() {
        logOut(message: "Kidoz bannerDidInitialize")
    }
    
    func bannerDidClose() {
        logOut(message: "Kidoz bannerDidClose")
    }
    
    func bannerDidOpen() {
        logOut(message: "Kidoz bannerDidOpen")
    }
    
    func bannerIsReady() {
        logOut(message: "Kidoz bannerIsReady")
    }
    
    func bannerReturnedWithNoOffers() {
        logOut(message: "Kidoz bannerReturnedWithNoOffers")
    }
    
    func bannerLoadFailed() {
        logOut(message: "Kidoz bannerLoadFailed")
    }
    
    func bannerShowFailed() {
        logOut(message: "Kidoz bannerLoadFailed")
    }
    
    func bannerDidReciveError(_ errorMessage: String!) {
        logOut(message: "Kidoz bannerLoadFailed" + errorMessage)
    }
    
    func bannerLeftApplication() {
        logOut(message: "Kidoz bannerLeftApplication")
    }
    
    func initBannerWithView(){
        let BANNER_WIDTH: CGFloat = 320
        let BANNER_HEIGHT: CGFloat = 50
        
        mBanner = UIView(frame: CGRect(x: 0, y: 0, width: BANNER_WIDTH, height: BANNER_HEIGHT))
        view.addSubview(mBanner)
        mBanner.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([NSLayoutConstraint(
            item: mBanner,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: bottomLayoutGuide,
            attribute: .top,
            multiplier: 1,
            constant: 0),
                             NSLayoutConstraint(
                                item: mBanner,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0),
                             NSLayoutConstraint(
                                item: mBanner,
                                attribute: .height,
                                relatedBy: .equal,
                                toItem: nil,
                                attribute: .notAnAttribute,
                                multiplier: 0,
                                constant: BANNER_HEIGHT),
                             NSLayoutConstraint(
                                item: mBanner,
                                attribute: .width,
                                relatedBy: .equal,
                                toItem: nil,
                                attribute: .notAnAttribute,
                                multiplier: 0,
                                constant: BANNER_WIDTH)])
        
        view.bringSubviewToFront(mBanner)
        KidozSDK.instance().initializeBanner(with: self, with: mBanner)
        
    }
    
    func setBorder(){
        self.logText.layer.borderColor = UIColor.orange.cgColor
        self.logText.layer.borderWidth = 2.3
        self.logText.layer.cornerRadius = 15
    }
    
    func logOut(message:String){
        NSLog(message);
        logText.text = logText.text + getTimestamp() + " - " + message + "\n"
        let location = logText.text.count - 1
        let bottom = NSMakeRange(location, 1)
        logText.scrollRangeToVisible(bottom)
    }
    
    func getTimestamp () ->String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmmssSSS"
        let time = formatter.string(from: Date())
        return time
    }
    
}
