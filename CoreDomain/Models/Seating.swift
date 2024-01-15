//
//  Seating.swift
//  TicketBooking
//
//  Created by Kirill on 05.01.2024.
//

import Foundation


// MARK: - Seating
public struct Seating: Codable {
    
    // MARK: Свойства экземпляров структуры
    private (set) public var reservedSeats: [Int: Bool] // if true then seat is reserved
    
}

// MARK: - Интерфейс экземпляров Seating
public extension Seating {
    
    // MARK: reserveSeats
    mutating func reserveSeats(numbers: [Int]) -> Void {
        for number in numbers {
            if self.reservedSeats[number] != nil {
                self.reservedSeats[number] = true
            }
        }
    }
    
}
