//
//  ConfigManager.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 06/09/21.
//

import Foundation

class ConfigManager: NSObject {
    
    static var shared: ConfigManager {
        let config = Bundle.main.resolve(type: CurrencyLayerConfig.self, name: "Config", ext: "plist")!
        return ConfigManager(config: config)
    }
    
    private(set) var config: CurrencyLayerConfig
    init(config: CurrencyLayerConfig) {
        self.config = config
    }
}
