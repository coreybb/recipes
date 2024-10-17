import UIKit

final class RecipeCollectionView: UICollectionView {
    
    init() {
        super.init(
            frame: .zero,
            collectionViewLayout: RecipeCollectionViewLayout()
        )
        
        register(
            RecipeCollectionCell.self,
            forCellWithReuseIdentifier: RecipeCollectionCell.reuseID
        )
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
