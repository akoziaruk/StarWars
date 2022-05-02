//
//  StarsInfiniteView.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 28.04.2022.
//

import UIKit

class StarsInfiniteView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    private let diameterRange: ClosedRange<CGFloat>
    private let starsCount: Int
    private var views: [UIView]!
    private var offset: CGFloat = 0 {
        didSet {
            contentOffset = CGPoint(x: offset, y: 0.0)
        }
    }
    
    init(diameterRange: ClosedRange<CGFloat>, starsCount: Int) {
        self.diameterRange = diameterRange
        self.starsCount = starsCount

        super.init(frame: CGRect(), collectionViewLayout: StarsInfiniteViewFlowLayout())

        backgroundColor = .clear
        dataSource = self
        delegate = self
        
        register(StarsInfiniteViewCell.self, forCellWithReuseIdentifier: StarsInfiniteViewCell.Constants.identifier)
        
        views = [StarsView(diameterRange: diameterRange, starsCount: starsCount),
                 StarsView(diameterRange: diameterRange, starsCount: starsCount),
                 StarsView(diameterRange: diameterRange, starsCount: starsCount)]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if offset == 0.0 {
            offset = bounds.size.width
        }
    }
    
    public func move(by x: CGFloat) {
        offset += x
    }
    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        views.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: StarsInfiniteViewCell.Constants.identifier,
                                            for: indexPath) as! StarsInfiniteViewCell
        cell.set(view: views[indexPath.item])
        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return bounds.size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cellWidth = bounds.size.width
        if (offset > cellWidth*2) {
            offset = cellWidth
            views.swapAt(1, 2)
            reloadData()
        } else if (offset < 0) {
            offset = cellWidth
            views.swapAt(0, 1)
            reloadData()
        }
    }
}
