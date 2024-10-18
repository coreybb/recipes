import UIKit
import Combine

final class RecipeListController: UIViewController {
    
    //  MARK: - Internal Properties
    
    weak var coordinator: RecipeListCoordinating?
    
    
    //  MARK: - Private Properties
    
    private lazy var searchController = RecipeSearchController()
    private let mainView = RecipeListView()
    private let viewModel: RecipeListViewModel
    private lazy var collectionDataSource = RecipeCollectionDataSource(collectionView: mainView.collectionView)
    private let collectionDelegate = RecipeCollectionViewDelegate()
    var cancellables = Set<AnyCancellable>()
    
    
    //  MARK: - View Lifecycle
    
    init(container: DependencyContainer) {
        self.viewModel = RecipeListViewModel(
            repository: container.recipesRepository,
            fetchImageUseCase: container.fetchImageUseCase
        )
        super.init(nibName: nil, bundle: nil)
        title = "Recipes"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = mainView
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupView()
        viewModel.streamRecipes()
    }
}


//  MARK: - Private API

extension RecipeListController {
    
    private func setupView() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        mainView.collectionView.delegate = collectionDelegate
        mainView.collectionView.dataSource = collectionDataSource
        mainView.collectionView.prefetchDataSource = collectionDataSource
    }
    
    
    private func handleCellWillShow(_ cellViewModel: RecipeCellViewModel, _ cell: UICollectionViewCell) {
        (cell as? RecipeCollectionCell)?.loadImageIfNeeded()
    }
    
    
    private func handleCellWillDisappear(_ cellViewModel: RecipeCellViewModel, _ cell: UICollectionViewCell) {
        (cell as? RecipeCollectionCell)?.cancelImageLoading()
    }
    
    
    private func handleScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.y > 100,
              searchController.searchBar.isFirstResponder
        else { return }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    
    private func updateLoadingState(_ isLoading: Bool) {
        // TODO: - Implement me
    }
    

    private func handleSelected(_ cellViewModel: RecipeCellViewModel) {
        coordinator?.showRecipeDetail(for: cellViewModel.recipe)
    }
}


//  MARK: - Bindable

extension RecipeListController: Bindable {
    
    private func setupBindings() {
        collectionDataSource.subscribeToCellViewModels(viewModel.$displayedRecipeCellViewModels)
        
        subscribe(viewModel.$isLoading) { [weak self] in
            self?.updateLoadingState($0)
        }

        subscribe(collectionDelegate.onCellSelection) { [weak self] in
            self?.handleSelected($0)
        }

        subscribe(collectionDelegate.onCellWillShow) { [weak self] in
            self?.handleCellWillShow($0.0, $0.1)
        }

        subscribe(collectionDelegate.onCellWillDisappear) { [weak self] in
            self?.handleCellWillDisappear($0.0, $0.1)
        }

        subscribe(collectionDelegate.onScroll) { [weak self] in
            self?.handleScroll($0)
        }
    }
}


//  MARK: - UISearchController Delegate

extension RecipeListController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.searchRecipes(for: searchText)
    }
}
