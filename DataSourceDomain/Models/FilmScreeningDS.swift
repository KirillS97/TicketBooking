//
//  FilmScreeningDS.swift
//  TicketBooking
//
//  Created by Kirill on 07.01.2024.
//

import Foundation

// MARK: - FilmScreeningDS
struct FilmScreeningDS: Codable {
    
    // MARK: Свойства экземпляров структуры
    let id: Int
    let film: FilmDS
    let dateInISO8601: String
    let seating: SeatingDS
    
    // MARK: Инициализаторы
    init(film: FilmDS, dateInISO8601: String, seating: SeatingDS) {
        self.film = film
        self.dateInISO8601 = dateInISO8601
        self.seating = seating
        
        var hasher = Hasher()
        hasher.combine(self.film.name)
        hasher.combine(self.dateInISO8601)
        
        self.id = hasher.finalize()
    }
    
}
