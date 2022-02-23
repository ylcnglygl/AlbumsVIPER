//
//  AlbumDetailInteractor.swift
//  AlbumsApp
//
//  Created by Yalçın Golayoğlu on 23.02.2022.
//

import Foundation

class AlbumDetailInteractor {
    var presenter: AlbumDetailPresenter?
    var album: AlbumResult? = nil
  
    func gelAlbumFromInteractor(album: AlbumResult){
        presenter?.getAlbum(result: .success(album))
    }
}
