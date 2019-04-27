import UIKit

var vSpinner : UIView?


extension UIViewController {
    func mostrarCargando(onView : UIView) {
        /* Tomado de http://brainwashinc.com/2017/07/21/loading-activity-indicator-ios-swift/ */
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func ocultarCargando() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    func mostrarError(error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
        
        self.present(alert, animated: true)
    }
}


