//
//  FilmAbstractFactory.swift
//  TicketBooking
//
//  Created by Kirill on 06.01.2024.
//

import Foundation
import CoreDomain

// MARK: - FilmScreeningDSFactory
struct FilmScreeningDSFactory {
    
    // MARK: Методы структуры
    private static func createFilmScreeningDS(name: String,
                                              description: String,
                                              imagesNames: [String],
                                              dateInISO8601: String,
                                              reservedSeats: [Int]) -> FilmScreeningDS {
        
        var seats: [String: Bool] = [:]
        for seatNumber in 1...SeatingDS.seatsCount {
            if reservedSeats.contains(seatNumber) {
                seats[String(seatNumber)] = true
            } else {
                seats[String(seatNumber)] = false
            }
        }
        
        return FilmScreeningDS(film: FilmDS(name: name, description: description, imagesNames: imagesNames),
                               dateInISO8601: dateInISO8601,
                               seating: SeatingDS(reservedSeats: seats))
        
    }
    
}

// MARK: - Интерфейс структуры FilmScreeningDSFactory
extension FilmScreeningDSFactory {
    
    // MARK: Возвращает сеанс фильма "Матрица"
    static func createMatrixFilmScreening(dateInISO8601: String, reservedSeats: [Int] = []) -> FilmScreeningDS {
        return createFilmScreeningDS(name: "Матрица",
                                     description: "Фильм изображает будущее, в котором реальность, существующая для большинства людей, является в действительности симуляцией типа «мозг в колбе», созданной разумными машинами, чтобы подчинить и усмирить человеческое население, в то время как тепло и электрическая активность их тел используются машинами в качестве источника энергии. Привлечённый повстанцами против машин хакер по кличке Нео оказывается в новом, пугающем реальном мире. Он проходит выбор — вернуться к существованию в симуляции, либо начать повстанческую борьбу против машин, в которую также вовлечены другие люди, освободившиеся из «мира снов» и выбравшиеся в реальность. Он выбирает борьбу.",
                                     imagesNames: [ImagesNames.Matrix.Matrix1.rawValue,
                                                   ImagesNames.Matrix.Matrix2.rawValue,
                                                   ImagesNames.Matrix.Matrix3.rawValue],
                                     dateInISO8601: dateInISO8601,
                                     reservedSeats: reservedSeats)
    }
    
    // MARK: Возвращает сеанс фильма "Бесславные ублюдки"
    static func createInglouriousBasterdsFilmScreening(dateInISO8601: String, reservedSeats: [Int] = []) -> FilmScreeningDS {
        return createFilmScreeningDS(name: "Бесславные ублюдки",
                                     description: "Вторая Мировая война близится к концу. Американский лейтенант Альдо Рейн и его отряд «Бесславные ублюдки» отправляются в Европу, чтобы противостоять зверствам нацистов их же методами.",
                                     imagesNames: [ImagesNames.InglouriousBasterds.InglouriousBasterds1.rawValue,
                                                   ImagesNames.InglouriousBasterds.InglouriousBasterds2.rawValue,
                                                   ImagesNames.InglouriousBasterds.InglouriousBasterds3.rawValue],
                                     dateInISO8601: dateInISO8601,
                                     reservedSeats: reservedSeats)
    }
    
    // MARK: Возвращает сеанс фильма "Аватар"
    static func createAvatarFilmScreening(dateInISO8601: String, reservedSeats: [Int] = []) -> FilmScreeningDS {
        return createFilmScreeningDS(name: "Аватар",
                                     description: "Бывший морпех Джейк Салли прикован к инвалидному креслу. Несмотря на немощное тело, Джейк в душе по-прежнему остается воином. Он получает задание совершить путешествие в несколько световых лет к базе землян на планете Пандора, где корпорации добывают редкий минерал, имеющий огромное значение для выхода Земли из энергетического кризиса.",
                                     imagesNames: [ImagesNames.Avatar.Avatar1.rawValue,
                                                   ImagesNames.Avatar.Avatar2.rawValue,
                                                   ImagesNames.Avatar.Avatar3.rawValue],
                                     dateInISO8601: dateInISO8601,
                                     reservedSeats: reservedSeats)
    }
    
    // MARK: Возвращает сеанс фильма "Гарри Поттер и философский камень"
    static func createHarryPotterFilmScreening(dateInISO8601: String, reservedSeats: [Int] = []) -> FilmScreeningDS {
        return createFilmScreeningDS(name: "Гарри Поттер и философский камень",
                                     description: "Жизнь десятилетнего Гарри Поттера нельзя назвать сладкой: родители умерли, едва ему исполнился год, а от дяди и тёти, взявших сироту на воспитание, достаются лишь тычки да подзатыльники. Но в одиннадцатый день рождения Гарри всё меняется. Странный гость, неожиданно появившийся на пороге, приносит письмо, из которого мальчик узнаёт, что на самом деле он - волшебник и зачислен в школу магии под названием Хогвартс. А уже через пару недель Гарри будет мчаться в поезде Хогвартс-экспресс навстречу новой жизни, где его ждут невероятные приключения, верные друзья и самое главное — ключ к разгадке тайны смерти его родителей.",
                                     imagesNames: [ImagesNames.HarryPotter.HarryPotter1.rawValue,
                                                   ImagesNames.HarryPotter.HarryPotter2.rawValue,
                                                   ImagesNames.HarryPotter.HarryPotter3.rawValue],
                                     dateInISO8601: dateInISO8601,
                                     reservedSeats: reservedSeats)
    }
    
}
