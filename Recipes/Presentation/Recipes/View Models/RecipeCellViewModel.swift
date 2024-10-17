import UIKit
import Combine

final class RecipeCellViewModel {
    
    //  MARK: - Internal Properties
    
    let name: String
    let cuisine: Cuisine
    let sourceURLString: String?
    @Published private(set) var image: UIImage?
    
    
    //  MARK: - Private Properties
    
    private let imageURL: URL?
    private let fetchImageUseCase: FetchImageUseCase
    private var imageLoadingTask: Task<Void, Never>?
    private var imageLoadDidFail = false
    private let id: String
    
    
    //  MARK: - Initialization
    
    init(recipe: Recipe, fetchImageUseCase: FetchImageUseCase) {
        self.name = recipe.name
        self.cuisine = recipe.cuisine
        self.sourceURLString = recipe.sourceURL
        self.imageURL = URL(string: recipe.photoURLSmall)
        self.fetchImageUseCase = fetchImageUseCase
        self.id = recipe.id
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
