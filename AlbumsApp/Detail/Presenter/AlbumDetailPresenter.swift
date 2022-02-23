//
//  Presenter.swift
//  AlbumsApp
//
//  Created by Yalçın Golayoğlu on 22.02.2022.
//

import Foundation

protocol AlbumDetailPresenterProtocol {
    var view: AlbumDetailViewProtocol? {get set}
    var interactor: AlbumDetailInteractor? {get set}
    func getAlbum(result: Result<AlbumResult, Error>)
}

class AlbumDetailPresenter: AlbumDetailPresenterProtocol {
    
    var view: AlbumDetailViewProtocol?
    var interactor: AlbumDetailInteractor?
    
    func getAlbum(result: Result<AlbumResult, Error>) {
        switch result {
        case .success(let album):
            view?.updateAlbum(with: album)
            print(album.name)
        case .failure(_):
            view?.updateAlbum(with: "Error")
        }
    }
    
    
}
