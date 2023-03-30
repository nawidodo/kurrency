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
        XCTAssertEqual(config?.accessKey, "2e480d92-13b6-11ec-82a8-0242ac130003")
        XCTAssertEqual(config?.baseURL, URL(string: "http://api.currencylayer.com"))
        XCTAssertEqual(config?.listPath, "/list")
        XCTAssertEqual(config?.ratePath, "/live")
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
