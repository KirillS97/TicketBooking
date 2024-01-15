//
//  AppColor.swift
//  CoreDomain
//
//  Created by Kirill on 12.01.2024.
//

import UIKit

// MARK: - AppColor enum
public enum AppColor {
    
    // MARK: FilmScreeningsListScene enum
    public enum FilmScreeningsListScene {
        case navigationBar
        case navigationBarText
        case collectionView
        case cell
        case filmName
        case filmScreeningDate
    }
    
    // MARK: FilmScreeningDetailScene enum
    public enum FilmScreeningDetailScene {
        case navigationBar
        case navigationBarText
        case scrollView
        case title
        case imageView
        case rootView
        case descriptionText
        case dateText
        case buttonTitleNormalText
        case buttonTitleHighlitedText
        case button
    }
    
    // MARK: SeatsReservationScene enum
    public enum SeatsReservationScene {
        case navigationBar
        case navigationBarText
        case rootView
        case stackView
        case collectionView
        case screen
        case freeSeat
        case highletedSeat
        case reservedSeat
        case seatNumberText
        case okButtonNormalText
        case okButtonHighlitedText
        case okButton
        case notice
    }
    
    // MARK: CongratulationScene eum
    public enum CongratulationScene {
        case rootView
        case stackView
        case imageView
        case text
    }
    
}

// MARK: - FilmScreeningsListScene + SceneColorProtocol
extension AppColor.FilmScreeningsListScene: SceneColorProtocol {
    
    public func getColor() -> UIColor {
        switch self {
        case .navigationBar:
            return UIColor(red: (4/255),   green: (12/255),  blue: (30/255),  alpha: 1)
        case .navigationBarText:
            return .white
        case .collectionView:
            return UIColor(red: (4/255),   green: (12/255),  blue: (30/255),  alpha: 1)
        case .cell:
            return UIColor(red: (38/255),  green: (42/255),  blue: (56/255),  alpha: 1)
        case .filmName:
            return .systemGray6
        case .filmScreeningDate:
            return .systemGray2
        }
    }
    
}

// MARK: - FilmScreeningDetailScene + SceneColorProtocol
extension AppColor.FilmScreeningDetailScene: SceneColorProtocol {
    
    public func getColor() -> UIColor {
        switch self {
        case .navigationBar:
            return UIColor(red: (4/255),   green: (12/255),  blue: (30/255),  alpha: 1)
        case .navigationBarText:
            return .white
        case .scrollView:
            return UIColor(red: (4/255),   green: (12/255),  blue: (30/255),  alpha: 1)
        case .title:
            return .white
        case .imageView:
            return UIColor(red: (4/255),   green: (12/255),  blue: (30/255),  alpha: 1)
        case .rootView:
            return UIColor(red: (4/255),   green: (12/255),  blue: (30/255),  alpha: 1)
        case .descriptionText:
            return .systemGray4
        case .dateText:
            return .systemGray6
        case .buttonTitleNormalText:
            return .white
        case .buttonTitleHighlitedText:
            return .systemGray4
        case .button:
            return .systemBlue
        }
    }
    
}

// MARK: - SeatsReservationScene + SceneColorProtocol
extension AppColor.SeatsReservationScene: SceneColorProtocol {
    
    public func getColor() -> UIColor {
        switch self {
        case .navigationBar:
            return .systemGray6
        case .navigationBarText:
            return .black
        case .rootView:
            return .systemGray6
        case .collectionView:
            return .systemGray6
        case .stackView:
            return .systemGray6
        case .screen:
            return .systemGray
        case .freeSeat:
            return .systemGray
        case .highletedSeat:
            return .systemGreen
        case .reservedSeat:
            return .systemRed
        case .seatNumberText:
            return .systemGray
        case .okButtonNormalText:
            return .white
        case .okButtonHighlitedText:
            return .systemGray3
        case .okButton:
            return .systemBlue
        case .notice:
            return .systemRed
        }
    }
    
}

// MARK: - CongratulationScene + SceneColorProtocol
extension AppColor.CongratulationScene: SceneColorProtocol {
    
    public func getColor() -> UIColor {
        switch self {
        case .rootView:
            return .systemGray6
        case .stackView:
            return .systemGray6
        case .imageView:
            return .systemGray6
        case .text:
            return .systemGray
        }
    }
    
}
