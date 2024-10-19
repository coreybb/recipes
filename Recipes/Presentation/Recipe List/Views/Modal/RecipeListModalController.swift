import UIKit
import Combine

final class RecipeListModalController: UIViewController, Bindable {
    
    //  MARK: - Internal Properties
    
    let mainView = RecipeListModalView()
    var onSortTapped: ((SortParameter) -> Void)?
    var cancellables = Set<AnyCancellable>()
    
    
    //  MARK: - View Lifecycle
    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    
    //  MARK: - Private API
    
    private func setupBindings() {
        subscribe(mainView.onSortTapped) { [weak self] parameter in
            self?.onSortTapped?(parameter)
        }
    }
}
