//
//  Bundle+Extensions.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 11/09/21.
//

import Foundation

extension Bundle {
    func resolve<T: Codable>(type: T.Type, name: String, ext: String) -> T? {
        let decoder = PropertyListDecoder()
        
        do {
            guard let bundle = self.path(forResource: name, ofType: ext), let data = FileManager.default.contents(atPath: bundle) else {
                return nil
            }
            let config = try decoder.decode(type, from: data)
            return config
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
