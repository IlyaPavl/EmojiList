//
//  NewEmojiTableViewController.swift
//  emojiReader
//
//  Created by Ilya Pavlov on 09.07.2023.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {
    
    var emoji = Emoji(emoji: "", name: "", description: "", isFavourite: false)
    
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSaveButtonState()

    }
    
    // функция для того, чтобы кнопка save была неактвиной пока все три тектсовых поля не заполнятся
    private func updateSaveButtonState() {
        let emojiText = emojiTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    // данная функция используется, чтобы подготовить данные при переходе на главный экран приложения
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveSegue" else {return}
        
        // создаем эти константы, чтобы забрать данные из текстовых полей
        let emoji = emojiTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        
        //далее обновляем переменную с новыми данными
        self.emoji = Emoji(emoji: emoji, name: name, description: description, isFavourite: self.emoji.isFavourite)
    }
}
