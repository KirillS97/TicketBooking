//
//  SeatingDS.swift
//  TicketBooking
//
//  Created by Kirill on 07.01.2024.
//

import Foundation

// MARK: - SeatingDS
struct SeatingDS: Codable {
    
    // MARK: Свойства структуры
    static let seatsCount = 10
    
    // MARK: Свойства экземпляров структуры
    let reservedSeats: [String: Bool] // Если значение == true, то место под номером, равным ключу, забронировано
    
}
