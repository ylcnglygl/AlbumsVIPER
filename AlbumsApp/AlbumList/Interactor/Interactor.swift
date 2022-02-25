//
//  Interactor.swift
//  AlbumsApp
//
//  Created by Yalçın Golayoğlu on 22.02.2022.
//

import Foundation

enum NetworkError: Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AlbumsInteractorProtocol {
    var presenter: AlbumsPresenterProtocol? {get set}
    func downloadAlbums()
}

class AlbumInteractor: AlbumsInteractorProtocol {
    var presenter: AlbumsPresenterProtocol?
    
    func downloadAlbums() {
        
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/music/most-played/50/albums.json") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidDownloadAlbums(result: .failure(NetworkError.NetworkFailed))
                return
            }
            do{
                let albums = try JSONDecoder().decode(Album.self, from: data)
                self?.presenter?.interactorDidDownloadAlbums(result: .success(albums.feed.results))
            }catch{
                self?.presenter?.interactorDidDownloadAlbums(result: .failure(NetworkError.ParsingFailed))

            }
        }
        task.resume()
    }
    
    
}
