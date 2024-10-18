import UIKit

final class RecipeSearchController: UISearchController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = "Search recipes"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
