////
////  SettingsViewController.swift
////  FirebaseProjectV2
////
////  Created by Talor Levy on 2/28/23.
////
//
//import UIKit
//
//
//class DeleteSettingsViewController: UIViewController {
//
//    var settingsViewModel: DeleteSettingsViewModel?
//
//
//    //MARK: - @IBOutlet
//
//    @IBOutlet weak var profileButton: UIButton!
//    @IBOutlet weak var languageButton: UIButton!
//    @IBOutlet weak var signOutButton: UIButton!
//
//
//    //MARK: - override
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureSettingsViewModel()
//        localizeUI()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        localizeUI()
//    }
//
//
//    //MARK: - functions
//
//    func configureSettingsViewModel() {
//        settingsViewModel = DeleteSettingsViewModel(firebaseAuthManager: FirebaseAuthenticationManager.shared, vc: self)
//    }
//
//    func localizeUI() {
//        profileButton.setTitle(SettingsString.profileButton.localized.firstUppercased, for: .normal)
//        languageButton.setTitle(SettingsString.languageButton.localized.firstUppercased, for: .normal)
//        signOutButton.setTitle(SettingsString.signOutButton.localized.firstUppercased, for: .normal)
//    }
//
//
//    //MARK: - @IBAction
//
//    @IBAction func profileButtonAction(_ sender: Any) {
//        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeleteEditProfileViewController") as? DeleteEditProfileViewController else { return }
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    @IBAction func languageButtonAction(_ sender: Any) {
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "LanguageViewController") as? LanguageViewController else { return }
//        vc.delegate = self
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    @IBAction func signOutButtonAction(_ sender: Any) {
//        settingsViewModel?.signOut { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success():
//                print("Success signing out of SettingsViewController")
//                DispatchQueue.main.async {
//                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInNavigationController") as? UINavigationController else { return }
//                    self.setRootViewController(vc: vc)
//                }
//            case .failure(let error):
//                print("Error signing out of SettingsViewController: \(error.localizedDescription)")
//            }
//        }
//    }
//}
//
//
////MARK: - RefreshSettingsLocalization
//
//extension SettingsViewController: RefreshSettingsLocalization {
//
//    func refreshSettingsLocalization() {
//        localizeUI()
//    }
//}
