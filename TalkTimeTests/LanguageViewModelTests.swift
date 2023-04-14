//
//  LanguageViewModelTests.swift
//  TalkTimeTests
//
//  Created by Talor Levy on 3/23/23.
//

import XCTest
import Loki
@testable import TalkTime


final class LanguageViewModelTests: XCTestCase {

    var vc: UIViewController!
    var viewModel: DeleteLanguageViewModel!
    
    override func setUpWithError() throws {
        vc = UIViewController()
        viewModel = DeleteLanguageViewModel(vc: vc)
    }
    
    override func tearDownWithError() throws {
        vc = nil
        viewModel = nil
    }

    func testSetAppLanguageSuccess() throws {
        viewModel.setAppLanguage(index: 1)
        let language = LKManager.sharedInstance()?.languages[1] as! LKLanguage
        XCTAssertEqual(LKManager.sharedInstance()?.currentLanguage, language)
    }
}
