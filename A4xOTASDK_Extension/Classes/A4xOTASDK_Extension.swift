//
//  A4xOTASDK_Extension.swift
//
//  Created by wjin on 2022/7/21.
//  Copyright © 2020 wjin. All rights reserved.
//

import CTMediator

fileprivate let ModuleName = "A4xOTASDK"
//fileprivate let ModuleName = "AddxAi"

fileprivate let ProjectName = "AddxAi"

public extension CTMediator {
    @objc func A4xOTASDK_getDeviceListVC(nav: UINavigationController, deviceId: String, callback: @escaping (String)->Void) -> UIViewController? {
        let params:[AnyHashable:Any] = [
            "nav": nav,
            "deviceId": deviceId,
            "callback": callback,
            kCTMediatorParamsKeySwiftTargetModuleName: ModuleName
        ]
        if let viewController = performTarget(ModuleName, action: "getDeviceListVC", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
    
    @objc func A4xOTASDK_webRtcSDKInit(params: [AnyHashable : Any], callback: @escaping (String) -> Void) {
        var tpmParams:[AnyHashable : Any] = params
        tpmParams["callback"] = callback
        tpmParams[kCTMediatorParamsKeySwiftTargetModuleName] = ProjectName
        performTarget(ModuleName, action: "webRtcSDKInit", params: tpmParams, shouldCacheTarget: false)
    }
    
    @objc func A4xOTASDK_signalConnState(params: [String : Any], callback: @escaping (Int) -> Void) {
        let params:[AnyHashable:Any] = [
            "callback": callback,
            kCTMediatorParamsKeySwiftTargetModuleName: ProjectName
        ]
        performTarget(ModuleName, action: "signalConnState", params: params, shouldCacheTarget: false)
    }
    
    // 连接webSocket
    @objc func A4xOTASDK_connectWebSocket(sn: String, apAddr: String, uid: String, callback: @escaping (String) -> Void) {
        let params:[AnyHashable:Any] = [
            "callback": callback,
            "sn":sn,
            "apAddr":apAddr,
            "uid":uid,
            kCTMediatorParamsKeySwiftTargetModuleName: ModuleName
        ]
        performTarget(ModuleName, action: "connectWebSocket", params: params, shouldCacheTarget: false)
    }
    
    // websocket发送
    @objc func A4xOTASDK_sendSignalMessage(messageType: Int, messageJson: String, callback: @escaping (String) -> Void) {
        let params:[AnyHashable:Any] = [
            "callback": callback,
            "messageType": messageType,
            "messageJson":messageJson,
            kCTMediatorParamsKeySwiftTargetModuleName: ModuleName
        ]
        performTarget(ModuleName, action: "sendSignalMessage", params: params, shouldCacheTarget: false)
    }
    
    // 销毁Player
    // sn: 设备序列号
    @objc func A4xOTASDK_destoryPlayer(sn: String, callback: @escaping (String) -> Void) {
        let params:[AnyHashable:Any] = [
            "callback": callback,
            "sn":sn,
            kCTMediatorParamsKeySwiftTargetModuleName: ModuleName
        ]
        performTarget(ModuleName, action: "destoryPlayer", params: params, shouldCacheTarget: false)
    }
    
    @objc func A4xOTASDK_showSwift(callback: @escaping (String) -> Void) -> UIViewController? {
        let params = [
            "callback": callback,
            kCTMediatorParamsKeySwiftTargetModuleName:"\(ModuleName)_swift"
            ] as [AnyHashable : Any]
        if let viewController = self.performTarget(ModuleName, action: "Extension_ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
    
    @objc func A4xOTASDK_showObjc(callback: @escaping (String) -> Void) -> UIViewController? {
        let callbackBlock = callback as @convention(block) (String) -> Void
        let callbackBlockObject = unsafeBitCast(callbackBlock, to: AnyObject.self)
        let params = ["callback": callbackBlockObject] as [AnyHashable:Any]
        if let viewController = self.performTarget(ModuleName, action: "Extension_ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
}
