//
//  Router.swift
//  AlbumsApp
//
//  Created by Yalçın Golayoğlu on 22.02.2022.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? {get}
    static func startExecution() -> AnyRouter
    func goDetail(for album: AlbumResult) -> UIViewController
}

class AlbumRouter: AnyRouter {
   
    var entry: EntryPoint?
    static func startExecution() -> AnyRouter {
        let router = AlbumRouter()
        var view: AnyView = AlbumsViewController()
        var presenter: AnyPresenter = AlbumPresenter()
        var interactor: AnyInteractor = AlbumInteractor()
        
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
        
//        let presenter = AlbumDetailPresenter(interactor: AlbumDetailInteractor(album: album))
//        let view = AlbumDetailViewController()
//        view.presenter = presenter
//        return view
    }
    
    
    
    
}
