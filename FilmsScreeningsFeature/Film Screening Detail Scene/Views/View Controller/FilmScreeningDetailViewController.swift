//
//  FilmScreeningDetailViewController.swift
//  FilmsScreeningsFeature
//
//  Created by Kirill on 10.01.2024.
//

import UIKit
import CoreDomain
import DataManagerDomain
import Core_UI

// MARK:  - FilmScreeningDetailViewController
final class FilmScreeningDetailViewController: UIViewController {
    
    // MARK: Свойства объектов класса
    private let viewModel: FilmScreeningDetailViewModel
    
    // MARK: Инициализаторы
    init(viewModel: FilmScreeningDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Жизненный цикл
extension FilmScreeningDetailViewController {
    
    // MARK: loadView
    override func loadView() {
        super.loadView()
        
        let rootView = FilmScreeningDetailRootView(frame: .zero)
        rootView.configure(filmName: self.viewModel.filmScreening.film.name,
                           filmDescription: self.viewModel.filmScreening.film.description,
                           imagesNamesArray: self.viewModel.filmScreening.film.imagesNames,
                           filmScreeingDate: self.viewModel.filmScreening.getStringDate())
        rootView.addReserveButtonAction(target: self, selector: #selector(self.reserveButtonHasBeenPressed))
        self.view = rootView
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        if let filmScreeningDetailRootView = self.view as? FilmScreeningDetailRootView {
            filmScreeningDetailRootView.addImagesScrollViewDelegate(delegate: self)
        }
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpNavigationController()
    }
    
}

// MARK: Приватные методы
private extension FilmScreeningDetailViewController {
    
    // MARK: Настройка навигационного контроллера
    func setUpNavigationController() -> Void {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.setUpColors(backgroundColor: AppColor.FilmScreeningDetailScene.navigationBar.getColor(),
                                               textColor: AppColor.FilmScreeningDetailScene.navigationBarText.getColor())
    }
    
    // MARK: Обработчик нажатия на кнопку бронирования мест
    @objc func reserveButtonHasBeenPressed() -> Void {
        let seatsReservationViewModel =  SeatsReservationViewModel(filmScreeningId: self.viewModel.filmScreening.id)
        let seatsReservationVC = SeatsReservationViewController(viewModel: seatsReservationViewModel)
        self.navigationController?.pushViewController(seatsReservationVC, animated: true)
    }
    
}

// MARK: - FilmScreeningDetailViewController + UIScrollViewDelegate
extension FilmScreeningDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let filmScreeningDetailRootView = self.view as? FilmScreeningDetailRootView {
            filmScreeningDetailRootView.imagesScrollViewDidEndDeceleratingHandler()
        }
    }
}
