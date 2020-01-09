//
//  MQAPIManager.swift
//  Manqoosha
//
//  Created by Pasha on 07/06/2018.
//  Copyright © 2018 Andpercent. All rights reserved.
//

import UIKit

typealias DefaultAPIFailureClosure = (NSError,Int) -> Void
typealias DefaultAPISuccessClosure = (Dictionary<String,AnyObject>) -> Void
typealias DefaultBoolResultAPISuccesClosure = (Bool) -> Void
typealias DefaultArrayResultAPISuccessClosure = (Dictionary<String,AnyObject>) -> Void


protocol APIErrorHandler
{
    func handleErrorFromResponse(response: Dictionary<String,AnyObject>)
    func handleErrorFromERror(error:NSError)
}

class MQAPIManager: NSObject
{
    static let sharedInstance = MQAPIManager()
//    let ftdHomeManagerAPI = FTDHomeAPIManager()
//    let authenticationManagerAPI = MQAuthenticationAPIManager()
//    let appDataManagerAPI = MQAppDataAPIManager()
//    let notificationsManagerAPI=MQNotificationsAPIManager()
//    let profileManagerAPI=MQProfileAPIManager()
//    let orderManagerAPI = MQOrdersAPIManager()
//    let ftuHomeAPI = FTUHomeAPI()
//    let ftuTruckDetailAPI = FTUTruckDetailAPI()
//    let ftuGetDataAPI = FTUGetDataAPI()
//    let ftdTruckMenuAPI = FTDMenuAPIManager()
//    let ftdProfileAPI = FTDProfileAPIManager()
    
// let checklistManagerAPI = PSChecklistAPIManager()
    var serverToken: String?
    {
        get
        {
            return ""
        }
        set
        {
            
        }
    }

}
