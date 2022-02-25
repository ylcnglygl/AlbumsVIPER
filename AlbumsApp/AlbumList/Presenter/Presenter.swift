//
//  Presenter.swift
//  AlbumsApp
//
//  Created by Yalçın Golayoğlu on 22.02.2022.
//

import Foundation
import UIKit

protocol AlbumsPresenterProtocol {
    var router: AlbumRouter? {get set}
    var interactor: AlbumsInteractorProtocol? {get set}
    var view: AlbumsViewProtocol? {get set}
    func interactorDidDownloadAlbums(result: Result<[AlbumResult], Error>)
}

class AlbumPresenter: AlbumsPresenterProtocol {
    
    var router: AlbumRouter?
    
    var interactor: AlbumsInteractorProtocol? {
        didSet {
            interactor?.downloadAlbums()
        }
    }
    
    var view: AlbumsViewProtocol?
    
    func interactorDidDownloadAlbums(result: Result<[AlbumResult], Error>) {
        switch result {
        case .success(let albums):
            view?.update(with: albums)
        case .failure(_):
            view?.update(with: "Error")
        }
    }
   
    
    
    
}
