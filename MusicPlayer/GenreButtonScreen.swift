//
//  GenreButtonScreen.swift
//  MusicPlayer
//
//  Created by Hoang Nguyen on 7/23/17.
//  Copyright © 2017 Hoang Nguyen. All rights reserved.
//

import UIKit
import MediaPlayer

class GenreButtonScreen: UIViewController {
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(colorOne: .lightGray, colorTwo: .clear)


    }
    
    @IBAction func genreButtonTapped(_ sender: UIButton) {
        
        MPMediaLibrary.requestAuthorization { (status) in //checking authorization
            if status == .authorized {
                self.playGenre(genre: sender.currentTitle!)
            } else {
                
                let ac = UIAlertController(title: "Error", message: "You did not authorize your media player to be used.", preferredStyle: .alert)
                
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
                
                self.present(ac, animated: true)
            }
        }
        
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        musicPlayer.stop()
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
    }
    
    func playGenre(genre: String) {
        
        musicPlayer.stop()
        
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: genre, forProperty: MPMediaItemPropertyGenre)
        
        query.addFilterPredicate(predicate)
        
        musicPlayer.setQueue(with: query)
        musicPlayer.shuffleMode = .songs
        musicPlayer.play()
        
    }


}
