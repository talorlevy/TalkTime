//
//  SignInViewControllerExtensionViewController.swift
//  TalkTime
//
//  Created by Talor Levy on 6/5/23.
//

import FacebookLogin
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import UIKit

extension SignInViewController {
        
    // For trouble shooting - delete this later!
    func checkSignedInUsers() {
        print("SignInVC - Google: \(String(describing: GIDSignIn.sharedInstance.currentUser))")
        print("SignInVC - Facebook: \(String(describing: AccessToken.current))")
        print("SignInVC - Firebase: \(String(describing: Auth.auth().currentUser?.email))")
        print("Local user: \(String(describing: LocalData.shared.currentUser?.provider))")
    }

    func configureSignInViewModel() {
        signInViewModel = SignInViewModel(firebaseAuthManager: FirebaseAuthenticationManager.shared, firebaseDBManager: FirebaseDatabaseManager.shared, vc: self)
    }
    
    func checkIfLoggedIn() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.signInViewModel?.isLoggedIn() { result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success():
                        guard let vc = UIStoryboard(name: "SignedIn", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController else { return }
                        self.setRootViewController(vc: vc)
                    case .failure(let error):
                        print("Error fetching user at SignInViewController: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func localizeUI() {
        emailTextField.placeholder = SignInString.emailPlaceholder.localized.firstUppercased
        passwordTextField.placeholder = SignInString.passwordPlaceholder.localized.firstUppercased
        signInButton.setTitle(SignInString.signInButton.localized.capitalized, for: .normal)
        signUpButton.setTitle(SignInString.signUpButton.localized.capitalized, for: .normal)
        facebookButton.setTitle(SignInString.facebookButton.localized.capitalized, for: .normal)
        googleButton.setTitle(SignInString.googleButton.localized.capitalized, for: .normal)
    }
    
    func emailSignIn() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        signInViewModel?.signInWithEmail(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success():
                    print("Success fetching user at SignInViewController")
                    guard let vc = UIStoryboard(name: "SignedIn", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController else { return }
                    self.setRootViewController(vc: vc)
                case .failure(let error):
                    print("Error fetching user at SignInViewController: \(error)")
                }
            }
        }
    }
    
    func signInWithGoogle() {
        signInViewModel?.signInWithGoogle() { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success():
                    print("Success fetching user at SignInViewController")
                    guard let vc = UIStoryboard(name: "SignedIn", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController else { return }
                    self.setRootViewController(vc: vc)
                case .failure(let error):
                    print("Error fetching user at SignInViewController: \(error)")
                }
            }
        }
    }
    
    func signInWithFacebook() {
        signInViewModel?.signInWithFacebook() { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success():
                    print("Success fetching user at SignInViewController")
                    guard let vc = UIStoryboard(name: "SignedIn", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController else { return }
                    self.setRootViewController(vc: vc)
                case .failure(let error):
                    print("Error fetching user at SignInViewController: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func pushSignUpVC() {
        guard let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
