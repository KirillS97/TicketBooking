//
//  ViewController.swift
//  TicketBooking
//
//  Created by Kirill on 05.01.2024.
//

import UIKit
import CoreDomain
import Core_UI

// MARK: - FilmsScreeningsListViewController
final class FilmsScreeningsListViewController: UIViewController {
    
    // MARK: Свойства объектов класса
    private var viewModel = FilmsScreeningsListViewModel()
    
}

// MARK: - Методы жизненного цикла
extension FilmsScreeningsListViewController {
    
    // MARK: loadView
    override func loadView() {
        super.loadView()
        self.view = FilmsScreeningsListSceneRootView()
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindWithViewModel()
        
        if let filmsScreeningsListSceneRootView = self.view as? FilmsScreeningsListSceneRootView {
            filmsScreeningsListSceneRootView.addTableViewDataSource(dataSource: self)
            filmsScreeningsListSceneRootView.addTableViewDelegate(delegate: self)
        }
        
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpNavigationController()
    }
    
}

// MARK: - Приватные методы объектов FilmsScreeningsListViewController
private extension FilmsScreeningsListViewController {
    
    // MARK: Настройка навигационного контроллера
    func setUpNavigationController() -> Void {
        self.navigationItem.title = "Киносеансы"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.setUpColors(backgroundColor: AppColor.FilmScreeningsListScene.navigationBar.getColor(),
                                               textColor: AppColor.FilmScreeningsListScene.navigationBarText.getColor())
    }
    
    // MARK: Биндинг
    func bindWithViewModel() -> Void {
        let filmsScreeningsListSceneRootView = self.view as? FilmsScreeningsListSceneRootView
        self.viewModel.bindWithObservableFilmsScreeningsList { [weak filmsScreeningsListSceneRootView] (filmScreeningsArray: [FilmScreening]) in
            if let filmsScreeningsListSceneRootView {
                filmsScreeningsListSceneRootView.tableView.reloadData()
                filmsScreeningsListSceneRootView.showContent()
                filmsScreeningsListSceneRootView.stopActivityIndicator()
            }
        }
    }
    
    func goToFilmScreeningDetailViewController(indexPath: IndexPath) -> Void {
        guard self.viewModel.filmsScreeningsList.indices.contains(indexPath.row) else {
            return
        }
        let filmScreening = self.viewModel.filmsScreeningsList[indexPath.row]
        let filmScreeningDetailViewModel = FilmScreeningDetailViewModel.init(filmScreening: filmScreening)
        let filmScreeningDetailVC = FilmScreeningDetailViewController(viewModel: filmScreeningDetailViewModel)
        
        self.navigationController?.pushViewController(filmScreeningDetailVC, animated: true)
    }
    
}

// MARK: - FilmsScreeningsListViewController + UITableViewDataSource
extension FilmsScreeningsListViewController: UITableViewDataSource {
    
    // MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.filmsScreeningsList.count
    }
    
    // MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel.filmsScreeningsList.indices.contains(indexPath.row) {
            let filmScreening = self.viewModel.filmsScreeningsList[indexPath.row]
            if let filmsScreeningsListSceneRootView = self.view as? FilmsScreeningsListSceneRootView {
                if let cell = filmsScreeningsListSceneRootView.tableView.dequeueReusableCell(withIdentifier: FilmScreeningTableViewCell.reuseId) as? FilmScreeningTableViewCell {
                    cell.setNameLabelText(text: filmScreening.film.name)
                    cell.setImage(image: UIImage(named: filmScreening.film.imagesNames.first!) ?? UIImage())
                    cell.setDate(stringDate: filmScreening.getStringDate())
                    return cell
                } else {
                    let cell = FilmScreeningTableViewCell(style: .default,
                                                          reuseIdentifier: FilmScreeningTableViewCell.reuseId)
                    cell.setNameLabelText(text: filmScreening.film.name)
                    cell.setImage(image: UIImage(named: filmScreening.film.imagesNames.first!) ?? UIImage())
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
}

// MARK: - FilmsScreeningsListViewController + UITableViewDelegate
extension FilmsScreeningsListViewController: UITableViewDelegate {
    
    // MARK: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.goToFilmScreeningDetailViewController(indexPath: indexPath)
    }
    
}
