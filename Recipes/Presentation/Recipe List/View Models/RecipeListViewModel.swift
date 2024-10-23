import Combine


final class RecipeListViewModel {
    
    //  MARK: - Internal Properties
    
    @Published private(set) var displayedRecipeCellViewModels = [RecipeCellViewModel]()
    @Published private(set) var isLoading = false
    @Published var error: Error?
    
    
    //  MARK: - Private Properties
    
    private let repository: RecipeRepository
    private let fetchImageUseCase: FetchImageUseCase
    private var recipesFetchTask: Task<Void, Never>?
    var recipeCellViewModels = [RecipeCellViewModel]()
    
    
    //  MARK: - Initialization
    
    init(repository: RecipeRepository, fetchImageUseCase: FetchImageUseCase) {
        self.repository = repository
        self.fetchImageUseCase = fetchImageUseCase
    }
    
    
    //  MARK: - Internal API
    
    func streamRecipes() {
        cancelFetch()
        
        recipesFetchTask = Task {
            isLoading = true
            defer { isLoading = false }
            do {
                let recipes = try await repository.fetchRecipes()
                if !Task.isCancelled {
                    await MainActor.run { handleStreamed(recipes) }
                }
            } catch {
                if !Task.isCancelled {
                    await MainActor.run {
                        self.error = error
                    }
                }
            }
        }
    }
    
    
    func refreshRecipes() {
        recipeCellViewModels.removeAll()
        displayedRecipeCellViewModels.removeAll()
        streamRecipes()
    }
    
    
    func cancelFetch() {
        recipesFetchTask?.cancel()
        recipesFetchTask = nil
    }
    
    
    func searchRecipes(for query: String) {
        guard !query.isEmpty else {
            if displayedRecipeCellViewModels != recipeCellViewModels {
                displayedRecipeCellViewModels = recipeCellViewModels
            }
            return
        }
        
        displayedRecipeCellViewModels = recipeCellViewModels.filter {
            $0.name.lowercased().contains(query.lowercased())
            ||
            $0.cuisine.lowercased().contains(query.lowercased())
        }
    }
    
    
    func sortRecipes(by parameter: SortParameter) {
        let sortedRecipes = sortedRecipes(by: parameter)
        if displayedRecipeCellViewModels != sortedRecipes {
            displayedRecipeCellViewModels = sortedRecipes
        }
    }
}


//  MARK: - Private API

extension RecipeListViewModel {
    
    private func handleStreamed(_ recipes: [Recipe]) {
        let cellViewModels = recipes.map {
            RecipeCellViewModel(recipe: $0, fetchImageUseCase: fetchImageUseCase)
        }
        recipeCellViewModels.append(contentsOf: cellViewModels)
        displayedRecipeCellViewModels.append(contentsOf: cellViewModels)
    }
    
    
    private func sortedRecipes(by parameter: SortParameter) -> [RecipeCellViewModel] {
        switch parameter {
        case .name:
            return recipeCellViewModels.sorted {
                let space: String = " "
                let emptyString: String = ""
                let nameA = $0.name.components(separatedBy: space).first ?? emptyString
                let nameB = $1.name.components(separatedBy: space).first ?? emptyString
                return nameA.localizedCaseInsensitiveCompare(nameB) == .orderedAscending
            }
        case .cuisine:
            return recipeCellViewModels.sorted {
                $0.cuisine.localizedCaseInsensitiveCompare($1.cuisine) == .orderedAscending
            }
        }
    }
}
