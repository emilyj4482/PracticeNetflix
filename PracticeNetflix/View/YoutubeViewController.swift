//
//  YoutubeViewController.swift
//  PracticeNetflix
//
//  Created by EMILY on 25/12/2024.
//

import UIKit
import YouTubeiOSPlayerHelper

class YoutubeViewController: UIViewController {
    private let key: String
    private let playerView = YTPlayerView()
    
    init(key: String) {
        self.key = key
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        playerView.delegate = self
        playerView.load(withVideoId: key)
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(playerView)
        
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension YoutubeViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
