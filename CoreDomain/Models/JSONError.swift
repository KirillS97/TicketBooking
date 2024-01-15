//
//  JSONError.swift
//  CoreDomain
//
//  Created by Kirill on 09.01.2024.
//

import Foundation

// MARK: - JSONError
public enum JSONError: Error {
    case filmScreeningDSArrayWasNotConvertedToData
    case dataWasNotConvertedToFilmScreeningDS
}
