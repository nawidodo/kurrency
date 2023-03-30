//
//  CacheService.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 28/03/23.
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
