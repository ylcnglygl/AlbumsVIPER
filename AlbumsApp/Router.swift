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
    
    
}
