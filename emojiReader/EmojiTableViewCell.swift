//
//  EmojiTableViewCell.swift
//  emojiReader
//
//  Created by Ilya Pavlov on 08.07.2023.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet weak var emoji: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // функция, которая задает значения лейблам
    func set(object: Emoji) {
        // пишем self в начале кода, так как мы находимся в "настройке" самой ячейки
        self.emoji.text = object.emoji
        self.nameLabel.text = object.name
        self.descriptionLabel.text = object.description
    }

}
