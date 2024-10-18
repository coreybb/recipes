import UIKit

final class RecipeListView: UIView {
    
    //  MARK: - Internal Properties
    
    var collectionView = RecipeCollectionView()
    
    
    //  MARK: - Private Properties
    
    private lazy var optionsButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            UIImage(systemName: "slider.horizontal.3")!
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.white),
            for: .normal
        )
        button.imageView?.contentMode = .scaleToFill
        button.backgroundColor = .black
        let action: UIAction = UIAction {
            [weak self] _ in
            guard !(self?.collectionView.visibleCells.count == 0) else { return }
            print("Show modal.")
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private var didLayoutSubviews = false
    
    
    //  MARK: - View Lifecycle
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if didLayoutSubviews { return }
        optionsButton.layer.cornerRadius = optionsButton.frame.height / 2
        didLayoutSubviews = true
    }
}



//  MARK: - Private API

extension RecipeListView {
    
    private func layoutUI() {
        layoutCollectionView()
        layoutOptionsButton()
    }
    
    
    private func layoutCollectionView() {
        addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    
    private func layoutOptionsButton() {
        let trailingPadding: CGFloat = 16
        let bottomPadding: CGFloat = 72
        let dimension: CGFloat = 64
        
        addSubview(optionsButton)
        optionsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -trailingPadding).isActive = true
        optionsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomPadding).isActive = true
        optionsButton.heightAnchor.constraint(equalToConstant: dimension).isActive = true
        optionsButton.widthAnchor.constraint(equalTo: optionsButton.heightAnchor).isActive = true
    }
}
