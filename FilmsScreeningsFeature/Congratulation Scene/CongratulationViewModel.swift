//
//  CongratulationViewModel.swift
//  FilmsScreeningsFeature
//
//  Created by Kirill on 12.01.2024.
//

import Foundation
import CoreDomain

// MARK: - FilmScreeningDetailViewModel
final class CongratulationViewModel {
    
    // MARK: Свойства объектов класса
    private (set) var filmScreening: FilmScreening
    private (set) var selectedSeatsNumbers: [Int]
    
    // MARK: Инициализаторы
    init(filmScreening: FilmScreening, selectedSeatsNumbers: [Int]) {
        self.filmScreening = filmScreening
        self.selectedSeatsNumbers = selectedSeatsNumbers
    }
    
}
