//
//  EmojiTableViewController.swift
//  emojiReader
//
//  Created by Ilya Pavlov on 08.07.2023.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var objects = [
        Emoji(emoji: "🫶🏼", name: "Love", description: "Let's love each other", isFavourite: false),
        Emoji(emoji: "⚽️", name: "Football", description: "Let's play football together", isFavourite: false),
        Emoji(emoji: "🐈", name: "Cat", description: "Cat is the cutest animal", isFavourite: false),
        Emoji(emoji: "🎆", name: "Firework", description: "Never capture firework with phone", isFavourite: false)

    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to display an Edit button in the navigation bar fhr this view controller.
        self.title = "Emoji Reader"
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    /*
     Ниже три основных метода для конфигурации TableView (созданы apple по умолчанию)
     - numberOfSections - возвращает количество секций в таблице
     - tableView с параметром numberOfRowsInSection - возвращает количество строк в таблице
     - tableView с параметром cellForRowAt - возвращает ячйку, то есть в данном методе происходит непосредственно настройка ячейки
     */
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return objects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell                   // кастим ячейку до типа ячейки, которую мы создали и у нее появляются все свойства, которые мы создали в EmojiTableViewCell
        
        // с помощью indexPath вытаскиваем из objects конкретный элемент в ячейке..
        let object = objects[indexPath.row]
        
        // ..это необходимо, чтобы затем обратиться к данным из массива. Прописываем реализацию в EmojiTableViewCell
        cell.set(object: object)
        
        return cell
    }
    
    // реализуем метод, чтобы можно было удалять элементы из списка (данный метод можно не писать, так как он имплементирован по умолчанию)
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // непосредственно реализуем удаление элементов из массива и из View
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // реализуем возможность двигать объекты с помощью соответствующего элемента интерфейса - в данном методе просто показываем клавишу передвижения
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // в данном методе прописываем логику того, как происходит перемещение элементов
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // создаем свойство, в которое запишем объект, который хотим переместить
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        
        // Вставляем перемещаемый объект в новую позицию
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
}
