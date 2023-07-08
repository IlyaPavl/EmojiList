//
//  EmojiTableViewController.swift
//  emojiReader
//
//  Created by Ilya Pavlov on 08.07.2023.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    let objects = [
        Emoji(emoji: "🫶🏼", name: "Love", description: "Let's love each other", isFavourite: false),
        Emoji(emoji: "⚽️", name: "Football", description: "Let's play football together", isFavourite: false),
        Emoji(emoji: "🐈", name: "Cat", description: "Cat is the cutest animal", isFavourite: false)
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
        
        // ..это необходимо, чтобы затем обратиться к данным из массива. Прописываем это в отдельно ViewCell
        cell.set(object: object)
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
