//
//  DataManager.swift
//  TicketBooking
//
//  Created by Kirill on 07.01.2024.
//

import Foundation
import DataSourceDomain
import StorageDomain
import CoreDomain

// MARK: - DataManager
public final class DataManager {
    
    // MARK: Свойсва класса
    public static let shared = DataManager()
    
    // MARK: Свойства объекта класса
    private let storageMaganer: StorageManager
    private var dataSource: DataSource
    
    // MARK: Инициализаторы
    private init() {
        self.storageMaganer = StorageManager.shared
        if let savedDataSource = self.storageMaganer.fetch() {
            self.dataSource = savedDataSource
        } else {
            self.dataSource = DataSource()
        }
    }
    
}

// MARK: - Интерфейс объектов класса
public extension DataManager {
    
    // MARK: Отправка запроса источнику данных и возврат массива сеансов
    func fetchFilmsScreeningsArray() async -> [FilmScreening]? {
        sleep(1)
        if let jsonData = try? self.dataSource.getFilmsScreeningsArray() {
            if let filmsScreeningsArray = try? JSONDecoder().decode([FilmScreening].self, from: jsonData) {
                return filmsScreeningsArray
            }
        }
        return nil
    }
    
    func fetchFilmScreening(filmScreeningId: Int) async -> FilmScreening? {
        var returnedFilmScreening: FilmScreening? = nil
        if let filmScreeingsArray = await self.fetchFilmsScreeningsArray() {
            filmScreeingsArray.forEach { (filmScreening: FilmScreening) in
                if filmScreening.id == filmScreeningId {
                    returnedFilmScreening = filmScreening
                }
            }
        }
        return returnedFilmScreening
    }
    
    // MARK: Отправка запроса на изменение с сеансом фильма источнику данных
    func putFilmScreening(filmScreening: FilmScreening) async -> Void {
        sleep(1)
        if let jsonData = try? JSONEncoder().encode(filmScreening) {
            if (try? self.dataSource.putFilmScreening(data: jsonData)) != nil {
                self.storageMaganer.save(dataSource: self.dataSource)
            }
        }
    }
    
}
