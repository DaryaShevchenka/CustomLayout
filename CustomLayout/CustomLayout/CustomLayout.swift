//
//  CustomLayout.swift
//  CustomLayout
//
//  Created by Darya Drobyshevsky on 5/7/21.
//
import Foundation

import UIKit

protocol CustomLayoutDelegate: AnyObject {
    func collectionView(_collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGSize
}

class CustomLayout: UICollectionViewFlowLayout {
 
    weak var delegateLayout: CustomLayoutDelegate?

    private let numberOfColums = 3 // кол-во колонок
    
    private let cellPadding: CGFloat = 5 // расстояние между картинками
    
    private var cache: [UICollectionViewLayoutAttributes] = [] // хранище макетов,где хранятся данные объектов  и размеры
    
    private var contentHeight: CGFloat = 0 // высота
    
    private var contentWidth: CGFloat {
    guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.width // если есть CollectionView, то возвращается ширина  по bounds,в противном случае возр 0
}
  
    override  var collectionViewContentSize: CGSize{
        return CGSize(width:contentWidth, height: contentHeight) // переменная,кот возвращает размер самого контента
    }
    // расстановка контента по ячейкам
    override func prepare(){
        // проверяем хранилище на пустоту
        guard cache.isEmpty, let collectionView = collectionView else {return}
        // если cache = nil,то метод не будет отрабатывать, так же как и collectionView
        
         let columnWitht = contentWidth / CGFloat(numberOfColums)
        //устанавливаем ширину колонки под изображение
        var xOffset: [CGFloat] = [] // создаем контейнер ,который отвечает за распол ячейки по оси х
        
        for column in 0..<numberOfColums { // цикл,в кот перебираем колонки наши и апендим в xOffset
            xOffset.append(CGFloat(column) * columnWitht)
            
        }
        var column = 0
        var offset: [CGFloat] = .init(repeating: 0, count: numberOfColums)
        
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColums)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: item,section: 0 )
            let imageSize = delegateLayout?.collectionView(_collectionView: collectionView, heightForImageAtIndexPath: indexPath)
            
            let cellWidth = columnWitht
            
            var cellHeight = imageSize!.height * cellWidth/imageSize!.width
            cellHeight = cellPadding * 2 + cellHeight
            
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: cellWidth, height: cellHeight)
            // создали frame
            let insentFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            // инсетим отступы
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)// передаем все данные,которые мы только что получили
            attributes.frame = insentFrame
            
            cache.append(attributes)// помещаем данные в cache
            contentHeight = max(contentHeight, frame.maxY) // чтобы заработал скроллинг
            
            yOffset[column] = yOffset[column] + cellHeight // выравниваем все изображения
            column = column < (numberOfColums - 1) ? (column + 1) : 0 //распределяем контент по колонкам
        }
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache{
            if attributes.frame.intersects(rect){
                visibleLayoutAttributes.append(attributes)
            }
    }
        return visibleLayoutAttributes
}
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
