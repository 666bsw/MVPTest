//
//  Models.swift
//  MVPTest
//
//  Created by Bezdenezhnykh Sergey on 16.06.2021.
//

import Foundation

// MARK: - Match
struct Match: Codable {
    let access:     Bool
    let calc:       Bool
    let date:       String
    let hasVideo:   Bool
    let live:       Bool
    let storage:    Bool
    let sub:        Bool
    let team1, team2:   Team
    let tournament:     Team

    enum CodingKeys: String, CodingKey {
        case access, calc, date, live, storage, sub, team1, team2, tournament
        case hasVideo = "has_video"
    }
}

// MARK: - Team
struct Team: Codable {
    let id:                 Int
    let nameEng, nameRus:   String
    let score:              Int?

    enum CodingKeys: String, CodingKey {
        case id
        case nameEng = "name_eng"
        case nameRus = "name_rus"
        case score
    }
}

// MARK: - VideoLink
struct VideoLink: Codable {
    let name:                               String
    let matchID, period, serverID:          Int     //id матча, период
    let quality, folder, videoType, abc:    String  //качество видео ... дорожка
    let startMS, checksum, size:            Int
    let abcType:                            String
    let duration, fps:                      Int
    let urlRoot:                            String  //рут ссылка
    let url:                                String  //ссылка

    enum CodingKeys: String, CodingKey {
        case name
        case matchID = "match_id"
        case period
        case serverID = "server_id"
        case quality, folder
        case videoType = "video_type"
        case abc
        case startMS = "start_ms"
        case checksum, size
        case abcType = "abc_type"
        case duration, fps
        case urlRoot = "url_root"
        case url
    }
}

typealias VideoLinks = [VideoLink]

