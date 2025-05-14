struct Links: Codable {
	let nextUrl: String?
	let prevUrl: String?

	enum CodingKeys: String, CodingKey {
		case nextUrl = "next_url"
		case prevUrl = "prev_url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        nextUrl = try values.decodeIfPresent(String.self, forKey: .nextUrl)
        prevUrl = try values.decodeIfPresent(String.self, forKey: .prevUrl)
	}

}
