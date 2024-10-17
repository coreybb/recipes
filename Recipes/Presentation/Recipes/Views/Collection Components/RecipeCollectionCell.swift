import UIKit
import Combine


final class RecipeCollectionCell: UICollectionViewCell {

    static let reuseID: String = "RECIPE_COLLECTION_VIEW_CELL"
    private let shadowView = ShadowView()
    private let recipeDetailView = RecipeDetailView()
    private var imageSubscription: AnyCancellable?
    private var viewModel: RecipeCellViewModel?

    
    //  MARK: - Cell Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancelImageLoading()
        resetUI()
    }
    
    
    //  MARK: - Internal API
    
    func configure(with viewModel: RecipeCellViewModel) {
        recipeDetailView.nameLabel.text = viewModel.name
        recipeDetailView.cuisineLabel.text = viewModel.cuisine.rawValue
        subscribeToImageUpdates(viewModel)
        viewModel.loadImageIfNeeded()
    }
    
    
    func cancelImageLoading() {
        viewModel?.cancelImageLoad()
        imageSubscription?.cancel()
        imageSubscription = nil
    }
    
    
    
    //  MARK: - Private API
    
    private func subscribeToImageUpdates(_ viewModel: RecipeCellViewModel) {
        imageSubscription = viewModel.$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.recipeDetailView.imageView.image = image ?? UIImage(systemName: "photo")!
                    .withRenderingMode(.alwaysOriginal)
                    .withTintColor(.gray)
            }
    }
    
    
    private func resetUI() {
        recipeDetailView.nameLabel.text = nil
        recipeDetailView.cuisineLabel.text = nil
        recipeDetailView.imageView.image = UIImage(systemName: "photo")!
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.gray)
    }
    

    private func layoutUI() {
        layoutShadowView()
        layoutRecipeDetailView()
    }
    
    
    private func layoutShadowView() {
        contentView.addSubview(shadowView)
        shadowView.fillSuperview()
    }
    
    
    private func layoutRecipeDetailView() {
        shadowView.addSubview(recipeDetailView)
        recipeDetailView.fillSuperview()
    }
    
    
    
    //  MARK: - Deinitialization
    deinit {
        imageSubscription = nil
    }
}



fileprivate final class ShadowView: UIView, ShadowCasting {
    
    var didLayoutSubviews = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if didLayoutSubviews { return }
        addDropShadow()
        didLayoutSubviews = true
    }
}
