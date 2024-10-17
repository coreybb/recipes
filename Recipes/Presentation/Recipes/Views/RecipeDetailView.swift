import UIKit

final class RecipeDetailView: UIView {
    
    let nameLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let cuisineLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let imageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "photo")!
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.gray)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    //  MARK: - Initialization
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 16
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //  MARK: - Private API

    private func layoutUI() {
        addSubview(nameLabel)
        addSubview(cuisineLabel)
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            cuisineLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            cuisineLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            cuisineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            cuisineLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
