import UIKit
import FirebaseAuth
import FirebaseDatabase

class ListarClientesViewController: UITableViewController {
    private var ref: DatabaseReference = Database.database().reference()
    
    private var clientes: [Cliente] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = ref.child("clientes").observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : NSDictionary] ?? [:]
            self.clientes = postDict.map { self.parsearCliente($0.value) }
            self.tableView.reloadData()
        })
    }
    
    private func parsearCliente(_ dictionary: NSDictionary) -> Cliente {
        return Cliente(nombre: dictionary.object(forKey: "nombre") as! String,
                       apellido: dictionary.object(forKey: "apellido") as! String,
                       edad: dictionary.object(forKey: "edad") as! String,
                       fechaNacimiento: dictionary.object(forKey: "fechaNacimiento") as! String)
    }
    
    @IBAction func alClickerSalir(_ sender: Any) {
        cerrarSesion()
        irALogin()
    }
    
    private func cerrarSesion() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    private func irALogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "AuthNavigationController")
        
        self.present(navigationController, animated: false, completion: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Label", for: indexPath)
        let cliente = clientes[indexPath.row]
        
        cell.textLabel?.text = "\(cliente.nombre) \(cliente.apellido)"
        cell.detailTextLabel?.text = "Edad: \(cliente.edad) Nacimiento: \(cliente.fechaNacimiento.description)"
        
        return cell
    }
}
