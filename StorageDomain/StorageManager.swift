//
//  StorageManager.swift
//  TicketBooking
//
//  Created by Kirill on 07.01.2024.
//

import Foundation
import DataSourceDomain

// MARK: - StorageManager
final public class StorageManager {
    
    // MARK: Свойства класса
    static public let shared = StorageManager()
    
    // MARK: Хранивые свойства объектов класса
    private let fileManager = FileManager.default
    
    // MARK: Вычисляемые свойства объектов класса
    private var documentsDirectoryURL: URL? {
        let urlArray: [URL] = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        return urlArray.first
    }
    
    private var storingDirectoryURL: URL? {
        if #available(iOS 16.0, *) {
            return self.documentsDirectoryURL?.appending(path: URLPath.storage.rawValue)
        } else {
            return self.documentsDirectoryURL?.appendingPathComponent("/\(URLPath.storage.rawValue)")
        }
    }
    
    private var storingFileURL: URL? {
        if #available(iOS 16.0, *) {
            return self.storingDirectoryURL?.appending(path: URLPath.filmsScreenings.rawValue)
        } else {
            return self.documentsDirectoryURL?.appendingPathComponent("/\(URLPath.filmsScreenings.rawValue)")
        }
    }
    
    // MARK: Инициализаторы
    private init() {}
    
}

// MARK: - Вложенные типы данных
extension StorageManager {
    
    // MARK: - URLPath enum
    private enum URLPath: String {
        case storage
        case filmsScreenings
    }
    
}

// MARK: - Приватные методы объектов StorageManager
private extension StorageManager {
    
    // MARK: Создание папки, в которой будет расположен файл хранения
    func createFolderForStoringFile() -> Void {
        guard let storingDirectoryURL else {
            return
        }
        
        if !self.fileManager.fileExists(atPath: storingDirectoryURL.path) {
            do {
                try self.fileManager.createDirectory(at: storingDirectoryURL, withIntermediateDirectories: true)
            } catch {
                debugPrint("Не удалось создать папку")
            }
        }
        
    }
    
}

// MARK: Интерфейс объектов StorageManager
public extension StorageManager {
    
    // MARK: Создание файла хранения с закодированными данными
    func save(dataSource: DataSource) -> Void {
        guard let storingFileURL else {
            return
        }
        if let encodedData = try? JSONEncoder().encode(dataSource) {
            self.createFolderForStoringFile()
            if !self.fileManager.createFile(atPath: storingFileURL.path, contents: encodedData) {
                debugPrint("не удалось создать файл")
            }
        }
    }
    
    // MARK: Извлечение декодированных данных из файла хранения
    func fetch() -> DataSource? {
        guard let storingFileURL else {
            return nil
        }
        if let encodedData = self.fileManager.contents(atPath: storingFileURL.path) {
            do {
                let decodedData = try JSONDecoder().decode(DataSource.self, from: encodedData)
                return decodedData
            } catch {
                debugPrint("Не удалось декодировать данные")
            }
        }
        return nil
    }
    
}
