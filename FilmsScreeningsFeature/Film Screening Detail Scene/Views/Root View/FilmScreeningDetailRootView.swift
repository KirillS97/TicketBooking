//
//  FilmScreeningDetailRootView.swift
//  FilmsScreeningsFeature
//
//  Created by Kirill on 10.01.2024.
//

import UIKit
import CoreDomain

// MARK: - FilmScreeningDetailRootView
final class FilmScreeningDetailRootView: UIView {
    
    // MARK: Свойства объектов класса
    private var scrollView: UIScrollView!
    private var titleLabel: UILabel!
    private var imagesScrollView: UIScrollView!
    private var descriptionLabel: UILabel!
    private var dateLabel: UILabel!
    private var reserveButton: UIButton!
    private var verticalStackView: UIStackView!
    
    private weak var timer: Timer?
    
    // MARK: Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpFilmScreeningDetailRootView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Деинициализатор
    deinit {
        timer?.invalidate()
    }
    
}

// MARK: - Компоновка UI
private extension FilmScreeningDetailRootView {
    
    // MARK: Настройка объекта FilmScreeningDetailRootView
    func setUpFilmScreeningDetailRootView() -> Void{
        self.backgroundColor = AppColor.FilmScreeningDetailScene.rootView.getColor()
        self.setUpScrollView()
        self.setUpTitleLabel()
        self.setUpImagesScrollView()
        self.setUpDescriptionLabel()
        self.setUpDateLabel()
        self.setUpReserveButton()
        self.setUpVerticalStackView()
    }
    
    // MARK: Настройка scrollView
    func setUpScrollView() -> Void {
        self.scrollView = UIScrollView()
        self.addSubview(self.scrollView)
        self.addConstraintsToScrollView()
        self.scrollView.backgroundColor = AppColor.FilmScreeningDetailScene.scrollView.getColor()
    }
    
    func addConstraintsToScrollView() -> Void {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // MARK: Настройка titleLabel
    func setUpTitleLabel() -> Void {
        self.titleLabel = UILabel()
        self.titleLabel.numberOfLines = 0
        self.titleLabel.textColor = AppColor.FilmScreeningDetailScene.title.getColor()
        self.titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
    }
    
    // MARK: Настройка imagesScrollView
    func setUpImagesScrollView() -> Void {
        self.imagesScrollView = UIScrollView()
        self.imagesScrollView.backgroundColor = AppColor.FilmScreeningDetailScene.imageView.getColor()
        self.imagesScrollView.isPagingEnabled = true
    }
    
    // MARK: Настройка descriptionLabel
    func setUpDescriptionLabel() -> Void {
        self.descriptionLabel = UILabel()
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textColor = AppColor.FilmScreeningDetailScene.descriptionText.getColor()
        self.descriptionLabel.font = .systemFont(ofSize: 18, weight: .regular)
    }
    
    // MARK: Настройка dateLabel
    func setUpDateLabel() -> Void {
        self.dateLabel = UILabel()
        self.dateLabel.numberOfLines = 1
        self.dateLabel.textColor = AppColor.FilmScreeningDetailScene.dateText.getColor()
        self.dateLabel.font = .systemFont(ofSize: 20, weight: .medium)
    }
    
    // MARK: Настройка reserveButton
    func setUpReserveButton() -> Void {
        self.reserveButton = UIButton()
        self.reserveButton.setTitle("Выбрать места", for: .normal)
        self.reserveButton.setTitleColor(AppColor.FilmScreeningDetailScene.buttonTitleNormalText.getColor(), for: .normal)
        self.reserveButton.setTitleColor(AppColor.FilmScreeningDetailScene.buttonTitleHighlitedText.getColor(), for: .highlighted)
        self.reserveButton.backgroundColor = AppColor.FilmScreeningDetailScene.button.getColor()
        self.reserveButton.layer.cornerRadius = 15
    }
    
    // MARK: Настройка verticalStackView
    func setUpVerticalStackView() -> Void {
        self.verticalStackView = UIStackView(arrangedSubviews: [self.titleLabel,
                                                                self.imagesScrollView,
                                                                self.descriptionLabel,
                                                                self.dateLabel,
                                                                self.reserveButton])
        self.verticalStackView.axis = .vertical
        self.verticalStackView.alignment = .center
        self.verticalStackView.spacing = 20
        self.scrollView.addSubview(self.verticalStackView)
        self.addConstraintsToVerticalStackView()
    }
    
    func addConstraintsToVerticalStackView() -> Void {
        self.verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.verticalStackView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            self.verticalStackView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            self.verticalStackView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor, constant: -30),
            self.verticalStackView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor),
            
