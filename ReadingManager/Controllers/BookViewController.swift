
import UIKit
import RealmSwift

class BookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    var book: Results<Book>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadBook), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        loadBook()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "ReusableBookCell")
        
    }
    
    //MARK: - TableView Datasource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableBookCell", for: indexPath) as! BookCell
        
        let book = book?[indexPath.row]
        
        cell.title.text = book?.title ?? "本が追加されていません"
        cell.review.text = book?.review ?? ""
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToContent", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ContentViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedBook = book?[indexPath.row]
        }
    }
    
    //MARK: - TableView Swipable
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let action = UIContextualAction(style: .destructive, title: "削除") { (action, view, completionHandler) in
            
            if let bookForDeletion = self.book?[indexPath.row] {
                do {
                    try self.realm.write({
                        self.realm.delete(bookForDeletion)
                    })
                } catch {
                    print("Error deleting book, \(error)")
                }
            }
            self.loadBook()
            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [action])
    }
    
    //MARK: - Specify cell heightr
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }

        
    //MARK: - Add New book
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "本のタイトルを入力してください", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "追加", style: .default) { (action) in
            
            let newBook = Book()
            newBook.title = textField.text ?? ""
            newBook.review = "★★★☆☆"
            newBook.date = Date()
            newBook.dateView = ""
            newBook.category = ""
            newBook.overview = ""
            newBook.impression = ""
            newBook.comment = ""
            self.save(book: newBook)
    
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
    
    func save(book: Book){
        
        do {
            try realm.write{
                realm.add(book)
            }
        } catch {
            print("Error saving conetxt \(error)")
        }
        
        tableView.reloadData()
    }
    
    @objc func loadBook(){
        
        book = realm.objects(Book.self)

        tableView.reloadData()
    }
    

}

