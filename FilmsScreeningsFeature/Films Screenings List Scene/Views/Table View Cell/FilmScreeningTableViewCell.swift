//
//  FilmScreeningTableViewCell.swift
//  TicketBooking
//
//  Created by Kirill on 07.01.2024.
//

import UIKit
import Core_UI
import CoreDomain

// MARK: - FilmScreeningTableViewCell
final class FilmScreeningTableViewCell: UITableViewCell {
    
    // MARK: Свойства класса
    static let reuseId = "FilmScreeningTableViewCell"
    
    // MARK: Свойства объектов класса
    private var verticalStakView: UIStackView!
    private var uiImageView: UIImageView!
    private var nameLabel: UILabel!
    private var dateLabel: UILabel!
    
    // MARK: Инициалищаторы
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpFilmScreeningTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Компоновка UI
private extension FilmScreeningTableViewCell {
    
    // MARK: Настройка ячейки FilmScreeningTableViewCell
    func setUpFilmScreeningTableViewCell() -> Void {
        self.setUpUiImageView()
        self.setUpNameLabel()
        self.setUpDateLabel()
        self.setUpVerticalStakView()
        self.backgroundColor = AppColor.FilmScreeningsListScene.collectionView.getColor()
        self.selectionStyle = .none
    }
    
    // MARK: Настройка uiImageView
    func setUpUiImageView() -> Void {
        self.uiImageView = UIImageView()
        self.uiImageView.contentMode = .scaleAspectFit
        self.uiImageView.layer.cornerRadius = 15
        self.uiImageView.clipsToBounds = true
    }
    
    // MARK: Настройка nameLabel
    func setUpNameLabel() -> Void {
        self.nameLabel = UILabel()
        self.nameLabel.font = .systemFont(ofSize: 22, weight: .light)
        self.nameLabel.textColor = AppColor.FilmScreeningsListScene.filmName.getColor()
        self.nameLabel.numberOfLines = 0
    }
    
    // MARK: Настройка dateLabel
    func setUpDateLabel() -> Void {
        self.dateLabel = UILabel()
        self.dateLabel.font = .systemFont(ofSize: 18, weight: .light)
        self.dateLabel.textColor = AppColor.FilmScreeningsListScene.filmScreeningDate.getColor()
    }
    
    // MARK: Настройка verticalStakView
    func setUpVerticalStakView() -> Void {
        self.verticalStakView = UIStackView(arrangedSubviews: [self.uiImageView, self.nameLabel, self.dateLabel])
        self.verticalStakView.axis = .vertical
        self.verticalStakView.alignment = .center
        self.verticalStakView.spacing = 10
        self.addSubview(self.verticalStakView)
        self.addConstraintsToVerticalStakView()
        self.verticalStakView.backgroundColor = AppColor.FilmScreeningsListScene.cell.getColor()
        self.verticalStakView.isLayoutMarginsRelativeArrangement = true
        self.verticalStakView.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        self.verticalStakView.layer.cornerRadius = 15
    }
    
    func addConstraintsToVerticalStakView() -> Void {
        self.verticalStakView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.verticalStakView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.verticalStakView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.verticalStakView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.verticalStakView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.nameLabel.widthAnchor.constraint(equalTo: self.uiImageView.widthAnchor),
            self.dateLabel.widthAnchor.constraint(equalTo: self.nameLabel.widthAnchor)
        ])
    }
    
}

// MARK: - Переопределённые методы
extension FilmScreeningTableViewCell {
    
    // MARK: prepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.uiImageView.image = nil
        self.nameLabel.text = ""
    }
    
}

// MARK: - Интерфейс объекта FilmScreeningTableViewCell
extension FilmScreeningTableViewCell {
    
    // MARK: Установка текста метки с названием фильма
    func setNameLabelText(text: String) -> Void {
        self.nameLabel.text = text
    }
    
    // MARK: Установка изображения фильма
    func setImage(image: UIImage) -> Void {
        self.uiImageView.image = image
        self.uiImageView.updateHeight()
    }
    
    // MARK: Установка даты
    func setDate(stringDate: String) -> Void {
        self.dateLabel.text = stringDate
    }
    
}