            self.verticalStackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            self.titleLabel.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor, constant: -30),
            
            self.imagesScrollView.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor),
            self.imagesScrollView.heightAnchor.constraint(equalTo: self.imagesScrollView.widthAnchor, multiplier: 9/16),
            
            self.descriptionLabel.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor, constant: -30),
            
            self.reserveButton.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor, multiplier: 1, constant: -50),
            self.reserveButton.heightAnchor.constraint(equalToConstant: self.reserveButton.intrinsicContentSize.height * 1.2)
        ])
    }
    
}

// MARK: заполнение контеном объектов FilmScreeningDetailRootView
private extension FilmScreeningDetailRootView {
    
    // MARK: Установка текста для titleLabel
    func setTitleText(text: String) -> Void {
        self.titleLabel.text = text
    }
    
    // MARK: Установка текста для descriptionLabel
    func setDescriptionText(text: String) -> Void {
        self.descriptionLabel.text = text
    }
    
    // MARK: Добавление объектов UIImageView к imagesScrollView
    func setImagesArrayToImagesScrollView(imagesNamesArray: [String]) -> Void {
        
        var imageViewsArray: [UIImageView] = []
        
        for imageName in imagesNamesArray {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: imageName)
            imageView.backgroundColor = AppColor.FilmScreeningDetailScene.imageView.getColor()
            imageViewsArray.append(imageView)
        }
        
        for i in 0..<imageViewsArray.count {
            let imageView = imageViewsArray[i]
            self.imagesScrollView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalTo: self.imagesScrollView.heightAnchor),
                imageView.widthAnchor.constraint(equalTo: self.imagesScrollView.widthAnchor),
                imageView.topAnchor.constraint(equalTo: self.imagesScrollView.contentLayoutGuide.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: self.imagesScrollView.contentLayoutGuide.bottomAnchor)
            ])
            if i == 0 {
                NSLayoutConstraint.activate([
                    imageView.leadingAnchor.constraint(equalTo: self.imagesScrollView.contentLayoutGuide.leadingAnchor)
                ])
            } else {
                NSLayoutConstraint.activate([
                    imageView.leadingAnchor.constraint(equalTo: imageViewsArray[i - 1].trailingAnchor)
                ])
            }
            if i == imageViewsArray.count - 1 {
                NSLayoutConstraint.activate([
                    imageView.trailingAnchor.constraint(equalTo: self.imagesScrollView.contentLayoutGuide.trailingAnchor)
                ])
            }
        }
        
    }
    
    // MARK: Установка текста для dateLabel
    func setDateText(filmScreeingDate: String) -> Void {
        self.dateLabel.text = filmScreeingDate
    }
    
}

// MARK: - Настройка таймера timer
private extension FilmScreeningDetailRootView {
    
    // MARK: Инициализация таймера
    func setUpTimer() -> Void {
        self.timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { [weak self] _ in
            self?.nextImage()
        })
    }
    
    // MARK: Смена изображения в imagesScrollView
    func nextImage() -> Void  {
        let currentXOffset = self.imagesScrollView.contentOffset.x
        let xOffsetLimit = self.imagesScrollView.contentSize.width - self.imagesScrollView.frame.size.width
        
        if self.imagesScrollView.contentOffset.x >= xOffsetLimit {
            UIView.animate(withDuration: 1.0) {
                self.imagesScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
        } else {
            UIView.animate(withDuration: 1.0) {
                self.imagesScrollView.setContentOffset(CGPoint(x: currentXOffset + self.imagesScrollView.frame.width,
                                                               y: 0),
                                                       animated: false)
            }
        }
        
    }
    
}

// MARK: Интерфейс объектов FilmScreeningDetailRootView
extension FilmScreeningDetailRootView {
    
    // MARK: Конфигурирование объекта FilmScreeningDetailRootView
    func configure(filmName: String,
                   filmDescription: String,
                   imagesNamesArray: [String],
                   filmScreeingDate: String) -> Void {
        self.setTitleText(text: filmName)
        self.setDescriptionText(text: filmDescription)
        self.setImagesArrayToImagesScrollView(imagesNamesArray: imagesNamesArray)
        self.setDateText(filmScreeingDate: filmScreeingDate)
        
        self.setUpTimer()
    }
    
    // MARK: Добавление обработчика нажатия на кнопку reserveButton
    func addReserveButtonAction(target: Any?, selector: Selector) -> Void {
        self.reserveButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    // MARK: Обработчик остановки скролла imagesScrollView
    func imagesScrollViewDidEndDeceleratingHandler() -> Void {
        self.timer?.invalidate()
        self.setUpTimer()
    }
    
    // MARK: Установка делегата для imagesScrollView
    func addImagesScrollViewDelegate(delegate: UIScrollViewDelegate) -> Void {
        self.imagesScrollView.delegate = delegate
    }
    
}
