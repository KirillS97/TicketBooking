//
//  CongratulationViewController.swift
//  FilmsScreeningsFeature
//
//  Created by Kirill on 12.01.2024.
//

import UIKit

// MARK: - CongratulationViewController
final class CongratulationViewController: UIViewController {
    
    // MARK: Свойства объектов класса
    let viewModel: CongratulationViewModel
    private var disappearHandler: (() -> Void)?
    
    // MARK: Инициализаторы
    init(viewModel: CongratulationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Методы жизненного цикла
extension CongratulationViewController {
    
    // MARK: loadView
    override func loadView() {
        super.loadView()
        let congratulationRootView = CongratulationRootView()
        congratulationRootView.setCongratulationLabelText(filmName: self.viewModel.filmScreening.film.name,
                                                          stringDate: self.viewModel.filmScreening.getStringDate(),
                                                          seatsNumbers: self.viewModel.selectedSeatsNumbers)
        self.view = congratulationRootView
    }
    
    // MARK: viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        self.disappearHandler?()
    }
    
}

// MARK: - Интерфейс объектов CongratulationViewController
extension CongratulationViewController {
    
    // MARK: Назначение обработчика удаления объекта CongratulationViewController из иерархии
    func setDisappearHandler(handler: @escaping () -> Void) -> Void {
        self.disappearHandler = handler
    }
    
}
