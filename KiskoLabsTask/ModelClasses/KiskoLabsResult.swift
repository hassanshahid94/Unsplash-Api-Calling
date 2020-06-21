//
//	KiskoLabsResult.swift
//
//	Create by Hassan Shahid on 15/6/2020
//	Copyright © 2020. All rights reserved.

import Foundation

struct KiskoLabsResult : Codable {

	let altDescription : String?
	let categories : [String]?
	let color : String?
	let createdAt : String?
	let currentUserCollections : [String]?
	let descriptionField : String?
	let height : Int?
	let id : String?
	let likedByUser : Bool?
	let likes : Int?
	let promotedAt : String?
	let sponsorship : String?
	let updatedAt : String?
	let urls : KiskoLabsUrl?
	let width : Int?


	enum CodingKeys: String, CodingKey {
		case altDescription = "alt_description"
		case categories = "categories"
		case color = "color"
		case createdAt = "created_at"
		case currentUserCollections = "current_user_collections"
		case descriptionField = "description"
		case height = "height"
		case id = "id"
		case likedByUser = "liked_by_user"
		case likes = "likes"
		case promotedAt = "promoted_at"
		case sponsorship = "sponsorship"
		case updatedAt = "updated_at"
		case urls = "urls"
		case width = "width"
	}
    
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		altDescription = try values.decodeIfPresent(String.self, forKey: .altDescription)
		categories = try values.decodeIfPresent([String].self, forKey: .categories)
		color = try values.decodeIfPresent(String.self, forKey: .color)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
		currentUserCollections = try values.decodeIfPresent([String].self, forKey: .currentUserCollections)
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		likedByUser = try values.decodeIfPresent(Bool.self, forKey: .likedByUser)
		likes = try values.decodeIfPresent(Int.self, forKey: .likes)
		promotedAt = try values.decodeIfPresent(String.self, forKey: .promotedAt)
		sponsorship = try values.decodeIfPresent(String.self, forKey: .sponsorship)
		updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        urls = try values.decodeIfPresent(KiskoLabsUrl.self, forKey: .urls)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
	}


}
