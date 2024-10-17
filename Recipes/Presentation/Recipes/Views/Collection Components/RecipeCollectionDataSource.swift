import UIKit
import Combine

final class RecipeCollectionDataSource: UICollectionViewDiffableDataSource<RecipeCollectionDataSource.Section, RecipeCellViewModel> {
    
    enum Section { case main }

    
    //  MARK: - Private Properties

    private var cancellables = Set<AnyCancellable>()
    
    
    //  MARK: - Initialization
    
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, cellViewModel in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecipeCollectionCell.reuseID,
                for: indexPath
            ) as? RecipeCollectionCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: cellViewModel)
            return cell
        }
    }
    
    
    //  MARK: - Internal API
    
    func subscribeToCellViewModels(_ publisher: Published<[RecipeCellViewModel]>.Publisher) {
        publisher.sink { [weak self] cellViewModels in
            self?.updateSnapshot(with: cellViewModels)
        }
        .store(in: &cancellables)
    }
    
    
    //  MARK: - Private API
    
    @MainActor
    private func updateSnapshot(with cellViewModels: [RecipeCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<RecipeCollectionDataSource.Section, RecipeCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellViewModels)
        apply(snapshot, animatingDifferences: true)
    }
}
