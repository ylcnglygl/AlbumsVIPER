//
//  Router.swift
//  AlbumsApp
//
//  Created by Yalçın Golayoğlu on 22.02.2022.
//

import Foundation
import UIKit

typealias EntryPoint = AlbumsViewProtocol & UIViewController

protocol AlbumsRouterProtocol {
    var entry: EntryPoint? {get}
    static func startExecution() -> AlbumsRouterProtocol
    func goDetail(for album: AlbumResult) -> UIViewController
}

class AlbumRouter: AlbumsRouterProtocol {
   
    var entry: EntryPoint?
    static func startExecution() -> AlbumsRouterProtocol {
        let router = AlbumRouter()
        let view = AlbumsViewController()
        let presenter = AlbumPresenter()
        let interactor = AlbumInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        return router
    }
    
    func goDetail(for album: AlbumResult) -> UIViewController {
        let view = AlbumDetailViewController()
        let interactor = AlbumDetailInteractor()
        let presenter = AlbumDetailPresenter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.gelAlbumFromInteractor(album: album)
        return view
    }
    
    
    
    
}
