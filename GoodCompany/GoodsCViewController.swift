
import UIKit
import ActionSheetPicker_3_0
import SwiftyJSON

var goodsReceipt: GoodsReceipt?

class GoodsCViewController: UIViewController {
    
    @IBOutlet weak var topTitle: UIButton!
    @IBOutlet weak var locationBtn: UIBarButtonItem!
    
    
    var cityId: Int!
    var index1 = 0
    
    var countryArr: [String] = []
    var countryIDArr: [Int] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //修改tabbar样式
        self.tabBarController?.tabBar.tintColor = Constants.COLOR_4
        ViewUtils.setShoppingCartNum(self, num: GoodDao().getCount())
        
        // 这个是必要的设置
        automaticallyAdjustsScrollViewInsets = false
        
        let location = UserUtils.getLocation()
        let locationName = UserUtils.getLocationName()
        if location == nil || location == 0 {
            cityId = 100
            locationBtn.title = "深圳市"
        } else {
            cityId = location
            locationBtn.title = locationName
        }
        
        var style = SegmentStyle()
        // 遮盖
        style.showCover = true
        // 颜色渐变
        style.gradualChangeTitleColor = true
        // 遮盖颜色
        style.coverBackgroundColor = UIColor.whiteColor()
        
        style.normalTitleColor = UIColor.init(netHex: 0xBBBBBB)
        style.selectedTitleColor = UIColor.init(netHex: 0x555555)
        
        style.titleMargin = 20
    
        style.scrollTitle = false
        
        let titles = setChildVcs().map { $0.title! }

        let scroll = ScrollPageView(frame: CGRect(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height - 64), segmentStyle: style, titles: titles, childVcs: setChildVcs(), parentViewController: self)
        view.addSubview(scroll)
        
        //定义接收用户数据变化的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GoodsCViewController.updateUser), name: "updateUser", object: nil)
        
        viewModel = GoodsCViewModel()
        
        updateUser()
        
        initData()
    }
    
    var json: JSON!
    
    func initData () {
        let path = NSBundle.mainBundle().pathForResource("../address", ofType: "json")
        let jsonStr = NSData(contentsOfFile: path!)
        json = JSON(data: jsonStr!)

        
        for (i, jsonObj) in json.array!.enumerate() {
            let name = jsonObj["name"].string
            let id = jsonObj["id"].int
            
            if cityId == id {
                index1 = i
            }
            
            countryArr.append(name!)
            countryIDArr.append(id!)
        }
        
    }
    
    @IBAction func addressSelect(sender: AnyObject) {
        
        
        let picker = ActionSheetStringPicker(title: "选择城市", rows: countryArr, initialSelection: index1, doneBlock: {
            picker, values, indexs in
            
            self.index1 = values
            
            UserUtils.setLocation(self.countryIDArr[values])
            UserUtils.setLocationName(self.countryArr[values])
            
            self.locationBtn.title = self.countryArr[values]
            
            //切换城市
            self.vc1?.cityId = self.countryIDArr[values]
            self.vc1?.updateCity()
            self.vc2?.cityId = self.countryIDArr[values]
            self.vc2?.updateCity()
            
            return
            }, cancelBlock: {
                block in
                
                return
            }, origin: sender)
        
        //城市选择
//        let picker = ActionSheetStringPicker.showPickerWithTitle("选择城市", rows: countryArr, initialSelection: index1, doneBlock: {
//                picker, values, indexs in
//            
//                self.index1 = values
//            
//                UserUtils.setLocation(self.countryIDArr[values])
//                UserUtils.setLocationName(self.countryArr[values])
//            
//                self.locationBtn.title = self.countryArr[values]
//            
//                //切换城市
//                self.vc1?.cityId = self.countryIDArr[values]
//                self.vc1?.updateCity()
//                self.vc2?.cityId = self.countryIDArr[values]
//                self.vc2?.updateCity()
//            
//                return
//            }, cancelBlock: {
//                block in
//            
//                return
//            }, origin: sender)
        
        picker.tapDismissAction = TapAction.Success
        
        picker.setDoneButton(UIBarButtonItem(title: "确定", style: .Plain, target: nil, action: nil))
        
        picker.setCancelButton(UIBarButtonItem(title: "取消", style: .Plain, target: nil, action: nil))
        
        picker.showActionSheetPicker()
        
    
    }
    
    func updateUser() {
        if UserUtils.getToken() != nil {
            viewModel?.getDefalutAddress()
        } else {
            topTitle.setTitle("有品有料，随叫随到", forState: UIControlState.Normal)
        }
    }
    
    var vc1: GoodsViewController!
    var vc2: GoodsViewController!
    
    func setChildVcs() -> [UIViewController] {
        
//        let vc0 = storyboard!.instantiateViewControllerWithIdentifier("GoodsViewControllerID") as! GoodsViewController
//        vc0.title = "推荐"
//        vc0.cId = 12
        
        vc1 = storyboard!.instantiateViewControllerWithIdentifier("GoodsViewControllerID") as! GoodsViewController
        vc1.title = "糖品"
        vc1.cId = 12
        vc1.cityId = cityId
        
        vc2 = storyboard!.instantiateViewControllerWithIdentifier("GoodsViewControllerID") as! GoodsViewController
        vc2.title = "米品"
        vc2.cId = 13
        vc2.cityId = cityId
        
//        let vc3 = storyboard!.instantiateViewControllerWithIdentifier("GoodsViewControllerID") as! GoodsViewController
//        vc3.title = "油品"
//        vc3.cId = 11
//        
//        let vc4 = storyboard!.instantiateViewControllerWithIdentifier("GoodsViewControllerID") as! GoodsViewController
//        vc4.title = "面品"
//        vc4.cId = 15
//        
//        let vc5 = storyboard!.instantiateViewControllerWithIdentifier("GoodsViewControllerID") as! GoodsViewController
//        vc5.title = "调味品"
//        vc5.cId = 16
        
        return [vc1, vc2]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var viewModel: GoodsCViewModel? {
        didSet {
            viewModel?.data?.observe {
                [weak self] in
                //self?.hideLoading()
                goodsReceipt = $0.b
                self?.bindAddress()
            }
            
            viewModel?.error?.observe {
                [weak self] in
                //self?.hideLoading()
                if $0.errorCode == Error.Code.NetworkRequestFailed {
                    self?.showError()
                }
            }
        }
    }
    
    func showError() {
    }
    
    func bindAddress() {
        if goodsReceipt == nil {
            return
        }
        topTitle.setTitle("配送至:" + (goodsReceipt?.addrRes?.detail)!, forState: UIControlState.Normal)
    }
    
    func showLoading() {
        ViewUtils.showLoading(view)
    }
    
    func hideLoading() {
        ViewUtils.hideLoading()
    }
}
