//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Apple on 2017/07/27.
//  Copyright © 2017年 hiroshi.inoue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //画像の配列
    var images: [UIImage] = []
    var index = 0
    var timer: Timer?
   
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //配列に画像を追加
        images.append(UIImage(named: "image1.jpg")!)
        images.append(UIImage(named: "image2.jpg")!)
        images.append(UIImage(named: "image3.jpg")!)
        images.append(UIImage(named: "image4.png")!)
    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var startStop: UIButton!
    
    //再生ボタンを押した時のメソッド
    @IBAction func startStop(_ sender: UIButton) {
        //タイマーが止まっている時にスライド開始
        if self.timer == nil {
            backButton.isEnabled = false
            nextButton.isEnabled = false
            
            startStop.setTitle("停止", for: UIControlState.normal)
            
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: (#selector(play)), userInfo: nil, repeats: true)
            
        }else{
        //タイマーが動いている時スライド停止
            backButton.isEnabled = true
            nextButton.isEnabled = true
            
            startStop.setTitle("再生", for: UIControlState.normal)
            
            timer?.invalidate()
            timer = nil
            
                }
        
            }
    
    //スライドのメソッド
    func play(){
        if index < 3{
            index += 1
        }else{
            index = 0
        }
        imageView.image = images[index]
        //表示されている画像のログ表示
        print("index\(index)")
    }
    
    //進むボタンのメソッド
    func nextButton(_ sender: Any) {
        
        index += 1
        imageView.image = images[index]
        
        if index == 3 {
           index = 0
        }
    }
    
    //戻るボタンのメソッド
    func backButton(_ sender: Any) {
        
        index -= 1
        imageView.image = images[index]
        
        if index == 0{
            index = 3;
        }
    }
    
    @IBAction func closeUp(_ sender: Any) {
        
        performSegue(withIdentifier: "result", sender: nil)
    }
    
    //画面遷移のメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let secondViewController:SecondViewController = segue.destination as! SecondViewController
        
            secondViewController.image = self.imageView.image!
        
        //タップ時にスライド停止
        if self.timer != nil{
            timer?.invalidate()
            timer = nil
            startStop.setTitle("再生", for: UIControlState.normal)
            
            backButton.isEnabled = true
            nextButton.isEnabled = true
          
        }
        
    }

    @IBAction func unwind(_ segue: UIStoryboardSegue){
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

