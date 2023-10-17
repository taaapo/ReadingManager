
import UIKit
import RealmSwift

class ToDoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    var toDo: Results<ToDo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadToDo()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "ToDoCell", bundle: nil), forCellReuseIdentifier: "ReusableToDoCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDo?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableToDoCell", for: indexPath) as! ToDoCell
        
        cell.title.text = toDo?[indexPath.row].title ?? "本が追加されていません"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "「読んだ本」に追加しますか？", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "追加", style: .default) { (action) in
            
            let newBook = Book()
            newBook.title = self.toDo?[indexPath.row].title ?? ""
            newBook.review = "☆☆☆☆☆"
            newBook.category = ""
            newBook.overview = ""
            newBook.impression = ""
            do {
                try self.realm.write{
                    self.realm.add(newBook)
                }
            } catch {
                print("Error saving conetxt \(error)")
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            
            if let toDoForDeletion = self.toDo?[indexPath.row] {
                do {
                    try self.realm.write({
                        self.realm.delete(toDoForDeletion)
                    })
                } catch {
                    print("Error deleting book, \(error)")
                }
            }
            self.loadToDo()
            print(#function)
    
        }
        
        let action2 = UIAlertAction(title: "キャンセル", style: .default) { (action) in
        }
        
        alert.addAction(action2)
        alert.addAction(action1)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Swipable
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let action = UIContextualAction(style: .destructive, title: "削除") { (action, view, completionHandler) in
            
            if let toDoForDeletion = self.toDo?[indexPath.row] {
                do {
                    try self.realm.write({
                        self.realm.delete(toDoForDeletion)
                    })
                } catch {
                    print("Error deleting book, \(error)")
                }
            }
            self.loadToDo()
            print(#function)
            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [action])
    }
        
    
    //MARK: - Add New ToDo
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "本のタイトルを入力してください", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "追加", style: .default) { (action) in
            
            let newToDo = ToDo()
            newToDo.title = textField.text ?? ""
            self.save(toDo: newToDo)
    
        }
        
        let action2 = UIAlertAction(title: "キャンセル", style: .default) { (action) in
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "タイトル"
            textField = alertTextField
        }
        
        alert.addAction(action2)
        alert.addAction(action1)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(toDo: ToDo){
        
        do {
            try realm.write{
                realm.add(toDo)
            }
        } catch {
            print("Error saving conetxt \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadToDo() {
        
        toDo = realm.objects(ToDo.self)

        tableView.reloadData()
    }
    
}
