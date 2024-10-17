import UIKit
import Combine

final class RecipeCellViewModel {
    
    //  MARK: - Internal Properties
    
    let recipe: Recipe
    var name: String { recipe.name }
    var cuisine: String { recipe.cuisine.rawValue }
    @Published private(set) var image: UIImage?
    
    
    //  MARK: - Private Properties
    
    private var imageURL: URL? { URL(string: recipe.photoURLSmall) }
    private let fetchImageUseCase: FetchImageUseCase
    private var imageLoadingTask: Task<Void, Never>?
    private var imageLoadDidFail = false
    private var id: String { recipe.id }
    
    
    //  MARK: - Initialization
    
    init(recipe: Recipe, fetchImageUseCase: FetchImageUseCase) {
        self.recipe = recipe
        self.fetchImageUseCase = fetchImageUseCase
    }
    
    
    //  MARK: - Internal API
    func loadImageIfNeeded() {
        guard image == nil,
              let url = imageURL,
              !imageLoadDidFail else {
            return
        }

        imageLoadingTask = Task {
            do {
                let loadedImage = try await fetchImageUseCase.execute(forURL: url)
                await MainActor.run {
                    self.image = loadedImage
                }
            } catch {
                imageLoadDidFail = true
                print("Failed to load image: \(error.localizedDescription)")
            }
        }
    }
    
    
    func cancelImageLoad() {
        imageLoadingTask?.cancel()
    }
}



//  MARK: - Hashable Conformance

extension RecipeCellViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: RecipeCellViewModel, rhs: RecipeCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
