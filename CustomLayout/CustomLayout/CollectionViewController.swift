//
//  CollectionViewController.swift
//  CustomLayout
//
//  Created by Darya Drobyshevsky on 5/7/21.
//

import UIKit

private let reuseIdentifier = "CollectionCell"

struct StructImage {
  let image: UIImage
}

var arrayImages = [StructImage]()

class CollectionViewController: UICollectionViewController{

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let i1 = UIImage(named: "i1")!
        let i2 = UIImage(named: "i2")!
        let i3 = UIImage(named: "i3")!
        let i4 = UIImage(named: "i4")!
       
        arrayImages.append(StructImage(image: i1))
        arrayImages.append(StructImage(image: i2))
        arrayImages.append(StructImage(image: i3))
        arrayImages.append(StructImage(image: i4))
        arrayImages.append(StructImage(image: i1))
        arrayImages.append(StructImage(image: i2))
        arrayImages.append(StructImage(image: i3))
        arrayImages.append(StructImage(image: i4))
        arrayImages.append(StructImage(image: i1))
        arrayImages.append(StructImage(image: i2))
        arrayImages.append(StructImage(image: i3))
        arrayImages.append(StructImage(image: i4))
        arrayImages.append(StructImage(image: i1))
        
        if let layout = collectionView?.collectionViewLayout as?CustomLayout {
            layout.delegateLayout = self
     }
      
    }



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionCell
        cell.image.image = arrayImages[indexPath.row].image
    
       
    
        return cell
    }

}
extension CollectionViewController: CustomLayoutDelegate{
    func collectionView(_collectionView collectionView: UICollectionView, heightForImageAtIndexPath indexPath:IndexPath) -> CGSize {
       return arrayImages[indexPath.item].image.size
     }
}
