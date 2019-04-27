import UIKit
import FirebaseAuth

class ListarClientesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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

}
