import Combine


final class RecipeListViewModel {
    
    //  MARK: - Internal Properties
    
    var onRecipeUpdation = PassthroughSubject<Void, Never>()
    @Published var cellViewModels = [RecipeCellViewModel]()
    @Published private(set) var isLoading = false
    
    
    //  MARK: - Private Properties

    private let repository: RecipeRepository
    private let fetchImageUseCase: FetchImageUseCase
    private var recipesFetchTask: Task<Void, Never>?
    
    
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
                    await MainActor.run { handle(recipes) }
                }
            } catch {
                if !Task.isCancelled {
                    print(error)
                }
            }
        }
    }
    
    
    func refreshRecipes() {
        cellViewModels = []
        streamRecipes()
    }
    
    
    func cancelFetch() {
        recipesFetchTask?.cancel()
        recipesFetchTask = nil
    }
    
    
    //  MARK: - Private API
    
    private func handle(_ recipes: [Recipe]) {
        cellViewModels = recipes.map {
            RecipeCellViewModel(recipe: $0, fetchImageUseCase: fetchImageUseCase)
        }
        onRecipeUpdation.send()
    }
}
