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
import FirebaseFirestoreSwift

class FirebaseAPI {
    
    static let shared = FirebaseAPI()
    
    let userCollection = "users"
    let eventCollection = "events"
    
    private let database = Firestore.firestore()
    
    private init(){}
    
    // MARK: - Login Functions
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
    
    // MARK: - Update Email/Password
    func updateEmail(to email: String, completion: @escaping(Error?)->Void) {
        Auth.auth().currentUser?.updateEmail(to: email, completion: { (error) in
            if error != nil {
                completion(error)
            } else {
                completion(nil)
            }
        })
    }
    
    func updatePassword(to password: String, completion: @escaping(Error?)->Void){
        Auth.auth().currentUser?.updatePassword(to: password, completion: { (error) in
            if error != nil {
                completion(error)
            } else {
                completion(nil)
            }
        })
    }
    
    func forgotPassword(to email: String, completion: @escaping(Error?)->Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    // MARK: - Update User Profile
    func updateName(firstName: String, lastName: String, completion: @escaping(Error?)->Void){
        if let userID = Auth.auth().currentUser?.uid {
            let data = try! Firestore.Encoder().encode(UserData(firstName: firstName, lastName: lastName))
            database.collection(userCollection).document(userID).setData(data, merge: true,completion: completion)
        } else {
            completion(FirebaseAPIError.noUID)
        }
    }
    
    func updateCreditCard(cards: [CreditCard], completion: @escaping(Error?)->Void){
        if let userID = Auth.auth().currentUser?.uid {
            let data = try! Firestore.Encoder().encode(UserData(firstName: nil, lastName: nil, cards: cards))
            database.collection(userCollection).document(userID).setData(data, merge: true,completion: completion)
        } else {
            completion(FirebaseAPIError.noUID)
        }
    }
    
    func updateFavorites(favorites: [String], completion: @escaping(Error?)->Void){
        if let userID = Auth.auth().currentUser?.uid {
            let data = try! Firestore.Encoder().encode(UserData(firstName: nil, lastName: nil, cards: nil, favorites: favorites))
            database.collection(userCollection).document(userID).setData(data, merge: true,completion: completion)
        } else {
            completion(FirebaseAPIError.noUID)
        }
    }
    
    
    // MARK: - Get User
    func getUser(completion: @escaping(Error?,UserData?)->Void){
        if let userID = Auth.auth().currentUser?.uid {
            database.collection(userCollection).document(userID).getDocument { (snapshot, error) in
                if let error = error {
                    completion(error,nil)
                }
                
                if let snapshot = snapshot, snapshot.exists {
                    let user = try! snapshot.data(as: UserData.self)
                    completion(nil,user)
                }
            }
        }
    }
    
    // MARK: - Get Event
    private func getMockaroo(min: Int,max:Int, completion: @escaping(Error?, Event?)->Void) {
        guard let url = URL(string: "https://my.api.mockaroo.com/eventseating.json?key=7b35a740&min=\(min)&max=\(max)")
        else {
            completion(FirebaseAPIError.invalidURL, nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(error, nil)
                return
            }
            
            
            if let response = response as? HTTPURLResponse, !(200...299 ~= response.statusCode) {
                completion(FirebaseAPIError.unsuccesfulStatusCode, nil)
                return
            }
            
            if let data = data {
                do {
                    let event = try JSONDecoder().decode(Event.self, from: data)
                    completion(nil, event)
                } catch {
                    completion(FirebaseAPIError.decodableError, nil)
                }
            }
        }.resume()
        
    }
    
    private func addMockarooToServer(event: Event, completion: @escaping(Error?)->Void){
        if let eventID = event.eventID {
                let data = try! Firestore.Encoder().encode(event)
                database.collection(eventCollection).document(eventID).setData(data, merge: true,completion: completion)
            } else {
                completion(FirebaseAPIError.noEventID)
            }
    }
    
    func getEvent(eventID: String, completion: @escaping(Error?,Event?)->Void) {
        if isLoggedIn() {
            database.collection(eventCollection).document(eventID).getDocument { (snapshot, error) in
                if let error = error {
                    completion(error,nil)
                    return
                }
                
                if let snapshot = snapshot, snapshot.exists {
                    let event = try! snapshot.data(as: Event.self)
                    event?.eventID = snapshot.documentID
                    completion(nil,event)
                } else {
                    self.getMockaroo(min: 10, max: 100) { (error, event) in
                        if let error = error {
                            completion(error,nil)
                        }
                        
                        if let event = event {
                            event.eventID = eventID
                            self.addMockarooToServer(event: event) { (error) in
                                if let error = error {
                                    completion(error, nil)
                                } else {
                                    completion(nil,event)
                                }
                            }
                        }
                    }
                }
            }
        } else {
            completion(FirebaseAPIError.noUID, nil)
        }
    }
    
    
}

enum FirebaseAPIError: Error {
    case noUID
    case unsuccesfulStatusCode
    case invalidURL
    case decodableError
    case noEventID
}
