//
//  FilmDS.swift
//  TicketBooking
//
//  Created by Kirill on 07.01.2024.
//

import Foundation

// MARK: - FilmDS
struct FilmDS: Codable {
    
    // MARK: Свойства экземпляров структуры
    let name: String
    let description: String
    let imagesNames: [String]
    
}
