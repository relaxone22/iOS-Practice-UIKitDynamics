//
//  ViewController.swift
//  iOS-UIKitDynamics-Practice
//
//  Created by tonyliu on 6/30/16.
//  Copyright © 2016 tonyliu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    @IBOutlet weak var collecctionView: UICollectionView!
    @IBOutlet weak var collecctionViewLayout: SpringCollectionViewFlowLayout!
    
    
    @IBOutlet weak var lblDampingNum: UILabel!
    @IBOutlet weak var lblFrequencyNum: UILabel!
    @IBOutlet weak var lblResistNum: UILabel!
    
    @IBOutlet weak var sliderDamping: UISlider!
    @IBOutlet weak var sliderFrequency: UISlider!
    @IBOutlet weak var sliderResist: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collecctionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
        self.updateLabelNumber()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 63
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("default", forIndexPath: indexPath) as UICollectionViewCell
        cell.backgroundColor = self.randomColor()
        return cell
    }
    
    // MARK: IBAction Methods
    @IBAction func dampingValueChanged(sender: UISlider) {
        self.collecctionViewLayout.springDamping = CGFloat(sender.value)
        self.updateLabelNumber()
    }
    
    @IBAction func frequencyValueChanged(sender: UISlider) {
        self.collecctionViewLayout.springFrequency = CGFloat(sender.value)
        self.updateLabelNumber()
    }
    
    @IBAction func resistValueChanged(sender: UISlider) {
        self.collecctionViewLayout.springResistanceFactor = CGFloat(sender.value)
        self.updateLabelNumber()
    }
    
    // MARK: Private Methods
    private func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    private func updateLabelNumber() {
        self.lblDampingNum.text   = String(format:"%.1f", self.sliderDamping.value)
        self.lblFrequencyNum.text = String(format:"%.1f", self.sliderFrequency.value)
        self.lblResistNum.text    = String(format:"%.f", self.sliderResist.value)
    }
}

