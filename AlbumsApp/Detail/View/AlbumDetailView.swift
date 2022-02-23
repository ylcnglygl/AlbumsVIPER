//
//  View.swift
//  AlbumsApp
//
//  Created by Yalçın Golayoğlu on 22.02.2022.
//

import Foundation
import UIKit

protocol AlbumDetailViewProtocol {
    var presenter: AlbumDetailPresenterProtocol? {get set}
    func updateAlbum(with album: AlbumResult)
    func updateAlbum(with error: String)
}

class AlbumDetailViewController: UIViewController, AlbumDetailViewProtocol {
    var album: AlbumResult?
    
    // Indicator
    
    private var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .red
        return indicator
    }()
    
    // Image View
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.isHidden = false
        return imageView
    }()
    
    // CustomUILabels

    private let albumName: CustomUILabel = CustomUILabel()
    private let artistName: CustomUILabel = CustomUILabel()
    private let albumGenres: CustomUILabel = CustomUILabel()
    private let albumReleaseDate: CustomUILabel = CustomUILabel()
    
    // Start
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(albumImageView)
        view.addSubview(artistName)
        view.addSubview(albumName)
        view.addSubview(albumGenres)
        view.addSubview(albumReleaseDate)
        view.addSubview(indicatorView)
        self.indicatorView.startAnimating()
        showImage()
        albumName.text = album?.name
        artistName.text = album?.artistName
        albumGenres.text = album?.genres[0].name
        albumReleaseDate.text = album?.releaseDate
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeAlbumImage()
        makeAlbumName()
        makeArtistName()
        makeAlbumGenres()
        makeAlbumReleaseDate()
        makeIndicatorView()
    }
    
    var presenter: AlbumDetailPresenterProtocol?
    
    func updateAlbum(with album: AlbumResult) {
        self.album = album
    }
    
    func updateAlbum(with error: String) {
        let alert = UIAlertController(title: "Woops", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
  
    
    // Design
    func makeIndicatorView(){
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: albumImageView.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: albumImageView.centerYAnchor),
        ])
    }
    
    func makeAlbumImage(){
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            albumImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            albumImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            albumImageView.heightAnchor.constraint(equalToConstant: view.frame.size.height/3),
        ])
    }
    func makeAlbumName(){
        NSLayoutConstraint.activate([
            albumName.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 20),
            albumName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            albumName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    func makeArtistName(){
        NSLayoutConstraint.activate([
            artistName.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 20),
            artistName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            artistName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    func makeAlbumGenres(){
        NSLayoutConstraint.activate([
            albumGenres.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 20),
            albumGenres.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            albumGenres.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    func makeAlbumReleaseDate(){
        NSLayoutConstraint.activate([
            albumReleaseDate.topAnchor.constraint(equalTo: albumGenres.bottomAnchor, constant: 20),
            albumReleaseDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            albumReleaseDate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    func showImage(){
        
        guard let url = URL(string: self.album?.artworkUrl100 ?? "") else {
            return
        }
        UIImage.loadFrom(url: url) { image in
            self.albumImageView.image = image
            self.indicatorView.stopAnimating()
        }
       
        
    }
}


