//
//  ConfigLoaderTest.swift
//  KurrencyTests
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import XCTest
@testable import Kurrency

class ConfigLoaderTest: XCTestCase {

    func testLoadConfig() {
        //Given
        let bundle = Bundle(for: type(of: self))
        
        //When
        let config = bundle.resolve(type: CurrencyLayerConfig.self, name: "TestConfig", ext: "plist")
        //Then
        XCTAssertEqual(config?.app_id, "f7f39d1f84074fdea979e6656994c954")
        XCTAssertEqual(config?.baseURL, URL(string:"https://openexchangerates.org/api"))
        XCTAssertEqual(config?.listPath, "/currencies.json")
        XCTAssertEqual(config?.ratePath, "/latest.json")
    }
    
    func testLoadConfigErrorFile() {
        //Given
        let bundle = Bundle(for: type(of: self))
        
        //When
        let config = bundle.resolve(type: CurrencyLayerConfig.self, name: "TestConfigFail", ext: "plist")
        //Then
        XCTAssertNil(config)

    }
    
    func testLoadConfigErrorDecoding() {
        //Given
        let bundle = Bundle(for: type(of: self))
        
        //When
        let config = bundle.resolve(type: CurrencyLayerConfig.self, name: "Info", ext: "plist")
        //Then
        XCTAssertNil(config)

    }


}
