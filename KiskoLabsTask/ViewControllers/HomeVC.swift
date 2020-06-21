//
//  HomeVC.swift
//  KiskoLabsTask
//
//  Created by Hassan Shahid on 11/06/2020.
//  Copyright © 2020 Hassan Shahid. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit
import SwiftlyCache

class HomeVC: BaseVC {

    //MARK:- Variables
    var foodData: KiskoLabsFoodResponse!
    var refreshControl = UIRefreshControl()
    var navBar = UINavigationBar()
    var navTitle = UINavigationItem()
    lazy var txtSearch = UITextField()
    lazy var imgSearch = UIImageView()
    lazy var imgCross = UIImageView()
    lazy var btnCancel = UIButton()
    
    
    var tabBar = UITabBar()
    //TabBar Items
    let tabBarTitles = ["RESEPTIT", "ROUKALISTA", "OSTOSLISTA", "OMA SIVU"]
    let tabBarIcons = ["ic_star", "ic_knife_fork", "ic_bag", "ic_user"]
    
    //MARK:- Outlets
    @IBOutlet weak var tblFood: UITableView!
    
    //MARK:- Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //checking the cache value
        loadDefaults()
        
        // creating views programtically
        configureUI()
        
        tabBar.delegate = self
        
        //calling api
        loadData()
        
        //Show Proress bar on pulling the tableview
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tblFood.addSubview(refreshControl)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .light {
                return .darkContent
            } else {
                return .darkContent
            }
        } else {
            return .lightContent
        }
    }
    
    //MARK:- Functions
    func configureUI() {
        
        // Adding a Nav Bar Programtically
        navBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + 10,
            width: UIScreen.main.bounds.size.width, height: 50))
        navBar.barTintColor = UIColor.KiskoLabsTask_bg_main
        navBar.isTranslucent = false
        navTitle = UINavigationItem(title: "RESEPTIT")
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.KiskoLabsTask_tabBar_Selection]
        navBar.titleTextAttributes = textAttributes
        navBar.items = [navTitle]
        self.view.addSubview(navBar)
        
        // adding a search textfield Programtically
        txtSearch.layer.cornerRadius = 10
        txtSearch.layer.borderWidth = 1
        txtSearch.layer.borderColor = UIColor.gray.cgColor
        txtSearch.setLeftPaddingPoints(40)
        txtSearch.backgroundColor = UIColor.white
        txtSearch.placeholder = "Hae reseptija"
        self.view.addSubview(txtSearch)
        txtSearch.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(self.view.frame.width * 0.95)
            make.top.equalTo(navBar.snp.bottom).inset(0)
            make.centerXWithinMargins.equalToSuperview()
        }
        
        // adding a search icon as ImageView in the textfield Programtically
        imgSearch = UIImageView(image: UIImage(named: "ic_search")!)
        self.view.addSubview(imgSearch)
        imgSearch.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(20)
            make.width.equalTo(20)
            
            make.leading.equalTo(txtSearch.snp.leading).offset(10)
            make.centerY.equalTo(txtSearch)
        }
       
        // adding a cancel button Programtically in the textfield
        btnCancel.addTarget(self, action: #selector(btnCancelAction), for: .touchUpInside)
        self.view.addSubview(btnCancel)
        btnCancel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(20)
            make.width.equalTo(20)
            
            make.trailing.equalTo(txtSearch.snp.trailing).offset(-10)
            make.centerY.equalTo(txtSearch)
        }
        
        // adding cross imageView in the textfield Programtically
        imgSearch = UIImageView(image: UIImage(named: "ic_cancel")!)
        self.view.addSubview(imgSearch)
        imgSearch.snp.makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(btnCancel)
            make.centerY.equalTo(btnCancel)
            make.width.equalTo(btnCancel.snp.width).multipliedBy(0.6)
            make.height.equalTo(btnCancel.snp.height).multipliedBy(0.6)
        }
        
        
        // Adding a Tab Bar Programtically
        tabBar.barTintColor = UIColor.KiskoLabsTask_bg_main
        tabBar.isTranslucent = false
        tabBar.items = [] // initiliaze tabbar items array otherwise it's nil
        for i in 0..<4 {
            let tabItem = UITabBarItem(title: tabBarTitles[i], image: UIImage(named: tabBarIcons[i]), selectedImage: nil)
            tabBar.items?.append(tabItem)
        }
    
        tabBar.selectedItem = tabBar.items?[0] // selecting the first tab by deafult
        tabBar.unselectedItemTintColor = UIColor.KiskoLabsTask_tabBar_Deselection
        tabBar.tintColor = UIColor.KiskoLabsTask_tabBar_Selection

        self.view.addSubview(tabBar)
        tabBar.snp.makeConstraints { (make) -> Void in
            
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(UIApplication.shared.statusBarFrame.height + 50)
            make.width.equalToSuperview()
        }
        
    }
    
    func loadData() {
        
        startLoader()
        ServerManager.getPhotos(page: "1", query: "Food") { (status, data) in
            self.stopLoader()
            self.refreshControl.endRefreshing()
            if status == "success" {

                self.foodData = data
                let cache = MultiCache<KiskoLabsFoodResponse>()
                cache.set(forKey: CacheValue.foodData, value: data)
                self.tblFood.reloadData()
            }
            else
            {
                self.showAlert(message: status)
            }
            
        }
    }
    
    @objc func refresh(_ sender: Any) {
        loadData()
    }
    
    func loadDefaults(){
        
        //checking the cache value
        let cache = MultiCache<KiskoLabsFoodResponse>()
        
        if cache.object(forKey: CacheValue.foodData) != nil {
            let data = cache.object(forKey: CacheValue.foodData)
            foodData = data
        }
        else {
            foodData = nil
        }
    }
    
    //MARK:- Actions
   @objc func btnCancelAction(sender: UIButton!) {
      txtSearch.text = ""
      self.view.endEditing(true)
       
   }

}

