//
//  Film.swift
//  TicketBooking
//
//  Created by Kirill on 05.01.2024.
//

import Foundation

// MARK: - Film
public struct Film: Codable {
    
    // MARK: Свойства экземпляров структуры
    public let name: String
    public let description: String
    public let imagesNames: [String]
    
}
