//
//  DMModel.swift
//  HttpRequest
//
//  Created by 易金 on 2018/1/5.
//  Copyright © 2018年 jin. All rights reserved.
//

import Foundation

class DMModel: Codable {
    var album_offset: Int
    var artist_offset: Int
    var dm_error: Int
    var error_msg: String
    var recommend: Int
    var total_albums: Int
    var total_artists: Int
    var total_tracks: Int
    var track_offset: Int
    var artists: [DMModelArtists]?
    var albums: [DMModelAlbums]?
}

class DMModelAlbums: Codable {
    var artists:[DMModelAlbumsArtists]
    var available: Bool
    var company: String
    var cover: String?
    var id: Int
    var name: String
    var num_tracks: Int
    var release_date: String
    var type: String
    
    class DMModelAlbumsArtists: Codable {
        var id: Int
        var name: String
        var portrait: String?
        var valid: Bool
    }
}

class DMModelArtists: Codable {
    var id: Int
    var name: String
    var num_albums: Int
    var num_tracks: Int
    var portrait: String
    var valid: Bool
}


