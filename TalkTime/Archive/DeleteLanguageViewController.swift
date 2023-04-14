////
////  LanguageViewController.swift
////  TalkTime
////
////  Created by Talor Levy on 3/7/23.
////
//
//import UIKit
//
//
//protocol RefreshSettingsLocalization {
//    func refreshSettingsLocalization()
//}
//
//
//class DeleteLanguageViewController: UIViewController {
//
//    var languageViewModel: DeleteLanguageViewModel?
//    var delegate: RefreshSettingsLocalization?
//
//
//    //MARK: - @Outlet
//
//    @IBOutlet weak var englishButton: UIButton!
//    @IBOutlet weak var spanishButton: UIButton!
//    @IBOutlet weak var germanButton: UIButton!
//
//
//    //MARK: - override
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureLanguageViewModel()
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
//    func configureLanguageViewModel() {
//        languageViewModel = DeleteLanguageViewModel(vc: self)
//    }
//
//    func localizeUI() {
//        englishButton.setTitle(LanguageString.englishButton.localized.capitalized, for: .normal)
//        spanishButton.setTitle(LanguageString.spanishButton.localized.capitalized, for: .normal)
//        germanButton.setTitle(LanguageString.germanButton.localized.capitalized, for: .normal)
//    }
//
//    func localizeTabBar() {
//        guard let tabBarItems = tabBarController?.tabBar.items else { return }
//        tabBarItems[0].title = MainTabBarControllerString.homeTab.localized.firstUppercased
//        tabBarItems[1].title = MainTabBarControllerString.messageTab.localized.firstUppercased
//        tabBarItems[2].title = MainTabBarControllerString.postTab.localized.firstUppercased
//        tabBarItems[3].title = MainTabBarControllerString.searchTab.localized.firstUppercased
//        tabBarItems[4].title = MainTabBarControllerString.settingsTab.localized.firstUppercased
//    }
//
//
//    //MARK: - @IBAction
//
//    @IBAction func englishButtonAction(_ sender: Any) {
//        languageViewModel?.setAppLanguage(index: 0)
//        englishButton.setTitle(LanguageString.englishButton.localized.capitalized, for: .normal)
//        spanishButton.setTitle(LanguageString.spanishButton.localized.capitalized, for: .normal)
//        germanButton.setTitle(LanguageString.germanButton.localized.capitalized, for: .normal)
//        localizeTabBar()
//        if let delegate = delegate { delegate.refreshSettingsLocalization() }
//    }
//
//    @IBAction func spanishButtonAction(_ sender: Any) {
//        languageViewModel?.setAppLanguage(index: 1)
//        englishButton.setTitle(LanguageString.englishButton.localized.capitalized, for: .normal)
//        spanishButton.setTitle(LanguageString.spanishButton.localized.capitalized, for: .normal)
//        germanButton.setTitle(LanguageString.germanButton.localized.capitalized, for: .normal)
//        localizeTabBar()
//        if let delegate = delegate { delegate.refreshSettingsLocalization() }
//    }
//
//    @IBAction func germanButtonAction(_ sender: Any) {
//        languageViewModel?.setAppLanguage(index: 2)
//        englishButton.setTitle(LanguageString.englishButton.localized.capitalized, for: .normal)
//        spanishButton.setTitle(LanguageString.spanishButton.localized.capitalized, for: .normal)
//        germanButton.setTitle(LanguageString.germanButton.localized.capitalized, for: .normal)
//        localizeTabBar()
//        if let delegate = delegate { delegate.refreshSettingsLocalization() }
//    }
//}
