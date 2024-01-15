//
//  DataSource.swift
//  TicketBooking
//
//  Created by Kirill on 05.01.2024.
//

import Foundation
import CoreDomain

// MARK: - DataSource
public struct DataSource {
    
    // MARK: Свойства экземпляров структуры
    private var filmsScreeningsDictionary: [Int: FilmScreeningDS]
    
}

// MARK: - Extension DataSource
public extension DataSource {
    
    // MARK: Инициализаторы
    init() {
        
        let matrixOnJanuary15At12_00UTC: FilmScreeningDS =
        FilmScreeningDSFactory.createMatrixFilmScreening(dateInISO8601: "2024-01-31T12:00:00")
        
        let matrixOnJanuary15At21_00UTC: FilmScreeningDS =
        FilmScreeningDSFactory.createMatrixFilmScreening(dateInISO8601: "2024-01-31T21:00:00")
        
        let inglouriousBasterdsOnJanuary15At14_00UTC: FilmScreeningDS =
        FilmScreeningDSFactory.createInglouriousBasterdsFilmScreening(dateInISO8601: "2024-01-31T14:00:00")
        
        let inglouriousBasterdsOnJanuary15At23_00UTC: FilmScreeningDS =
        FilmScreeningDSFactory.createInglouriousBasterdsFilmScreening(dateInISO8601: "2024-01-31T23:00:00")
        
        let avatarOnJanuary15At17_00UTC: FilmScreeningDS =
        FilmScreeningDSFactory.createAvatarFilmScreening(dateInISO8601: "2024-01-31T17:00:00")
        
        let harryPotterOnJanuary15At19_00UTC: FilmScreeningDS =
        FilmScreeningDSFactory.createHarryPotterFilmScreening(dateInISO8601: "2024-01-31T19:00:00")
        
        self.filmsScreeningsDictionary = [matrixOnJanuary15At12_00UTC.id: matrixOnJanuary15At12_00UTC,
                                          matrixOnJanuary15At21_00UTC.id: matrixOnJanuary15At21_00UTC,
                                          inglouriousBasterdsOnJanuary15At14_00UTC.id: inglouriousBasterdsOnJanuary15At14_00UTC,
                                          inglouriousBasterdsOnJanuary15At23_00UTC.id: inglouriousBasterdsOnJanuary15At23_00UTC,
                                          avatarOnJanuary15At17_00UTC.id: avatarOnJanuary15At17_00UTC,
                                          harryPotterOnJanuary15At19_00UTC.id: harryPotterOnJanuary15At19_00UTC]
        
    }
    
}

// MARK: - Интерфейс экземпляров DataSource
public extension DataSource {
    
    // MARK: Отправляет массив сеансов в JSON формате
    func getFilmsScreeningsArray() throws -> Data {
        let filmsScreeningdsDSArray = [FilmScreeningDS](self.filmsScreeningsDictionary.values)
        if let jsonData = try? JSONEncoder().encode(filmsScreeningdsDSArray) {
            return jsonData
        } else {
            throw JSONError.filmScreeningDSArrayWasNotConvertedToData
        }
    }
    
    // MARK: Принимает сеанс фильма в JSON формате и обновляет этот сеанс в своем словаре
    mutating func putFilmScreening(data: Data) throws -> Bool {
        guard let filmScreeningDS = try? JSONDecoder().decode(FilmScreeningDS.self, from: data) else {
            throw JSONError.dataWasNotConvertedToFilmScreeningDS
        }
        if self.filmsScreeningsDictionary[filmScreeningDS.id] != nil {
            self.filmsScreeningsDictionary[filmScreeningDS.id] = filmScreeningDS
            return true
        } else {
            return false
        }
    }
    
}

// MARK: - DataSource + Codable
extension DataSource: Codable {
    
}
