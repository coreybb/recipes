extension Array {
    
    /**
     *  Safely accesses the element at the specified index.
     *
     *  - Parameter index: The position of the element.
     *  - Returns: The elemenet at the specified index if it exists, otherwise `nil`.
     */
    func safeElement(at index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
