import UIKit

final class RecipeListView: UIView {
    
    var collectionView = RecipeCollectionView()
    
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layoutUI() {
        addSubview(collectionView)
        collectionView.fillSuperview()
    }
}
