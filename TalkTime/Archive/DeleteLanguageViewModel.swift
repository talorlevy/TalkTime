//
//  LanguageViewModel.swift
//  TalkTime
//
//  Created by Talor Levy on 3/10/23.
//

import UIKit
import Loki


class DeleteLanguageViewModel {
    
    var vc: UIViewController
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    
    func setAppLanguage(index: Int) {
        let language = LKManager.sharedInstance()?.languages[index] as! LKLanguage
        LKManager.sharedInstance()?.currentLanguage = language
    }
}
