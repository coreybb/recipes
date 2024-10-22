import UIKit

final class RecipeCollectionViewLayout: UICollectionViewFlowLayout {
   
    private let minimumSpacing: CGFloat = 16
    private let sectionInsets = UIEdgeInsets(top: 8, left: 24, bottom: 24, right: 24)

    
    //  MARK: - Layout Lifeycle
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        configureLayout(for: collectionView.bounds.size)
    }


    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        configureLayout(for: newBounds.size)
        return true
    }

    
    //  MARK: - Internal API
    
    func configureLayout(for size: CGSize) {
        sectionInset = sectionInsets
        minimumInteritemSpacing = minimumSpacing
        minimumLineSpacing = 24

        let itemsPerRow: CGFloat = numberOfItemsPerRow()
        let availableWidth = size.width - sectionInsets.left - sectionInsets.right
        let itemWidth = (availableWidth - minimumSpacing * (itemsPerRow - 1)) / itemsPerRow
        let itemHeight = itemWidth * 1.3
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }

    
    //  MARK: - Private API
    
    private func numberOfItemsPerRow() -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return UIDevice.current.orientation.isPortrait ? 4 : 8
        case .phone:
            return 2
        default:
            return 2
        }
    }
}
