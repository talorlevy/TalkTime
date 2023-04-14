//
//  SettingsViewController.swift
//  TalkTime
//
//  Created by Talor Levy on 4/1/23.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func changePasswordAction(_ sender: UITapGestureRecognizer) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as? ChangePasswordViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deleteAccountAction(_ sender: UITapGestureRecognizer) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeleteAccountViewController") as? DeleteAccountViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func languageAction(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LanguageViewController") as? LanguageViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
