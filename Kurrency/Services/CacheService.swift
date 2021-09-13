//
//  CacheService.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 13/09/21.
//

import Foundation

protocol CacheServiceType {
    func save(_ cache: ViewModelCache)
}

class CacheService: CacheServiceType {
    func save(_ cache: ViewModelCache) {
        UserDefaults.standard.setObject(cache, forKey: MainViewModel.id)
    }
}
