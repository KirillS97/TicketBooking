//
//  FilmScreeningDetailViewModel.swift
//  FilmsScreeningsFeature
//
//  Created by Kirill on 10.01.2024.
//

import Foundation
import CoreDomain

// MARK: - FilmScreeningDetailViewModel
final class FilmScreeningDetailViewModel {
    
    // MARK: Свойства объектов класса
    private (set) var filmScreening: FilmScreening
    
    // MARK: Инициализаторы
    init(filmScreening: FilmScreening) {
        self.filmScreening = filmScreening
    }
    
}
