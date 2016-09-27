//
//  ViewController.swift
//  IntervalTimer
//
//  Created by Andrew Ehsaei on 3/23/15.
//  Copyright (c) 2015 ae. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate {

    var timer                 = NSTimer();
    var progressTimer         = NSTimer();
    var secondsInterval       = 0;
    var tensOfSecondsInterval = 0;
    var minutesInterval       = 0;
    var tensOfMinutesInterval = 0;
    var secondsCounter        = 0;
    var tensOfSecondsCounter  = 0;
    var minutesCounter        = 0;
    var tensOfMinutesCounter  = 0;
    var intervalHitCount      = 0;
    var onesDigits            = [0,1,2,3,4,5,6,7,8,9];
    var tensDigits            = [0,1,2,3,4,5];
    var progressAmount:Float  = 0.0;
    
    @IBOutlet weak var startButtonLabel: UIButton!
    @IBOutlet weak var IntervalLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // reset timer values to zero
        resetTimer();
        
        progressBar.setProgress(0.0, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func resetTimer() {
        secondsCounter       = 0;
        tensOfSecondsCounter = 0;
        minutesCounter       = 0;
        tensOfMinutesCounter = 0;
        intervalHitCount     = 0;
        updateDisplay();
    }
    @IBAction func Inputnumber(sender: UITextField) {
    }
    
    func updateDisplay() {
        seconds.text       = String(secondsCounter);
        tensOfSeconds.text = String(tensOfSecondsCounter);
        minutes.text       = String(minutesCounter);
        tensOfMinutes.text = String(tensOfMinutesCounter);
        IntervalLabel.text = "Interval \(intervalHitCount)";
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 4;
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch(component) {
            case 0:
                return tensDigits.count;
            case 1:
                return onesDigits.count;
            case 2:
                return tensDigits.count;
            case 3:
                return onesDigits.count;
            default:
                return 0;
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        switch(component) {
          case 0:
              return String(tensDigits[row]);
          case 1:
              return String(onesDigits[row]);
          case 2:
              return String(tensDigits[row]);
          case 3:
              return String(onesDigits[row]);
          default:
              return "Error";
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch(component) {
            case 0:
                tensOfMinutesInterval = tensDigits[row];
            case 1:
                minutesInterval       = onesDigits[row];
            case 2:
                tensOfSecondsInterval = tensDigits[row];
            case 3:
                secondsInterval       = onesDigits[row];
            default:
                NSLog("Error, invalid component");
        }
    
    }

    @IBAction func startButton(sender: UIButton) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("tick"), userInfo: nil, repeats: true);
        startButtonLabel.hidden = true;
        progressTimer = NSTimer.scheduledTimerWithTimeInterval(1.0
            , target: self, selector: Selector("progressUpdate"), userInfo: nil, repeats: true);
        
    }
    @IBAction func stopButton(sender: UIButton) {
        timer.invalidate();
        progressTimer.invalidate();
        progressBar.setProgress( progressAmount, animated: true);
        startButtonLabel.hidden = false;
    }
    @IBAction func resetButton(sender: UIButton) {
        timer.invalidate();
        progressTimer.invalidate();
        resetTimer();
        startButtonLabel.hidden = false;
    }
    @IBOutlet weak var seconds: UILabel!
    @IBOutlet weak var tensOfSeconds: UILabel!
    @IBOutlet weak var minutes: UILabel!
    @IBOutlet weak var tensOfMinutes: UILabel!

    func progressUpdate() {
        
        //progressAmount = (Float(secondsCounter) / Float(secondsInterval))/10;
        
        progressAmount += 0.1;
        
        NSLog("progressAmount=%2f, secondsCounter=%d, secondsInterval=%d", progressAmount, secondsCounter, secondsInterval);
        
        progressBar.setProgress( progressAmount, animated: true);

    }
    
    func tick() {
   
        if ( (tensOfMinutesCounter == tensOfMinutesInterval) &&
             (minutesCounter       == minutesInterval      ) &&
             (tensOfSecondsCounter == tensOfSecondsInterval) &&
             (secondsCounter       == secondsInterval      )    ) {
                
            intervalHitCount++;
            secondsCounter       = 0;
            tensOfSecondsCounter = 0;
            minutesCounter       = 0;
            tensOfMinutesCounter = 0;
            updateDisplay();
            
        } else if ( tensOfMinutesCounter == 5 &&
                    minutesCounter       == 9 &&
                    tensOfSecondsCounter == 5 &&
                    secondsCounter       == 9    ) {
            
            resetTimer();
            
        } else if ( minutesCounter       == 9 &&
                    tensOfSecondsCounter == 5 &&
                    secondsCounter       == 9    ) {
            
            tensOfMinutesCounter++;
            minutesCounter       = 0;
            tensOfSecondsCounter = 0;
            secondsCounter       = 0;
        
        } else if ( tensOfSecondsCounter == 5 &&
                    secondsCounter       == 9    ) {
        
            minutesCounter++;
            tensOfSecondsCounter = 0;
            secondsCounter       = 0;
        
        } else if ( secondsCounter == 9 ) {
        
            tensOfSecondsCounter++;
            secondsCounter       = 0;
        
        } else {
        
            secondsCounter++;
        }
        
        updateDisplay();
    
    }
    
    
}

