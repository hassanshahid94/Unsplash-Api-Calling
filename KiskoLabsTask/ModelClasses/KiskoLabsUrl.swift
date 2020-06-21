//
//	KiskoLabsUrl.swift
//
//	Create by Hassan Shahid on 15/6/2020
//	Copyright © 2020. All rights reserved.

import Foundation

struct KiskoLabsUrl : Codable {

	let full : String?
	let raw : String?
	let regular : String?
	let small : String?
	let thumb : String?


	enum CodingKeys: String, CodingKey {
		case full = "full"
		case raw = "raw"
		case regular = "regular"
		case small = "small"
		case thumb = "thumb"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		full = try values.decodeIfPresent(String.self, forKey: .full)
		raw = try values.decodeIfPresent(String.self, forKey: .raw)
		regular = try values.decodeIfPresent(String.self, forKey: .regular)
		small = try values.decodeIfPresent(String.self, forKey: .small)
		thumb = try values.decodeIfPresent(String.self, forKey: .thumb)
	}


}
