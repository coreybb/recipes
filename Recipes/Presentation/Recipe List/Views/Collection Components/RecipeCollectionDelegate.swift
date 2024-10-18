import UIKit
import Combine

final class RecipeCollectionViewDelegate: NSObject {
    
    var onCellSelection: ((RecipeCellViewModel) -> Void)?
    var onCellWillAppear: ((RecipeCellViewModel, UICollectionViewCell) -> Void)?
    var onCellWillDisappear: ((RecipeCellViewModel, UICollectionViewCell) -> Void)?
}


//  MARK: - UICollectionView Delegation

extension RecipeCollectionViewDelegate: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellViewModel = cellViewModel(from: collectionView, indexPath) else { return }
        onCellSelection?(cellViewModel)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cellViewModel = cellViewModel(from: collectionView, indexPath) else { return }
        onCellWillAppear?(cellViewModel, cell)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cellViewModel = cellViewModel(from: collectionView, indexPath) else { return }
        onCellWillDisappear?(cellViewModel, cell)
    }
}


//  MARK: - Private API

fileprivate extension RecipeCollectionViewDelegate {
    
    private func cellViewModel(from collectionView: UICollectionView, _ indexPath: IndexPath) -> RecipeCellViewModel? {
        guard let dataSource = collectionView.dataSource as? RecipeCollectionDataSource,
              let cellViewModel = dataSource.itemIdentifier(for: indexPath)
        else {
            print("There is no cell view model at the specified index: \(indexPath.item)")
            return nil
        }
        
        return cellViewModel
    }
}
