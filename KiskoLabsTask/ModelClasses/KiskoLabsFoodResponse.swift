//
//	KiskoLabsFoodResponse.swift
//
//	Create by Hassan Shahid on 15/6/2020
//	Copyright © 2020. All rights reserved.

import Foundation

struct KiskoLabsFoodResponse : Codable {

	let results : [KiskoLabsResult]?
	let total : Int?
	let totalPages : Int?


	enum CodingKeys: String, CodingKey {
		case results = "results"
		case total = "total"
		case totalPages = "total_pages"
	}
    
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		results = try values.decodeIfPresent([KiskoLabsResult].self, forKey: .results)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
		totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
	}


}
