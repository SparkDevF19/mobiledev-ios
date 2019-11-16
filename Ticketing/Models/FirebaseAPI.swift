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
    
    //Sign In with google will delete the current account of anonymous, and will sign In, if signIn fails then anonymous account is created again
    public func loginUser(withGoogle signIn: GIDSignIn, didSignInFor user: GIDGoogleUser, completion: @escaping (Error?, AuthDataResult?) -> Void) {
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        if Auth.auth().currentUser?.isAnonymous ?? false {
            Auth.auth().currentUser?.delete(completion: { (error) in
                Auth.auth().signIn(with: credential) { (AuthDataResult, error) in
                    if error != nil {
                        self.loginAnonymously { (error, user) in
                            completion(error,AuthDataResult)
                        }
                        return
                    }
                    
                    if let result = AuthDataResult {
                        completion(nil, result)
                        return
                    }
                }
            })
        } else {
            Auth.auth().signIn(with: credential) { (AuthDataResult, error) in
                if error != nil {
                    self.loginAnonymously { (error, user) in
                        completion(error,AuthDataResult)
                    }
                    return
                }
                
                if let result = AuthDataResult {
                    completion(nil, result)
                    return
                }
            }
        }
    }
    
    //Links Anonymous account with new registered email, will return error if email already in use
    public func registerUser(email: String, password: String, completion: @escaping(Error?,User?)-> Void){
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        if Auth.auth().currentUser?.isAnonymous ?? false {
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
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { (AuthDataResult, error) in
                if error != nil {
                    completion(error, nil)
                    return
                }
                
                if let user = AuthDataResult?.user {
                    completion(nil, user)
                }
            }
        }
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
