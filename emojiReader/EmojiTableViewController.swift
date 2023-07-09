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
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // для того, чтобы по нажатию кнопок Cancel иил Save со второго экрана возвращаться назад напишем функцию segue
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else {return}
        
        // чтобы добраться до свойств экрана 2 необходимо обратиться к этому экрану через свойство и затем взять с помощью этого свойства остальные свойства экрана 2
        let sourceVC = segue.source as! NewEmojiTableViewController
        let emoji = sourceVC.emoji
        
        // реализовываем функционал, который позволит изменять значения в текущей ячейки при редактировании, а не создавать новую
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            objects[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            // создаем свойство, которое будет создавать новый путь до добавленного объекта
            let newIndexPath = IndexPath(row: objects.count, section: 0)
            
            // добавляем объект в массив
            objects.append(emoji)
            
            // обновляем основную таблицу (экран)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
        
 
    }
    
    // реализовываем здесь функцию prepare, чтобы при переходе на всплывающее меню редактирования ячейки, передавать во второй экран данные
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else { return }
        
        // фиксируем indexPath, в котором мы находимся
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        
        // сначала добираемся до navigationVC, а потом то самого tableView, так как navigationVC содержит tableView и затем обращаемся к свойствам tableView и назначем
        let navigationVC = segue.destination as! UINavigationController
        let newEmojiVC = navigationVC.topViewController as! NewEmojiTableViewController
        newEmojiVC.emoji = emoji
        
        newEmojiVC.title = "Edit"
        
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
    
    // реализуем метод для того, чтобы свайпать слева направо и выполнять какие-то действия (ставить лайк и чекмарк ячейку)
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let like = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, like])
    }
    
    // метод done
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    // метод для лайка (аналогично done, но с некоторыми твиками)
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Like") { (action, view, completion) in
            object.isFavourite = !object.isFavourite
            self.objects[indexPath.row] = object
            completion(true)
        }
        action.backgroundColor = object.isFavourite ? .systemRed : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
}
