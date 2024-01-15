//
//  FilmsScreeningsListSceneRootView.swift
//  TicketBooking
//
//  Created by Kirill on 07.01.2024.
//

import UIKit

// MARK: - FilmsScreeningsListSceneRootView
final class FilmsScreeningsListSceneRootView: UIView {
    
    // MARK: Свойства объектов класса
    private (set) var tableView: UITableView!
    private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpFilmsScreeningsListSceneRootView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
}

// MARK: - Компоновка UI
private extension FilmsScreeningsListSceneRootView {
    
    // MARK: Настройка объекта FilmsScreeningsListSceneRootView
    func setUpFilmsScreeningsListSceneRootView() -> Void {
        self.setUpTableView()
        self.setUpActivityIndicator()
        self.hideContent()
    }
    
    // MARK: Настройка tableView
    func setUpTableView() -> Void {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        self.addSubview(self.tableView)
        self.addConstraintsToTableView()
        self.tableView.register(FilmScreeningTableViewCell.self, forCellReuseIdentifier: FilmScreeningTableViewCell.reuseId)
        self.tableView.estimatedRowHeight = 300
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .black
    }
    
    func addConstraintsToTableView() -> Void {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // MARK: Настройка индикатора загрузки
    func setUpActivityIndicator() -> Void {
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        self.addSubview(self.activityIndicator)
        self.activityIndicator.color = .white
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

private extension FilmsScreeningsListSceneRootView {
    
}

// MARK: Интерфейс объекта FilmsScreeningsListSceneRootView
extension FilmsScreeningsListSceneRootView {
    
    // MARK: Назначение источника данных для таблицы tableView
    func addTableViewDataSource(dataSource: UITableViewDataSource) -> Void {
        self.tableView.dataSource = dataSource
    }
    
    // MARK: Назначение делегата для таблицы tableView
    func addTableViewDelegate(delegate: UITableViewDelegate) -> Void {
        self.tableView.delegate = delegate
    }
    
    // MARK: Сокрытие контента
    func hideContent() -> Void {
        self.tableView.isHidden = true
    }
    
    // MARK: Отображение контента
    func showContent() -> Void {
        if self.tableView.isHidden {
            self.tableView.isHidden = false
        }
    }
    
    // MARK: Остановка индикатора загрузки
    func stopActivityIndicator() -> Void {
        if self.activityIndicator.isAnimating {
            self.activityIndicator.stopAnimating()
        }
    }
    
}
