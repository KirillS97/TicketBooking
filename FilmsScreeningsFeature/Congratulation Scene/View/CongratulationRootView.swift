//
//  CongratulationRootView.swift
//  FilmsScreeningsFeature
//
//  Created by Kirill on 12.01.2024.
//

import UIKit
import CoreDomain

// MARK: - CongratulationRootView
final class CongratulationRootView: UIView {
    
    // MARK: Свойства объектов класса
    private var imageView: UIImageView!
    private var congratulationLabel: UILabel!
    private var stackView: UIStackView!
    
    // MARK: Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpCongratulationRootView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Компоновка UI
private extension CongratulationRootView {
    
    // MARK: Настройка объекта CongratulationRootView
    func setUpCongratulationRootView() -> Void {
        self.setUpImageView()
        self.setUpCongratulationLabel()
        self.setUpStackView()
        self.backgroundColor = AppColor.CongratulationScene.rootView.getColor()
    }
    
    // MARK: Настройка imageView
    func setUpImageView() -> Void {
        self.imageView = UIImageView(image: UIImage(named: CongratulationRootView.ImageName.congratulation.rawValue))
        self.imageView.contentMode = .scaleAspectFit
    }
    
    // MARK: Настройка congratulationLabel
    func setUpCongratulationLabel() -> Void {
        self.congratulationLabel = UILabel()
        self.congratulationLabel.textColor = AppColor.CongratulationScene.text.getColor()
        self.congratulationLabel.numberOfLines = 0
    }
    
    // MARK: Настройка stackView
    func setUpStackView() -> Void {
        self.stackView = UIStackView(arrangedSubviews: [self.imageView, self.congratulationLabel])
        self.addSubview(self.stackView)
        self.addConstraintToStackView()
        self.stackView.axis = .vertical
        self.stackView.alignment = .center
        self.stackView.distribution = .fillEqually
        self.stackView.isLayoutMarginsRelativeArrangement = true
        self.stackView.layoutMargins = .init(top: 50, left: 20, bottom: 50, right: 20)
    }
    
    func addConstraintToStackView() -> Void {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

// MARK: - Вложенные типы данных
private extension CongratulationRootView {
    private enum ImageName: String {
        case congratulation
    }
}

// MARK: - Интерфейс объектов CongratulationRootView
extension CongratulationRootView {
    
    // MARK: Конфигурация контента объекта CongratulationRootView
    func setCongratulationLabelText(filmName: String, stringDate: String, seatsNumbers: [Int]) -> Void {
        guard !seatsNumbers.isEmpty else {
            return
        }
        let firstTextPart = "Ждём вас в \(stringDate) на просмотре фильма \"\(filmName)\"."
        var secondTextPart: String
        if seatsNumbers.count == 1 {
            secondTextPart = "Ваше место: \(seatsNumbers.first!)"
        } else {
            secondTextPart = "Ваши места: "
            for i in 0..<seatsNumbers.count {
                if i == seatsNumbers.count - 1 {
                    secondTextPart.append(String(seatsNumbers[i]))
                } else {
                    secondTextPart.append("\(seatsNumbers[i]), ")
                }
            }
        }
        self.congratulationLabel.text = "\(firstTextPart) \(secondTextPart)"
    }
    
}
