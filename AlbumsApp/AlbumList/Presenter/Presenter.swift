//
//  Presenter.swift
//  AlbumsApp
//
//  Created by Yalçın Golayoğlu on 22.02.2022.
//

import Foundation
import UIKit

protocol AnyPresenter {
    var router: AlbumRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidDownloadAlbums(result: Result<[AlbumResult], Error>)
    func openScreen(album: AlbumResult)
}

class AlbumPresenter: AnyPresenter {
    func openScreen(album: AlbumResult) {
        
    }
    
   
    var router: AlbumRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadAlbums()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadAlbums(result: Result<[AlbumResult], Error>) {
        switch result {
        case .success(let albums):
            view?.update(with: albums)
        case .failure(_):
            view?.update(with: "Error")
        }
    }
   
    
    
    
}
