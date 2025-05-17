struct APIUser : Codable {
	let id: Int?
	let name: String?
	let email: String?
	let phone: String?
	let position: String?
	let positionID: Int?
	let registrationTimestamp: Int?
	let photo: String?

	enum CodingKeys: String, CodingKey {
		case id = "id"
		case name = "name"
		case email = "email"
		case phone = "phone"
		case position = "position"
		case positionID = "position_id"
		case registrationTimestamp = "registration_timestamp"
		case photo = "photo"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		position = try values.decodeIfPresent(String.self, forKey: .position)
        positionID = try values.decodeIfPresent(Int.self, forKey: .positionID)
        registrationTimestamp = try values.decodeIfPresent(Int.self, forKey: .registrationTimestamp)
		photo = try values.decodeIfPresent(String.self, forKey: .photo)
	}
    
    func transform() -> User? {
        guard let id, let name, let email, let phone, let position, let photo else { return nil }
        return User(id: id, name: name, email: email, phone: phone, position: position, photo: photo)
    }

}
