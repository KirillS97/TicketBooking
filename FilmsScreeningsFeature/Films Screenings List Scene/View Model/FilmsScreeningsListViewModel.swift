//
//  FilmsScreeningsListViewModel.swift
//  FilmsScreeningsFeature
//
//  Created by Kirill on 09.01.2024.
//

import Foundation
import CoreDomain
import DataManagerDomain

// MARK: - FilmsScreeningsListViewModel
public final class FilmsScreeningsListViewModel {
    
    // MARK: Свойства объектов класса
    private let observableFilmsScreeningsList: Observable<[FilmScreening]>
    private let dataManager = DataManager.shared
    
    // MARK: Инициализаторы
    public init() {
        let initialObservableFilmsScreeningsList = Observable<[FilmScreening]>(value: [])
        self.observableFilmsScreeningsList = initialObservableFilmsScreeningsList
        self.loadFilmsScreeningsList()
    }
    
}

// MARK: - Приватные методы объектов FilmsScreeningsListViewModel
private extension FilmsScreeningsListViewModel {
    
    // MARK: Загрузка сеансов
    func loadFilmsScreeningsList() -> Void {
        Task {
            if let array = await self.dataManager.fetchFilmsScreeningsArray() {
                DispatchQueue.main.async {
                    self.observableFilmsScreeningsList.value = array
                }
            }
        }
    }
    
}

// MARK: - Интерфейс объектов FilmsScreeningsListViewModel
public extension FilmsScreeningsListViewModel {
    
    // MARK: Возвращает список сеансов
    var filmsScreeningsList: [FilmScreening] {
        let sortedArray = self.observableFilmsScreeningsList.value.sorted {
            if $0.getDate() != nil, $1.getDate() != nil {
                $0.getDate()! < $1.getDate()!
            } else {
                $0.film.name < $1.film.name
            }
        }
        return sortedArray
    }
    
    // MARK: Связывает вью контроллер с наблюдаемым свойством
    func bindWithObservableFilmsScreeningsList(reactiveAction: @escaping ([FilmScreening]) -> Void) -> Void {
        self.observableFilmsScreeningsList.bind(reactiveAction: reactiveAction)
    }
    
}
