//
//  AFKCharacter.swift
//  MyProject
//
//  Created by Ben on 2019/10/23.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class AFKCharacter{
    var name = ""
    var picture: UIImage?
    var description = ""
    
    init(name: String, picture: UIImage, description: String){
        self.name = name
        self.picture = picture
        self.description = description
    }
    
    static func createCharacters() -> [AFKCharacter]{
        return [
            getCharacterByKey(name: "angelo"),
            getCharacterByKey(name: "ankhira"),
            getCharacterByKey(name: "arden"),
            getCharacterByKey(name: "athalia"),
            getCharacterByKey(name: "baden"),
            getCharacterByKey(name: "belinda"),
            getCharacterByKey(name: "brutus"),
            getCharacterByKey(name: "eironn"),
            getCharacterByKey(name: "estrilda"),
            getCharacterByKey(name: "ezizh"),
            getCharacterByKey(name: "fawkes"),
            getCharacterByKey(name: "ferael"),
            getCharacterByKey(name: "golus"),
            getCharacterByKey(name: "gorvo"),
            getCharacterByKey(name: "grezhul"),
            getCharacterByKey(name: "hendrik"),
            getCharacterByKey(name: "hogan"),
            getCharacterByKey(name: "ira"),
            getCharacterByKey(name: "isabella"),
            getCharacterByKey(name: "kaz"),
            getCharacterByKey(name: "kelthur"),
            getCharacterByKey(name: "khasos"),
            getCharacterByKey(name: "lucius"),
            getCharacterByKey(name: "lyca"),
            getCharacterByKey(name: "mehira"),
            getCharacterByKey(name: "mirael"),
            getCharacterByKey(name: "morvus"),
            getCharacterByKey(name: "nara"),
            getCharacterByKey(name: "nemora"),
            getCharacterByKey(name: "niru"),
            getCharacterByKey(name: "numisu"),
            getCharacterByKey(name: "ogi"),
            getCharacterByKey(name: "raine"),
            getCharacterByKey(name: "rosaline"),
            getCharacterByKey(name: "rowan"),
            getCharacterByKey(name: "safiya"),
            getCharacterByKey(name: "saveas"),
            getCharacterByKey(name: "seirus"),
            getCharacterByKey(name: "shemira"),
            getCharacterByKey(name: "silvina"),
            getCharacterByKey(name: "skreg"),
            getCharacterByKey(name: "tasi"),
            getCharacterByKey(name: "thane"),
            getCharacterByKey(name: "thoran"),
            getCharacterByKey(name: "twins"),
            getCharacterByKey(name: "ulmus"),
            getCharacterByKey(name: "vedan"),
            getCharacterByKey(name: "vurk"),
            getCharacterByKey(name: "warek")
        ]
    }
    
    fileprivate static func getCharacterByKey(name: String) -> AFKCharacter{
        let mName = Bundle.main.localizedString(forKey: "name_\(name)", value: nil, table: nil)
        let mPicture = UIImage(named: "img_head_\(name).png")!
        let mDescription = Bundle.main.localizedString(forKey: "description_\(name)", value: nil, table: nil)
        return AFKCharacter(name: mName, picture: mPicture, description: mDescription)
    }
}
