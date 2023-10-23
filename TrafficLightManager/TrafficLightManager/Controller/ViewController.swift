//
//  ViewController.swift
//  TrafficLightManager
//
//  Created by Naveed on 23/10/2023.
//

import UIKit

class ViewController: UIViewController {
    var timer: Timer?
    @IBOutlet var redLightView: UIView!
    @IBOutlet var yellowLightView: UIView!
    @IBOutlet var greenLightView: UIView!
    var counter = 11 {
        didSet {
            self.clearLight()
            manageTraficLight(counter: counter)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupLightsApearence() {
        redLightView.layer.cornerRadius = redLightView.frame.width / 2
        greenLightView.layer.cornerRadius = greenLightView.frame.width / 2
        yellowLightView.layer.cornerRadius = yellowLightView.frame.width / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startTimer()
        setupLightsApearence()
    }
    
    func startTimer() {
          timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
              guard let self = self else { return }
              self.counter -= 1
              if self.counter == 0 {
                  self.counter = 11
              }
          }
      }
    
    func manageTraficLight(counter: Int) {
        if counter >= 7 {
            redLightView.backgroundColor = .red
            CoreDataManager.shared.insertDataEntity(timestamp: Date(), text: "Light Changed-Red")
        } else if counter > 4 {
            yellowLightView.backgroundColor = .yellow
            CoreDataManager.shared.insertDataEntity(timestamp: Date(), text: "Light Changed-Yellow")
        } else {
            greenLightView.backgroundColor = .green
            CoreDataManager.shared.insertDataEntity(timestamp: Date(), text: "Light Changed-Green")
        }
    }
    
    func clearLight() {
        greenLightView.backgroundColor = .lightGray
        redLightView.backgroundColor = .lightGray
        yellowLightView.backgroundColor = .lightGray
    }
    
    @IBAction func resartButtonTapped(_ sender: UIButton) {
          counter = 11
        CoreDataManager.shared.insertDataEntity(timestamp: Date(), text: "Restart Pressed")
         startTimer()
    }
    
    @IBAction func historyButtonTapped(_ sender: UIButton) {
        timer?.invalidate()
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let newViewController = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController {
               self.navigationController?.pushViewController(newViewController, animated: true)
           }
    }

}

