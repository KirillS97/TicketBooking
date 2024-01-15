//
//  SeatsReservationViewController.swift
//  FilmsScreeningsFeature
//
//  Created by Kirill on 11.01.2024.
//

import UIKit
import CoreDomain
import Core_UI

// MARK: - SeatsReservationViewController
class SeatsReservationViewController: UIViewController {
    
    // MARK: Свойства объектов класса
    let viewModel: SeatsReservationViewModel
    
    // MARK: Инициализаторы
    init(viewModel: SeatsReservationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Методы жизненного цикла
extension SeatsReservationViewController {
    
    // MARK: loadView
    override func loadView() {
        super.loadView()
        self.view = SeatsReservationRootView(seatsNumber: 10)
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        if let seatsReservationRootView = self.view as? SeatsReservationRootView {
            seatsReservationRootView.setCollectionViewDataSource(dataSource: self)
            seatsReservationRootView.setCollectionViewDelegate(delegate: self)
            seatsReservationRootView.addOkButtonAction(target: self, selector: #selector(self.OkButtonHasBeenPressed))
        }
        self.bindWithViewModel()
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpNavigationController()
    }
    
}

// MARK: - Приватные методы
private extension SeatsReservationViewController {
    
    // MARK: Настройка навигационного контроллера
    func setUpNavigationController() -> Void {
        self.navigationItem.title = "Выбор мест"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.setUpColors(backgroundColor: .systemGray6,
                                               textColor: .black)
    }
    
    // MARK: Биндинг
    func bindWithViewModel() -> Void {
        let seatsReservationRootView = self.view as? SeatsReservationRootView
        
        self.viewModel.bindWithObservableFilmScreening { [weak seatsReservationRootView] (_) in
            if let seatsReservationRootView {
                seatsReservationRootView.seatsCollectionView.reloadData()
                seatsReservationRootView.stopActivityIndicator()
                seatsReservationRootView.showContent()
            }
        }
        
    }
    
    // MARK: Выбор ячейки
    func selectCell(indexPath: IndexPath) -> Void {
        guard let seatsReservationRootView = self.view as? SeatsReservationRootView else {
            return
        }
        let seatNumber = indexPath.item + 1
        if self.viewModel.selectSeat(number: seatNumber) {
            guard let cell = seatsReservationRootView.seatsCollectionView.cellForItem(at: indexPath) as? SeatsCollectionViewCell else {
                return
            }
            if self.viewModel.selectedSeatsNumbers.contains(seatNumber) {
                cell.setState(state: .selected)
            } else {
                cell.setState(state: .free)
            }
        }
    }
    
    // MARK: Обработчик нажатия на кнопку
    @objc func OkButtonHasBeenPressed() -> Void {
        guard let seatsReservationRootView = self.view as? SeatsReservationRootView else {
            return
        }
        if self.viewModel.reserveSeats() {
            seatsReservationRootView.hideNotice()
            guard let filmScreening = self.viewModel.filmScreening else {
                return
            }
            let congratulationViewModel = CongratulationViewModel(filmScreening: filmScreening,
                                                                  selectedSeatsNumbers: self.viewModel.selectedSeatsNumbers)
            let congratulationVC = CongratulationViewController(viewModel: congratulationViewModel)
            congratulationVC.modalPresentationStyle = .pageSheet
            congratulationVC.setDisappearHandler { [weak self] () -> Void in
                if let self {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            self.present(congratulationVC, animated: true)
        } else {
            seatsReservationRootView.showNotice()
        }
    }
    
}

// MARK: - SeatsReservationViewController + UICollectionViewDataSource
extension SeatsReservationViewController: UICollectionViewDataSource {
    
    // MARK: numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let seatsDictionary = self.viewModel.filmScreening?.seating.reservedSeats {
            return seatsDictionary.count
        }  else {
            return 0
        }
    }
    
    // MARK: cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let seatsReservationRootView = self.view as? SeatsReservationRootView {
            if let seatsCollectionViewCell = seatsReservationRootView.seatsCollectionView.dequeueReusableCell(withReuseIdentifier: SeatsCollectionViewCell.reuseId, for: indexPath) as? SeatsCollectionViewCell {
                if let seatsDictionary = self.viewModel.filmScreening?.seating.reservedSeats {
                    let seatNumber = indexPath.item + 1
                    if let isReserved = seatsDictionary[seatNumber] {
                        if isReserved {
                            seatsCollectionViewCell.setState(state: .reserved)
                        } else {
                            seatsCollectionViewCell.setState(state: .free)
                        }
                        seatsCollectionViewCell.setSeatNumber(number: seatNumber)
                        return seatsCollectionViewCell
                    }
                }
            }
        }
        return SeatsCollectionViewCell(frame: .zero)
    }
    
}

// MARK: - SeatsReservationViewController + UICollectionViewDelegate
extension SeatsReservationViewController: UICollectionViewDelegate {
    
    // MARK: didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectCell(indexPath: indexPath)
    }
    
}

// MARK: - SeatsReservationViewController + UICollectionViewDelegateFlowLayout
extension SeatsReservationViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: sizeForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let seatsReservationView = self.view as? SeatsReservationRootView {
            if let seatsCollectionView = seatsReservationView.seatsCollectionView as? SeatsCollectionView {
                return seatsCollectionView.getCellSize()
            }
        }
        return CGSize(width: 0, height: 0)
    }
    
}
