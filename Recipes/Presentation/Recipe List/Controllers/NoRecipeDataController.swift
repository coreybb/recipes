import UIKit


final class NoRecipeDataController: UIViewController {
    
    private let mainView = NoRecipeDataView()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .automatic
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
}
