
import UIKit
import RealmSwift

class BookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    var book: Results<Book>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBook()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "ReusableBookCell")
        
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToContent", sender: self)
        print(book?[indexPath.row].title)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ContentViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedBook = book?[indexPath.row]
        }
    }
    
    //MARK: - Add New book
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "本のタイトルを入力してください", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "追加", style: .default) { (action) in
            
            let newBook = Book()
            newBook.title = textField.text ?? ""
            newBook.review = "☆☆☆☆☆"
            newBook.category = ""
            newBook.overview = ""
            newBook.impression = ""
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
    
    func loadBook(){
        
        book = realm.objects(Book.self)

        tableView.reloadData()
    }
    

}

