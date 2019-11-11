//
//  FirebaseAPI.swift
//  Ticketing
//
//  Created by Carlos Mendoza on 11/8/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

class FirebaseAPI {
    
    static let shared = FirebaseAPI()
    
    private init(){}
    
    public func isLoggedIn() -> Bool {
        if Auth.auth().currentUser?.uid == nil {
            return false;
        }
        return true
    }
    
    // Login user and delete anonymous account, if no anonymous account found then dont delete user and instead log user in
    public func loginUser( withEmail email: String, password: String, completion: @escaping (Error?, User?) -> Void) {
        if Auth.auth().currentUser?.isAnonymous ?? false {
            Auth.auth().currentUser?.delete(completion: { (error) in
                if error != nil {
                    completion(error,nil)
                }
                
                Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
                    
                    if error != nil {
                        self.loginAnonymously(completion: completion)
                        completion(error, nil)
                        return
                    }
                    
                    if let user = authDataResult?.user {
                        completion(nil, user)
                        return
                    }
                }
                
            })
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
                
                if error != nil {
                    self.loginAnonymously(completion: completion)
                    completion(error, nil)
                    return
                }
                
                if let user = authDataResult?.user {
                    completion(nil, user)
                    return
                }
            }
        }
    }
    
    public func loginUser(withGoogle signIn: GIDSignIn, didSignInFor user: GIDGoogleUser, completion: @escaping (Error?, AuthDataResult?) -> Void) {
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        var failedLogin = false
        var googleAvailable = false
        
        Auth.auth().fetchSignInMethods(forEmail: user.profile.email) { (signInMethods, error) in
            if error != nil {
                completion(error,nil)
                return
            }
            
            if signInMethods?.contains(GoogleAuthSignInMethod) ?? false {
                Auth.auth().currentUser?.delete(completion: { (error) in
                    if error != nil {
                        completion(error,nil)
                    }
                    
                    Auth.auth().signIn(with: credential) { (authDataResult, error) in
                        
                        if error != nil {
                            self.loginAnonymously(completion: {_,_ in })
                            completion(error, nil)
                            return
                        }
                        
                        if let user = authDataResult?.user {
                            completion(nil, user)
                            return
                        }
                    }
                    
                })
                googleAvailable = true
                print("Available")
            }
        }
        
        if failedLogin {
            return
        }
        
        if googleAvailable {
            Auth.auth().signIn(with: credential) { (AuthDataResult, error) in
                if error != nil {
                    completion(error, nil)
                    return
                }
                
                if let result = AuthDataResult {
                    completion(nil, result)
                    return
                }
            }
            
        } else {
            Auth.auth().currentUser?.link(with: credential, completion: { (AuthDataResult, error) in
                if (error) != nil {
                    completion(error, nil)
                    return
                }
                
                if let result = AuthDataResult {
                    completion(nil, result)
                    return
                }
            })
        }
    }
    
    // Links Anonymous account with new registered email, will return error if email already in use
    public func registerUser(email: String, password: String, completion: @escaping(Error?,User?)-> Void){
        
        //        Auth.auth().fetchSignInMethods(forEmail: email) { (signInMethods, error) in
        //            if error != nil {
        //                completion(error,nil)
        //               failedLogin = true
        //                return
        //            }
        //
        //            if signInMethods?.contains(GoogleAuthSignInMethod) ?? false {
        //             googleAvailable = true
        //            }
        //
        //            if signInMethods?.count ?? 0 > 0 {
        //                print("Has Account")
        //            } else {
        //                let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        //
        //                Auth.auth().currentUser?.link(with: credential, completion: { (AuthDataResult, error) in
        //                    if (error) != nil {
        //                        completion(error, nil)
        //                        return
        //                    }
        //
        //                    if let user = AuthDataResult?.user {
        //                        completion(nil, user)
        //                        return
        //                    }
        //                })
        //            }
        //        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        Auth.auth().currentUser?.link(with: credential, completion: { (AuthDataResult, error) in
            if (error) != nil {
                completion(error, nil)
                return
            }
            
            if let user = AuthDataResult?.user {
                completion(nil, user)
                return
            }
        })
    }
    
    // This will check if an account is logged, if not it will sign in anonymously
    public func loginAnonymously(completion: @escaping(Error?,User?)-> Void){
        if isLoggedIn() {
            return
        }
        
        Auth.auth().signInAnonymously { (AuthDataResult, error) in
            if error != nil {
                completion(error,nil)
                return
            }
            
            if let user = AuthDataResult?.user {
                completion(nil,user)
                return
            }
        }
    }
    
    
    
    
    
}
