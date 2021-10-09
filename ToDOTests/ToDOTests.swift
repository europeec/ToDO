//
//  ToDOTests.swift
//  ToDOTests
//
//  Created by Дмитрий Юдин on 06.10.2021.
//

import XCTest
@testable import ToDO

class ToDOTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testAddModelText() throws {
        var configuration = CellsConfiguration.textFieldName
        XCTAssert(configuration.text == "Название", "placeholder for name textfield is uncorrectly")

        configuration = .textFieldDescription
        XCTAssert(configuration.text == "Описание", "placeholder for description textfield is uncorrectly")

        configuration = .toggle
        XCTAssert(configuration.text == "Весь день", "label for switch is uncorrectly")
        
        configuration = .endDate
        XCTAssert(configuration.text == "Конец", "label for end date is uncorrectly")
        
        configuration = .startDate
        XCTAssert(configuration.text == "Начало", "label for start date is uncorrectly")
    }
    
    func testTypeForIndexPath() throws {
        let types: [[CellsConfiguration]] = [[.textFieldName, .textFieldDescription], [.toggle, .startDate, .endDate]]
        
        for section in 0...1 {
            for row in 0...1+section {
                let indexPath = IndexPath(row: row, section: section)
                XCTAssert(CellsConfiguration.getTypeForIndexPath(indexPath) == types[section][row], "error define type \(section), \(row)")
            }
        }
        
        let indexPath = IndexPath(row: 3, section: 3)
        XCTAssert(CellsConfiguration.getTypeForIndexPath(indexPath) == nil, "non nil for not created seaction")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
