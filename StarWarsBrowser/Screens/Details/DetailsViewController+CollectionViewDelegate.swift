//
//  DetailsViewController+CollectionViewDelegate.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/27/21.
//

import Foundation
import UIKit

extension DetailsViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // if last cell load next page
        let numberOfItems = collectionView.numberOfItems(inSection: indexPath.section)
        if indexPath.row + 1 >= numberOfItems {
            loadNextPageData()
        }
    }
}
