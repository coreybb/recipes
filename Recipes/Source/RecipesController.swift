import UIKit

final class RecipesController: UIViewController {
    
    private let recipesRepository: RecipesRepository
    
    
    //  MARK: - Initialization
    
    init(recipesRepository: RecipesRepository) {
        self.recipesRepository = recipesRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

