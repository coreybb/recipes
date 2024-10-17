import UIKit
import Combine

final class RecipeListController: UIViewController {
    
    private let mainView = RecipesView()
    private let viewModel: RecipeListViewModel
    private lazy var collectionDataSource = RecipeCollectionDataSource(collectionView: mainView.collectionView)
    private let collectionDelegate = RecipeCollectionViewDelegate()
    private lazy var cancellables = Set<AnyCancellable>()
    
    
    //  MARK: - View Lifecycle
    
    init(container: DependencyContainer) {
        self.viewModel = RecipeListViewModel(
            repository: container.recipesRepository,
            fetchImageUseCase: container.fetchImageUseCase
        )
        super.init(nibName: nil, bundle: nil)
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
        mainView.collectionView.dataSource = collectionDataSource
        mainView.collectionView.delegate = collectionDelegate
    }
    
    
    private func setupBindings() {
        collectionDataSource.subscribeToCellViewModels(viewModel.$cellViewModels)
        subscribeToLoadingState()
        collectionDelegate.onCellSelection = { [weak self] cellViewModel in
            self?.handleSelected(cellViewModel)
        }
        collectionDelegate.onCellWillAppear = { [weak self] cellViewModel, cell in
            self?.handleCellWillAppear(cellViewModel, cell: cell)
        }
        collectionDelegate.onCellWillDisappear = { [weak self] cellViewModel, cell in
            self?.handleCellWillDisappear(cellViewModel, cell: cell)
        }
    }
    
    
    private func subscribeToLoadingState() {
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                self?.updateLoadingState(isLoading)
            }
            .store(in: &cancellables)
    }
    
    
    
    private func handleCellWillAppear(_ cellViewModel: RecipeCellViewModel, cell: UICollectionViewCell) {
        
    }
    
    
    private func handleCellWillDisappear(_ cellViewModel: RecipeCellViewModel, cell: UICollectionViewCell) {
        
    }
    
    
    private func updateLoadingState(_ isLoading: Bool) {
        
    }
    

    private func handleSelected(_ cellViewModel: RecipeCellViewModel) {
        
    }
}
