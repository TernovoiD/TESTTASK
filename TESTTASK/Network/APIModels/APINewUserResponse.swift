struct APINewUserResponse: Codable {
	let success: Bool?
	let userID: Int?
	let message: String?

	enum CodingKeys: String, CodingKey {
		case success = "success"
		case userID = "user_id"
		case message = "message"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
        userID = try values.decodeIfPresent(Int.self, forKey: .userID)
		message = try values.decodeIfPresent(String.self, forKey: .message)
	}

}
