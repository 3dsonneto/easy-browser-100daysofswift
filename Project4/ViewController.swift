//
//  ViewController.swift
//  Project4
//
//  Created by Edson Neto on 06/04/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate { //Nosso ViewCOntroller extende UIViewController mas ele conforma-se aos protocolos do WKNavigationDelegate
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func loadView() {
        webView = WKWebView() //
        webView.navigationDelegate = self //Delegate é uma coisa agindo no lugar de outra, respondendo perguntas e respondendo a eventos. Nesse caso diz para o WKWebView que queremos ser informados quando algo de interessante acontecer. No caso o self diz que é para informar para esse ViewController
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)//o primeiro parametro é quem é o observer, qyual propriedade quer observar, qual valor queremos e o valor de context(envia o valor de volta quando muda)
        
        let url = URL(string: "https://" + websites[0])! //Swift guarda url num tipo especifico URL para aumentar as funcionalidades
        webView.load(URLRequest(url: url))//Coloca o url em um urlrequest porque diretamente não funciona
        webView.allowsBackForwardNavigationGestures = true //Permite arrastar para frente ou trás no navegador para voltar e avançar
    }
    
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        for website in websites{
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
            
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem //importante para ipad, diz ao ios onde o actionsheet vai ficar ancorado
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction){
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //decide se permite ou bloqueia navegar quando algo acontece(no nosso caso checar o url pra ver se vai deixar ou não). | O escaping nessa closure significa que o closure pode escapar do metodo atual e ser usado depois
        let url = navigationAction.request.url 
        if let host = url?.host{
            for website in websites{
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
            
        }
        
        decisionHandler(.cancel)
    }
}

