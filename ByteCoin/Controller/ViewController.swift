//
//  ViewController.swift
//  ByteCoin
//
//  Created by Jaz on 21.01.22.
//  Copyright © 2022 The Coding Mermaid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var superView: UIView!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    let arrColour: [UIColor] = [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
    var index: Int = 0
    
        var coinManager = CoinManager()

    override func viewDidLoad() {
            super.viewDidLoad()
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(changeBackground), userInfo: nil, repeats: true)
            
            
            coinManager.delegate = self
            currencyPicker.dataSource = self
            currencyPicker.delegate = self
        
        
    }

//MARK: - Change of background function

    @objc func changeBackground() {
        
        UIView.animate(withDuration: 0.3) {
            self.superView.backgroundColor = self.arrColour[self.index]
        }
        
        self.index = self.index + 1
        
        if self.index >= arrColour.count {
            self.index = 0
        }
    }

}



    //MARK: - CoinManagerDelegate

    extension ViewController: CoinManagerDelegate {
        
        func didUpdatePrice(price: String, currency: String) {
            
            DispatchQueue.main.async {
                self.bitcoinLabel.text = price
                self.currencyLabel.text = currency
            }
        }
        
        func didFailWithError(error: Error) {
            print(error)
        }
    }

    //MARK: - UIPickerView DataSource & Delegate

    extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
              return 1
          }
          
          func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
              return coinManager.currencyArray.count
          }
          
          func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
              return coinManager.currencyArray[row]
          }
          
          func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
              let selectedCurrency = coinManager.currencyArray[row]
              coinManager.getCoinPrice(for: selectedCurrency)
          }
    }


