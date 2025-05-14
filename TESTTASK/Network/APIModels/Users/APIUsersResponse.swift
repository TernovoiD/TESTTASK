struct APIUsersResponse: Codable {
	let success: Bool?
	let page: Int?
	let totalPages: Int?
	let totalUsers: Int?
	let count: Int?
	let links: Links?
	let users: [APIUser]?

	enum CodingKeys: String, CodingKey {
		case success = "success"
		case page = "page"
		case totalPages = "total_pages"
		case totalUsers = "total_users"
		case count = "count"
		case links = "links"
		case users = "users"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        totalUsers = try values.decodeIfPresent(Int.self, forKey: .totalUsers)
		count = try values.decodeIfPresent(Int.self, forKey: .count)
		links = try values.decodeIfPresent(Links.self, forKey: .links)
		users = try values.decodeIfPresent([APIUser].self, forKey: .users)
	}

}
