
import UIKit
import CoreData

class BookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    var books = [Books]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBooks()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "ReusableBookCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableBookCell", for: indexPath) as! BookCell
        
        let book = books[indexPath.row]
        
        cell.title.text = book.title
        cell.review.text = book.review
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Delete Item
//        context.delete(books[indexPath.row])
//        books.remove(at: indexPath.row)
        
        print(books[indexPath.row])
    }
    
    //MARK: - Add New Books
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "本の名前を入力してください", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "追加", style: .default) { (action) in
            
            let newBook = Books(context: self.context)
            newBook.title = textField.text
            newBook.review = "☆☆☆☆☆"
            self.books.append(newBook)
            self.saveBooks()
    
        }
        
        let action2 = UIAlertAction(title: "キャンセル", style: .default) { (action) in
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "新しい本"
            textField = alertTextField
        }
        
        alert.addAction(action2)
        alert.addAction(action1)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveBooks(){
        
        do {
            try context.save()
        } catch {
            print("Error saving conetxt \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadBooks(with request: NSFetchRequest<Books> = Books.fetchRequest(), predicate: NSPredicate? = nil){

        do {
            books = try context.fetch(request)
        } catch {
            print("Error fetching category from context \(error)")
        }
        
        tableView.reloadData()
    }
    

}