//MARK:- UITablView DataSource
extension HomeVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let foodTCell = tableView.dequeueReusableCell(withIdentifier: "FoodTCell", for: indexPath) as! FoodTCell
        
        if indexPath.row == 0
        {
            foodTCell.lblTitle.text = "Valmitt roukalistat"
            foodTCell.cvFood.tag = 1
            foodTCell.cvFood.reloadData()
        }
        else
        {
            foodTCell.lblTitle.text = "Sinulle suositeltu"
            foodTCell.cvFood.tag = 2
            foodTCell.cvFood.reloadData()
        }
        return foodTCell
    }
    
    
}

//MARK:- UITablView Delegate
extension HomeVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
}
    

//MARK:- UCollectionView DataSource, Delegates and Flowlayout
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return foodData == nil ? 0 : foodData.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView.tag == 1
        {
            let readyFoodCCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReadyFoodCCell", for: indexPath) as! ReadyFoodCCell
            
            readyFoodCCell.imgFood.sd_imageIndicator = SDWebImageActivityIndicator.large
            
            readyFoodCCell.imgFood.sd_setImage(with: URL(string: foodData.results?[indexPath.row].urls?.regular ?? ""), placeholderImage: UIImage(named: "food_placeholder.png"))
            
            return readyFoodCCell
        }
        else
        {
            let recomendedFoodCCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecomendedFoodCCell", for: indexPath) as! RecomendedFoodCCell
            
            recomendedFoodCCell.imgFood.sd_imageIndicator = SDWebImageActivityIndicator.large
            
            recomendedFoodCCell.imgFood.sd_setImage(with: URL(string: foodData.results?[indexPath.row].urls?.thumb ?? ""), placeholderImage: UIImage(named: "food_placeholder.png"))
            
            return recomendedFoodCCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 1
        {
            let yourWidth = 300
            let yourHeight = 200
            return CGSize(width: yourWidth, height: yourHeight)
        }
        else
        {
            let yourWidth = 160
           let yourHeight = 240
            
            return CGSize(width: yourWidth, height: yourHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
    }
}

extension HomeVC: UITabBarDelegate{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item == tabBar.items![0] {
            
            navBar.topItem?.title = "RESEPTIT"
        }
        else if item == tabBar.items![1]{
            
            navBar.topItem?.title = "ROUKALISTA"
        }
        else if item == tabBar.items![2] {
            navBar.topItem?.title = "OSTOSLISTA"
        } else {
            navBar.topItem?.title = "OMA SIVU"
        }
    }
}
