import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var textFieldCorreo: UITextField!
    @IBOutlet weak var textFieldContrasenia: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func alClickearAcceder(_ sender: UIButton) {
        guard let authModel = self.validarInputs() else { return }
        
        self.mostrarCargando(onView: self.view)
        
        Auth.auth().signIn(withEmail: authModel.correo,
                           password: authModel.constrasenia) { [weak self] user, error in
                            guard let strongSelf = self else { return }
                            strongSelf.ocultarCargando()
                            strongSelf.manejarRespuesta(error)
        }
    }
    
    private func manejarRespuesta(_ error: Error?) {
        if (error != nil) {
            self.mostrarError(error: error!)
        } else {
            self.irAListaClientes()
        }
    }
    
    private func validarInputs() -> AuthModel? {
        do {
            let email = try textFieldCorreo.validatedText(validationType: ValidatorType.email)
            let password = try textFieldContrasenia.validatedText(validationType: ValidatorType.password)
            
            return AuthModel(correo: email, constrasenia: password)
        } catch(let error) {
            self.mostrarError(error: error as! ValidationError)
        }
        
        return nil
    }
    
    private func irAListaClientes() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "MainNavigationController")
        
        self.present(navigationController, animated: false, completion: nil)
    }
}
