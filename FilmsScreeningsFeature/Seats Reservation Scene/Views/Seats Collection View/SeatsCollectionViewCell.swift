//
//  SeatsCollectionViewCell.swift
//  FilmsScreeningsFeature
//
//  Created by Kirill on 11.01.2024.
//

import UIKit
import CoreDomain

// MARK: - SeatsCollectionViewCell
final class SeatsCollectionViewCell: UICollectionViewCell {
    
    // MARK: Свойсва класса
    static let reuseId = "SeatsCollectionViewCell"
    
    // MARK: Свойства объектов класса
    private var imageView: UIImageView!
    private var numberLabel: UILabel!
    private var stackView: UIStackView!
    private (set) var state: State {
        didSet {
            self.setImageToImageView()
        }
    }
    
    // MARK: Инициализаторы
    
    override init(frame: CGRect) {
        self.state = .free
        super.init(frame: frame)
        self.setUpSeatsCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Вложенные типы данных
extension SeatsCollectionViewCell {
    enum State: Equatable {
        case selected, reserved, free
    }
    private enum ImageName: String {
        case chair
    }
}

// MARK: - Компоновка UI
private extension SeatsCollectionViewCell {
    
    // MARK: Настройка объекта SeatsCollectionViewCell
    func setUpSeatsCollectionViewCell() -> Void {
        self.setUpImageView()
        self.setUpNumberLabel()
        self.setUpStackView()
    }
    
    // MARK: Настройка imageView
    func setUpImageView() -> Void {
        self.imageView = UIImageView()
        self.setImageToImageView()
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFit
    }
    
    // MARK: Настройка numberLabel
    func setUpNumberLabel() -> Void {
        self.numberLabel = UILabel()
        self.numberLabel.font = .systemFont(ofSize: 17, weight: .thin)
        self.numberLabel.textColor = AppColor.SeatsReservationScene.seatNumberText.getColor()
        self.numberLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    // MARK: Настройка stackView
    func setUpStackView() -> Void {
        self.stackView =  UIStackView(arrangedSubviews: [self.imageView, self.numberLabel])
        self.stackView.axis = .vertical
        self.stackView.alignment = .center
        self.stackView.distribution = .fillProportionally
        self.addSubview(self.stackView)
        self.addConstraintsToStackView()
        self.stackView.spacing = 0
    }
    
    
    func addConstraintsToStackView() -> Void {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
}

// MARK: - Приватные методы
private extension SeatsCollectionViewCell {
    
    // MARK: Установка изображения
    func setImageToImageView() -> Void {
        var image = UIImage(named: ImageName.chair.rawValue)
        switch self.state {
        case .free: image = image?.withTintColor(AppColor.SeatsReservationScene.freeSeat.getColor())
        case .selected: image = image?.withTintColor(AppColor.SeatsReservationScene.highletedSeat.getColor())
        case .reserved: image = image?.withTintColor(AppColor.SeatsReservationScene.reservedSeat.getColor())
        }
        self.imageView.image = image
    }
    
}

// MARK: - Интерфейс объектов SeatsCollectionViewCell
extension SeatsCollectionViewCell {
    
    // MARK: Установка состояния
    func setState(state: State) {
        self.state = state
    }
    
    func setSeatNumber(number: Int) -> Void {
        self.numberLabel.text = String(number)
    }
    
}
