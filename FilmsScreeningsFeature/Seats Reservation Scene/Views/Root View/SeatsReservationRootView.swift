//
//  SeatsReservationRootView.swift
//  FilmsScreeningsFeature
//
//  Created by Kirill on 11.01.2024.
//

import UIKit
import CoreDomain

// MARK: - SeatsReservationRootView
final class SeatsReservationRootView: UIView {
    
    // MARK: Свойства объектов класса
    private var screenView: UIView!
    private (set) var seatsCollectionView: UICollectionView!
    private var noticeLabel: UILabel!
    private (set) var okButton: UIButton!
    private var verticalStackView: UIStackView!
    private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Инициализаторы
    init(seatsNumber: Int) {
        super.init(frame: .zero)
        self.setUpSeatsReservationRootView(seatsNumber: seatsNumber)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Компоновка UI
private extension SeatsReservationRootView {
    
    // MARK: Настройка объекта SeatsReservationRootView
    func setUpSeatsReservationRootView(seatsNumber: Int) -> Void {
        self.setUpScreenView()
        self.setUpSeatsCollectionView(seatsNumber: seatsNumber)
        self.setUpNoticeLabel()
        self.setUpOkButton()
        self.setUpVerticalStackView()
        self.setUpActivityIndicator()
        self.backgroundColor = AppColor.SeatsReservationScene.rootView.getColor()
        self.hideNotice()
        self.hideContent()
    }
    
    // MARK: Настройка screenView
    func setUpScreenView() -> Void {
        self.screenView = UIView()
        self.screenView.backgroundColor = AppColor.SeatsReservationScene.screen.getColor()
    }
    
    // MARK: Настройка seatsCollectionView
    func setUpSeatsCollectionView(seatsNumber: Int) -> Void {
        self.seatsCollectionView = SeatsCollectionView(frame: .zero, seatsNumber: seatsNumber)
        self.addConstraintsToSeatsCollectionView()
    }
    
    func addConstraintsToSeatsCollectionView() -> Void {
        if let seatsCollectionView = self.seatsCollectionView as? SeatsCollectionView {
            NSLayoutConstraint.activate([
                seatsCollectionView.heightAnchor.constraint(equalTo: self.seatsCollectionView.widthAnchor,
                                                            multiplier: seatsCollectionView.getCollectionViewHeightMultiplier(),
                                                            constant: seatsCollectionView.getCollectionViewHeightConstant())
            ])
        }
    }
    
    // MARK: Настройка noticeLabel
    func setUpNoticeLabel() -> Void {
        self.noticeLabel = UILabel()
        self.noticeLabel.textColor = AppColor.SeatsReservationScene.notice.getColor()
        self.noticeLabel.font = .systemFont(ofSize: 17, weight: .regular)
    }
    
    // MARK: Настройка okButton
    func setUpOkButton() -> Void {
        self.okButton = UIButton()
        self.okButton.setTitle("Подтвердить", for: .normal)
        self.okButton.setTitleColor(AppColor.SeatsReservationScene.okButtonNormalText.getColor(), for: .normal)
        self.okButton.setTitleColor(AppColor.SeatsReservationScene.okButtonHighlitedText.getColor(), for: .highlighted)
        self.okButton.backgroundColor = AppColor.SeatsReservationScene.okButton.getColor()
        self.okButton.layer.cornerRadius = 15
    }
    
    // MARK: Настройка verticalStackView
    func setUpVerticalStackView() -> Void {
        self.verticalStackView = UIStackView(arrangedSubviews: [self.screenView,
                                                                self.seatsCollectionView,
                                                                self.noticeLabel,
                                                                self.okButton])
        self.addSubview(self.verticalStackView)
        self.addCostraintsToVerticalStackView()
        self.verticalStackView.axis = .vertical
        self.verticalStackView.alignment = .center
        self.verticalStackView.setCustomSpacing(100, after: self.screenView)
        self.verticalStackView.isLayoutMarginsRelativeArrangement = true
        self.verticalStackView.layoutMargins = .init(top: 50, left: 0, bottom: 50, right: 0)
    }
    
    func addCostraintsToVerticalStackView() -> Void {
        self.verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.verticalStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.verticalStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.verticalStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.verticalStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            self.screenView.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor,
                                                   multiplier: 1,
                                                   constant: -50),
            self.screenView.heightAnchor.constraint(equalToConstant: 2.5),
            
            self.seatsCollectionView.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor),
            
            self.okButton.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor, multiplier: 1, constant: -50),
            self.okButton.heightAnchor.constraint(equalToConstant: self.okButton.intrinsicContentSize.height * 1.2)
        ])
    }
    
    // MARK: Настройка индикатора загрузки
    func setUpActivityIndicator() -> Void {
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        self.addSubview(self.activityIndicator)
        self.activityIndicator.color = .black
        self.activityIndicator.hidesWhenStopped = true
        self.addConstraintsToActivityIndicator()
        self.activityIndicator.startAnimating()
    }
    
    func addConstraintsToActivityIndicator() -> Void {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
}

// MARK: - Интерфейс объектов SeatsReservationRootView
extension SeatsReservationRootView {
    
    // MARK: Установка источника данных для seatsCollectionView
    func setCollectionViewDataSource(dataSource: UICollectionViewDataSource) -> Void {
        self.seatsCollectionView.dataSource = dataSource
    }
    
    // MARK: Установка делегата для seatsCollectionView
    func setCollectionViewDelegate(delegate: UICollectionViewDelegate) -> Void {
        self.seatsCollectionView.delegate = delegate
    }
    
    // MARK: Установка обработчика нажатия на кнопку okButton
    func addOkButtonAction(target: Any?, selector: Selector) -> Void {
        self.okButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    // MARK: Сокрытие контента
    func hideContent() -> Void {
        self.verticalStackView.isHidden = true
    }
    
    // MARK: Отображение контента
    func showContent() -> Void {
        if self.verticalStackView.isHidden {
            self.verticalStackView.isHidden = false
        }
    }
    
    // MARK: Остановка индикатора загрузки
    func stopActivityIndicator() -> Void {
        if self.activityIndicator.isAnimating {
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: Отображение уведомления
    func showNotice() -> Void {
        self.noticeLabel.text = "Для подтверждения выберите места"
    }
    
    // MARK: Сокрытие уведомления
    func hideNotice() -> Void {
        self.noticeLabel.text = ""
    }
    
}
