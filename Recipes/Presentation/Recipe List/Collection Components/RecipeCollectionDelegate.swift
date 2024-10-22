import UIKit
import Combine

final class RecipeCollectionViewDelegate: NSObject {

    let onCellSelection = PassthroughSubject<RecipeCellViewModel, Never>()
    let onCellWillShow = PassthroughSubject<RecipeCellViewModel, Never>()
    let onCellWillDisappear = PassthroughSubject<RecipeCellViewModel, Never>()
    let onScroll = PassthroughSubject<UIScrollView, Never>()
}


//  MARK: - UICollectionView Delegation

extension RecipeCollectionViewDelegate: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellViewModel = cellViewModel(from: collectionView, indexPath) else { return }
        onCellSelection.send(cellViewModel)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cellViewModel = cellViewModel(from: collectionView, indexPath) else { return }
        onCellWillShow.send(cellViewModel)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cellViewModel = cellViewModel(from: collectionView, indexPath) else { return }
        onCellWillDisappear.send(cellViewModel)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onScroll.send(scrollView)
    }
}


//  MARK: - Private API

fileprivate extension RecipeCollectionViewDelegate {
    
    private func cellViewModel(from collectionView: UICollectionView, _ indexPath: IndexPath) -> RecipeCellViewModel? {
        guard let dataSource = collectionView.dataSource as? RecipeCollectionDataSource,
              let cellViewModel = dataSource.itemIdentifier(for: indexPath)
        else {
            return nil
        }
        
        return cellViewModel
    }
}
