//
//  FilmScreening.swift
//  TicketBooking
//
//  Created by Kirill on 05.01.2024.
//

import Foundation

// MARK: - FilmScreening
public struct FilmScreening: Codable {
    
    // MARK: Свойства экземпляров структуры
    public let id: Int
    public let film: Film
    public let dateInISO8601: String
    private (set) public var seating: Seating
    
}

// MARK: - Интерфейс экземпляров FilmScreening
public extension FilmScreening {
    
    // MARK: getStringDate
    func getStringDate() -> String {
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "HH:mm, dd.MM.yyyy"
        dateFormatterOutput.timeZone = .init(identifier: "UTC")
        
        if let date = self.getDate() {
            return dateFormatterOutput.string(from: date)
        } else {
            return "Не удалось получить дату"
        }
    }
    
    // MARK: getDate
    func getDate() -> Date? {
        let dateFormatterInput = ISO8601DateFormatter()
        dateFormatterInput.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        return dateFormatterInput.date(from: self.dateInISO8601)
    }
    
    // MARK: reserveSeats
    mutating func reserveSeats(numbers: [Int]) -> Void {
        self.seating.reserveSeats(numbers: numbers)
    }
    
}
