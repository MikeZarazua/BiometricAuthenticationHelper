//
//  BiometricAuthenticationHelper.swift
//  BiometricAuthenticationHelper
//
//  Created by Mike on 07/01/20.
//  Copyright © 2020 Mike. All rights reserved.
//

import LocalAuthentication

open class ZUBiometricAuthenticationHelper
{
    public init(errorCode: String?, userCancel: String?, userFallback: String?, passcodeNotSet: String?, systemCancel: String?, authenticationFailed: String?,faceId: String?, touchId: String?, none: String? ) {
        self.biometricFaceIdDescription      = faceId
        self.biometricTouchIdDescription     = touchId
        self.biometricNoOption               = none
        self.errorCode               = errorCode
        self.userCancel              = userCancel
        self.userFallback            = userFallback
        self.passcodeNotSet          = passcodeNotSet
        self.systemCancel            = systemCancel
        self.authenticationFailed    = authenticationFailed
    }
    //MARK:  - String variables to detemrinate the message to desplay when the user face tot he biometric alert
    public var biometricFaceIdDescription: String?
    public var biometricTouchIdDescription: String?
    public var biometricNoOption: String?
    
    public func setBiometricDescriptionFor(faceId: String?, touchId: String?, none: String?)
    {
        self.biometricFaceIdDescription      = faceId
        self.biometricTouchIdDescription     = touchId
        self.biometricNoOption               = none
    }
    
    //MARK : - String varibales when the user has an error while trying to get the uathentication biometric
    public var errorCode: String?
    public var userCancel: String?
    public var userFallback: String?
    public var passcodeNotSet: String?
    public var systemCancel: String?
    public var authenticationFailed: String?
    public func setErrorMessageFor(errorCode: String?, userCancel: String?, userFallback: String?, passcodeNotSet: String?, systemCancel: String?, authenticationFailed: String?)
    {
        self.errorCode               = errorCode
        self.userCancel              = userCancel
        self.userFallback            = userFallback
        self.passcodeNotSet          = passcodeNotSet
        self.systemCancel            = systemCancel
        self.authenticationFailed    = authenticationFailed
    }
    
    /**
     1.-First call this method in order to evaluate with the LAContext()
     the divace with the .deviceOwnerAuthentication in this way, if the user does not have registered the touchid or faceid the user needs to set the passcode
     if the context can evaluate the policy then we call the "evlauateIdAuthenticity(context: Context) wich determinates wich biometrci can evaluate"
     */
    public func authenticateUserUsingId(completion: @escaping(_ authStatus:Bool,_ error: String?) -> Void)
    {
        let context = LAContext()
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: nil)
        {
            if #available(iOS 11.0, *)
            {
                let localizedReason = getLocalizedReason(biometricType: context.biometryType)
                context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: localizedReason)
                {
                    (authSuccessful, authError) in
                    if let error = authError as? LAError
                    {
                        let errorMessage = self.showError(error: error)
                        completion(authSuccessful,errorMessage)
                        return
                    }
                    completion(authSuccessful,nil)
                }
            }
        }
    }
    
    /**
     This function returns an string in fucntion of the localized description
     recevies:
     - Parameter biometricType: an LABiometricType that detemrinates the type of biometric supported by the device
     */
    @available(iOS 11.0, *)
    func getLocalizedReason(biometricType:LABiometryType) -> String
    {
        switch biometricType {
        case .faceID:
            return biometricFaceIdDescription ?? ""
        case .touchID:
            return biometricTouchIdDescription ?? ""
        case .none:
            return biometricNoOption ?? ""
        default:
            return biometricNoOption ?? ""
        }
    }
    
    func showError(error: LAError) -> String?
    {
        switch error.code
        {
        case LAError.authenticationFailed:
            return authenticationFailed
            //message = "La autenticación fallo"//"Authentication was not successful because the user failed to provide valid credentials. Please enter password to login."
            //self.performSelector(onMainThread: #selector(setOffSwitch), with: nil, waitUntilDone: true)
        case LAError.userCancel:
            return userCancel
            //message = "Autenticaición cancelada"//"Authentication was canceled by the user"
            //self.performSelector(onMainThread: #selector(setOffSwitch), with: nil, waitUntilDone: true)
        case LAError.userFallback:
            return userFallback
//            message = "Autenticación cancelada por el usuario"//"Authentication was canceled because the user tapped the fallback button"
            //self.performSelector(onMainThread: #selector(setOffSwitch), with: nil, waitUntilDone: true)
    //        case LAError.biometryNotEnrolled:
            //            message = "Authentication could not start because Touch ID has no enrolled fingers."
        //            break
        case LAError.passcodeNotSet:
            return passcodeNotSet
//            message = "No tiene un passcode agregado a este dispositivo"//"Passcode is not set on the device."
            //self.performSelector(onMainThread: #selector(setOffSwitch), with: nil, waitUntilDone: true)
        case LAError.systemCancel:
            return systemCancel
//            message = "Autenticación cancelada por el sistema"//"Authentication was canceled by system"
            //self.performSelector(onMainThread: #selector(setOffSwitch), with: nil, waitUntilDone: true)
            default:
//            message = error.localizedDescription
            return error.localizedDescription
        }
        //self.showPopupWithMessage(message)
    }
}

