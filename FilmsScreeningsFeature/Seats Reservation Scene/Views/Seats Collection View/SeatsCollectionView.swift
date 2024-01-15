//
//  SeatsCollectionView.swift
//  FilmsScreeningsFeature
//
//  Created by Kirill on 11.01.2024.
//

import UIKit
import CoreDomain

// MARK: - SeatsCollectionView
final class SeatsCollectionView: UICollectionView {
    
    // MARK: Свойства объектов класса
    private let flowLayout = UICollectionViewFlowLayout()
    
    private let lineSpacing       = CGFloat(30)
    private let interItemSpacing  = CGFloat(0)
    private let horizontalIndent  = CGFloat(20)
    private let verticalIndent    = CGFloat(20)
    
    private let differenceBetweenCellHeightAndWidth: CGFloat = 0
    
    private let numberOfColumnsForCells = 5
    private let numberOfRowsForCells: Int
    
    // MARK: Инициализаторы
    init(frame: CGRect, seatsNumber: Int) {
        self.numberOfRowsForCells = Int(ceil(Double(seatsNumber) / Double(self.numberOfColumnsForCells)))
        super.init(frame: frame, collectionViewLayout: self.flowLayout)
        self.setUpSeatsCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// MARK: - Конфигурирование SeatsCollectionView
extension SeatsCollectionView {
    
    // MARK: Настройка коллекции
    private func setUpSeatsCollectionView() -> Void {
        self.setUpFlowLayout()
        self.register(SeatsCollectionViewCell.self, forCellWithReuseIdentifier: SeatsCollectionViewCell.reuseId)
        self.isScrollEnabled = false
        self.showsVerticalScrollIndicator = false
        self.setUpBackgroundColor()
    }
    
    // MARK: Установка цвета фона
    private func setUpBackgroundColor() -> Void {
        self.backgroundColor = AppColor.SeatsReservationScene.collectionView.getColor()
    }
    
    // MARK: Настройка UICollectionViewFlowLayout
    private func setUpFlowLayout() -> Void {
        self.flowLayout.scrollDirection = .vertical
        self.flowLayout.minimumLineSpacing = self.lineSpacing
        self.flowLayout.minimumInteritemSpacing = self.interItemSpacing
        self.flowLayout.sectionInset = .init(top:    self.verticalIndent,
                                             left:   self.horizontalIndent,
                                             bottom: self.verticalIndent,
                                             right:  self.horizontalIndent)
    }
    
}



// MARK: - Публичные методы
extension SeatsCollectionView {
    
    // MARK: getCellSize
    // Используется в SeatsReservationViewController для получения такого размера ячейки, который бы позволил разделить коллекцию на numberOfColumnsForCells столбцов, расстояние между которыми бы точно соответствовало размеру interItemSpacing при отступах от левой и правой границ коллекции до ближайших столбцов, равных horizontalIndent. Округление ширины ячейки до 3 знака используется т.к. не всегда рассчетная ширина получается точной. Таким образом, данный метод позволяет сделать размер ячейки адаптивным в зависимости от размеров экрана.
    func getCellSize() -> CGSize {
        let firstTerm  = self.frame.width / CGFloat(self.numberOfColumnsForCells)
        let secondTerm = -1 * self.interItemSpacing
        let thirdTerm  = self.interItemSpacing / CGFloat(self.numberOfColumnsForCells)
        let fourthTerm = (-2 * self.horizontalIndent) / CGFloat(self.numberOfColumnsForCells)
        
        let cellWidth  = firstTerm + secondTerm + thirdTerm + fourthTerm
        
        let cellRoundedWidth = (cellWidth * 1000).rounded(.down) / 1000
        let cellHeight = cellRoundedWidth + self.differenceBetweenCellHeightAndWidth
        
        return CGSize(width: cellRoundedWidth, height: cellHeight)
    }
    
    // MARK: getCollectionViewHeightMultiplier
    // Используется в SeatsReservationRootView в качестве множителя для высоты коллекции относительно её ширины при указании ограничений для этой коллекции. Данный метод с методом getCollectionViewHeightConstant позволяют сделать высоту фрейма коллекции адаптивной и подстраиваться под высоту ячеек и количество строк в коллекции.
    func getCollectionViewHeightMultiplier() -> CGFloat {
        CGFloat(self.numberOfRowsForCells) / CGFloat(self.numberOfColumnsForCells)
    }
    
    // MARK: getCollectionViewHeightConstant
    // Используется в SeatsReservationRootView в качестве константы для высоты коллекции относительно её ширины при указании ограничений для этой коллекции. Данный метод с методом getCollectionViewHeightMultiplier позволяют сделать высоту фрейма коллекции адаптивной и подстраиваться под высоту ячеек и количество строк в коллекции.
    func getCollectionViewHeightConstant() -> CGFloat {
        let firstTerm  = CGFloat(-self.numberOfRowsForCells) * self.interItemSpacing
        let secondTerm = (CGFloat(self.numberOfRowsForCells) * self.interItemSpacing) / CGFloat(self.numberOfColumnsForCells)
        let thirdTerm  = (-2 * self.horizontalIndent * CGFloat(self.numberOfRowsForCells)) / CGFloat(self.numberOfColumnsForCells)
        let fourthTerm = CGFloat(self.numberOfRowsForCells) * self.differenceBetweenCellHeightAndWidth
        let fifthTerm  = CGFloat(self.numberOfRowsForCells - 1) * self.lineSpacing
        let sixthTerm  = 2 * self.verticalIndent
        
        let constant   = firstTerm + secondTerm + thirdTerm + fourthTerm + fifthTerm + sixthTerm
        
        return constant
    }
    
}
