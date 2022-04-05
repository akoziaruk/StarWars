//
//  PagingCollectionViewLayout.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/18/21.
//

import Foundation
import UIKit

class PagingCollectionViewLayout: UICollectionViewFlowLayout {
    
    let visiblePeekingPageInset = 12.0
    let mainPageMargin = 15.0
    let verticalMargin = 50.0
    let velocityThresholdPerPage = 5.0

    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
                    
        let cellWidth = collectionView.bounds.size.width - (mainPageMargin + visiblePeekingPageInset)*2
        let cellHeight = collectionView.bounds.height - verticalMargin
        let inset = minimumInteritemSpacing + visiblePeekingPageInset
        
        itemSize = CGSize(width: cellWidth, height: cellHeight)
        sectionInset = UIEdgeInsets(top: 0.0, left: inset, bottom: 0.0, right: inset)
        
        sectionInsetReference = .fromSafeArea
    }
        
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        
        let pageLength = itemSize.width + minimumLineSpacing
        let approxPage =  collectionView.contentOffset.x / pageLength
        let speed = velocity.x
        let currentPage: CGFloat
        
        if speed < 0 {
            currentPage = ceil(approxPage)
        } else if speed > 0 {
            currentPage = floor(approxPage)
        } else {
            currentPage = round(approxPage)
        }
        
        guard speed != 0 else {
            return CGPoint(x: currentPage * pageLength, y: 0)
        }
        
        var nextPage = currentPage + (speed > 0 ? 1 : -1)
        let increment = speed / velocityThresholdPerPage
        nextPage += (speed < 0) ? ceil(increment) : floor(increment)
        
        return CGPoint(x: nextPage * pageLength, y: 0)
    }
}
