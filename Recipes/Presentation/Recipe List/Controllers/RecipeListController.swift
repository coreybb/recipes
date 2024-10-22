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
    
    
    //  MARK: - Private API
    
    private func setupView() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        mainView.collectionView.delegate = collectionDelegate
        mainView.collectionView.dataSource = collectionDataSource
        mainView.collectionView.prefetchDataSource = collectionDataSource
    }
}


//  MARK: - Bindable

extension RecipeListController: Bindable {
    
    private func setupBindings() {
        setupCollectionViewBindings()
        setupUIInteractionBindings()
    }

    
    private func setupCollectionViewBindings() {
        collectionDataSource.subscribeToCellViewModels(viewModel.$displayedRecipeCellViewModels)
        
        subscribe(collectionDelegate.onCellSelection) { [weak self] cellViewModel in
            self?.coordinator?.showRecipeDetail(for: cellViewModel.recipe)
        }

        subscribe(collectionDelegate.onCellWillShow) { cellViewModel in
            cellViewModel.loadImageIfNeeded()
        }

        subscribe(collectionDelegate.onCellWillDisappear) { cellViewModel in
            cellViewModel.cancelImageLoad()
        }
        
        subscribe(collectionDelegate.onScroll) { [weak self] scrollView in
            guard let self else { return }
            guard scrollView.contentOffset.y > 100,
                  searchController.searchBar.isFirstResponder
            else { return }
            
            searchController.searchBar.resignFirstResponder()
        }
    }

    
    private func setupUIInteractionBindings() {
        subscribe(mainView.onOptionsButtonTap) { [weak self] in
            guard let self else { return }
            coordinator?.showOptionsModal(from: self) { parameter in
                self.viewModel.sortRecipes(by: parameter)
            }
        }

        subscribe(viewModel.$isLoading) { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                mainView.collectionView.refreshControl?.beginRefreshing()
                mainView.activityIndicator.startAnimating()
            } else {
                mainView.collectionView.refreshControl?.endRefreshing()
                mainView.activityIndicator.stopAnimating()
                
                if viewModel.recipeCellViewModels.isEmpty {
                    mainView.collectionView.backgroundView = NoRecipeDataView()
                } else {
                    mainView.collectionView.backgroundView = nil
                }
            }
        }

        subscribe(mainView.collectionView.didPullToRefresh) { [weak self] in
            self?.viewModel.refreshRecipes()
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
