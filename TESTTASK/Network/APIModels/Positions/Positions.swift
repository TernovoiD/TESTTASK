struct APIPositions: Codable {
	let id: Int?
	let name: String?
    
    func transform() -> Position? {
        guard let id, let name else { return nil }
        return Position(id: id, name: name)
    }
}
