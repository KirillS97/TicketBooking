//
//  SeatsReservationViewModel.swift
//  FilmsScreeningsFeature
//
//  Created by Kirill on 11.01.2024.
//

import Foundation
import CoreDomain
import DataManagerDomain

// MARK: - SeatsReservationViewModel
final class SeatsReservationViewModel {
    
    // MARK: Свойства объектов класса
    private let dataManager = DataManager.shared
    private var observableFilmScreening: Observable<FilmScreening?>
    private (set) var selectedSeatsNumbers: [Int] = []
    
    // MARK: Инициализаторы
    init (filmScreeningId: Int) {
        self.observableFilmScreening = .init(value: nil)
        self.fetchFilmScreening(filmScreeningId: filmScreeningId)
    }
    
}

// MARK: - Приватные методы объектов SeatsReservationViewModel
private extension SeatsReservationViewModel {
    
    // MARK: Получение объекта FilmScreening
    func fetchFilmScreening(filmScreeningId: Int) -> Void {
        Task {
            if let filmScreening = await self.dataManager.fetchFilmScreening(filmScreeningId: filmScreeningId) {
                DispatchQueue.main.async {
                    self.observableFilmScreening.value = filmScreening
                }
            }
        }
    }
    
}

// MARK: - Интерфес объектов SeatsReservationViewModel
extension SeatsReservationViewModel {
    
    // MARK: биндинг вью контроллера с наблюдаемой моделью
    func bindWithObservableFilmScreening(reactiveAction: @escaping (FilmScreening?) -> Void) -> Void {
        self.observableFilmScreening.bind(reactiveAction: reactiveAction)
    }
    
    // MARK: объект FilmScreening для доступа из вью контроллера
    var filmScreening: FilmScreening? {
        return self.observableFilmScreening.value
    }
    
    // MARK: Бронирование выбранных мест. True, если места были забронированы
    func reserveSeats() -> Bool {
        
        guard !self.selectedSeatsNumbers.isEmpty else {
            return false
        }
        guard let filmScreening else {
            return false
        }
        
        var updatedFilmScreening = filmScreening
        updatedFilmScreening.reserveSeats(numbers: self.selectedSeatsNumbers)
        
        self.observableFilmScreening.value = updatedFilmScreening
        
        if observableFilmScreening.value != nil {
            Task {
                await self.dataManager.putFilmScreening(filmScreening: self.observableFilmScreening.value!)
            }
        }
        
        return true
    }
    
    // MARK: Выбор места. True, если требуется обновить UI
    func selectSeat(number: Int) -> Bool {
        guard let filmScreening else {
            return false
        }
        guard let isReserved = filmScreening.seating.reservedSeats[number] else {
            return false
        }
        guard isReserved == false else {
            return false
        }
        if self.selectedSeatsNumbers.contains(number) {
            self.selectedSeatsNumbers.removeAll {
                $0 == number
            }
        } else {
            self.selectedSeatsNumbers.append(number)
        }
        return true
    }
    
}
